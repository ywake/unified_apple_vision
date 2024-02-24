import re
from pathlib import Path
import argparse
import shutil


def main():
    # Create the parser
    parser = argparse.ArgumentParser(
        description='Create files for a new Vision request or observation')
    parser.add_argument('command',
                        help='`request` or `observation`')
    parser.add_argument(
        '-n', '--name', required=True, help='Name of the request or observation. e.g. "VNRecognizeTextRequest" or "VNRectangleObservation"')
    parser.add_argument(
        '--ios', default='11.0', help='Require version of iOS. e.g. "11.0"')
    parser.add_argument(
        '--macos', default='10.13', help='Require version of macOS. e.g. "10.13"')
    parser.add_argument(
        '--extends', help='(for observation only) Name of the parent class. e.g. "VNDetectedObjectObservation"'
    )
    # Command
    args = parser.parse_args()
    if args.command == 'request':
        request_creation(args.name, args.ios, args.macos)
    elif args.command == 'observation':
        if args.extends:
            observation_creation(args.name, args.ios, args.macos, args.extends)
        else:
            print('Missing `--extends` argument')
            return
    # allow empty input
    res = input('Do you want to delete the cache? (Y/n)')
    if res.lower() == 'y' or res == '':
        delete_cache()
    print('Done! 🎉')

    # if input().lower() == 'y' or input() == '':
    #     delete_cache()


def request_creation(class_name: str, ios: str, macos: str):
    # Extract the meaningful part of the class name
    if not class_name.startswith('VN') or not class_name.endswith('Request'):
        print('Invalid class name. e.g. "VNDetectRectanglesRequest"')
        return
    # Removes 'VN' prefix and 'Request' suffix
    request_pascal = class_name[2:-7]
    dart_path = f'src/model/request/{pascal_to_snake_case(request_pascal)}.dart'
    create_file(
        f'lib/{dart_path}',
        dart_request_template(request_pascal, ios, macos)
    )
    append_export(dart_path)
    add_getter(request_pascal)
    create_file(
        f'darwin/Classes/Model_Request_{request_pascal}.swift',
        swift_request_template(request_pascal, ios, macos)
    )
    append_to_swift_enum(request_pascal)


def observation_creation(class_name: str, ios: str, macos: str, extends: str):
    # Extract the meaningful part of the class name
    if not class_name.startswith('VN') or not class_name.endswith('Observation'):
        print('Invalid class name. e.g. "VNRectangleObservation"')
        return
    if not extends.startswith('VN') or not extends.endswith('Observation'):
        print('Invalid parent class name. e.g. "VNDetectedObjectObservation"')
        return
    # Removes 'VN' prefix and 'Observation' suffix
    observation_pascal = class_name[2:-11]
    extends_pascal = extends[2:-11]
    dart_path = f'src/model/observation/{pascal_to_snake_case(observation_pascal)}.dart'
    create_file(
        f'lib/{dart_path}',
        dart_observation_template(observation_pascal, extends_pascal)
    )
    append_export(dart_path)
    create_file(
        f'example/lib/extension/observations/vision_{pascal_to_snake_case(observation_pascal)}_observation.dart',
        dart_observation_extension_template(observation_pascal)
    )
    create_file(
        f'darwin/Classes/Extension_Observation_{class_name}.swift',
        swift_observation_template(class_name, ios, macos)
    )


def delete_cache():
    cache_dir = 'example/build'
    shutil.rmtree(cache_dir, ignore_errors=True)


def create_file(path: str, content: str):
    file_path = Path(path)
    file_path.parent.mkdir(parents=True, exist_ok=True)
    if not file_path.exists():
        file_path.write_text(content)
        print(f'File created: {file_path}')
    else:
        print(f'File already exists: {file_path}')


def pascal_to_snake_case(name: str):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()


def pascal_to_camel_case(name: str):
    return name[0].lower() + name[1:]


def append_export(file_path: str):
    lib_path = 'lib/unified_apple_vision.dart'
    with open(lib_path, 'r') as file:
        lines = file.readlines()
    if f"export '{file_path}';\n" in lines:
        print(f'Already exported: {file_path}')
        return
    with open(lib_path, 'a') as file:
        file.write(f"export '{file_path}'; Sort this!\n")
    print(f'Exported: {file_path}')


def add_getter(request_pascal: str):
    results_path = 'lib/src/model/results.dart'
    with open(results_path, 'a') as file:
        file.write(f"""
  List<VisionSomeObservation> get of{request_pascal}Request =>
      observations.whereType<VisionSomeObservation>().toList();
""")


def append_to_swift_enum(request_pascal: str):
    swift_enum_path = 'darwin/Classes/Enum_RequestType.swift'
    with open(swift_enum_path, 'r') as file:
        lines = file.readlines()
    states = [
        ModeState("start", "enum"),
        ModeState("case1", "  case"),
        ModeState("between", "\n"),
        ModeState("case2", "    case "),
        ModeState("end", "    }")
    ]
    current_states = 0
    def isLastState(): return current_states + 1 >= len(states)
    def isNewStateComing(
        line: str): return line.startswith(states[current_states + 1].startSign)
    new_lines = []
    define_enum_value = f'  case {pascal_to_camel_case(request_pascal)} = "{pascal_to_snake_case(request_pascal)}"\n'
    case_this = f'    case .{pascal_to_camel_case(request_pascal)}:\n'
    return_request = f'      return try {request_pascal}Request(json: json)\n'
    for line in lines:
        # state machine
        if not isLastState() and isNewStateComing(line):
            if states[current_states].mode == "case1":  # last of the case1
                new_lines.append(define_enum_value)
            elif states[current_states].mode == "case2":  # last of the case2
                new_lines.append(case_this)
                new_lines.append(return_request)
            current_states += 1  # increment the state
        new_lines.append(line)
    # write the new lines to the file
    with open(swift_enum_path, 'w') as file:
        file.writelines(new_lines)
    if new_lines.__len__() == lines.__len__() + 3:
        print(f'Appended to: {swift_enum_path}')
    else:
        print(f'Failed to append to: {swift_enum_path}')


class ModeState:
    def __init__(self, mode: str, startSign: str):
        self.mode = mode
        self.startSign = startSign


def dart_request_template(request_pascal: str, ios: str, macos: str) -> str:
    return f"""
import 'package:unified_apple_vision/src/enum/request_type.dart';

import 'image_based.dart';

/// **iOS {ios}+, macOS {macos}+**
class Vision{request_pascal}Request extends VisionImageBasedRequest {{
  const Vision{request_pascal}Request({{
    super.regionOfInterest,
    required super.onResults,
  }}) : super(type: VisionRequestType.{pascal_to_camel_case(request_pascal)});

  @override
  Map<String, dynamic> toMap() {{
    return {{
      ...super.toMap(),
    }};
  }}
}}
""".strip()


def swift_request_template(request_pascal: str, ios: str, macos: str) -> str:
    return f"""
import Vision

class {request_pascal}Request: ImageBasedRequest, AnalyzeRequest {{
  init(
    parent: ImageBasedRequest,
  ) {{
    super.init(copy: parent)
  }}

  convenience init(json: Json) throws {{
    self.init(
      parent: try ImageBasedRequest(json: json)
    )
  }}

  func type() -> RequestType {{
    return .{pascal_to_camel_case(request_pascal)}
  }}

  func id() -> String {{
    return self.requestId
  }}

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) throws -> VNRequest {{
    if #available(iOS {ios}, macOS {macos}, *) {{
      return _makeRequest(handler)
    }} else {{
      throw PluginError.unsupportedPlatform(iOS: "{ios}", macOS: "{macos}")
    }}
  }}

  @available(iOS {ios}, macOS {macos}, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VN{request_pascal}Request
  {{
    let request = VN{request_pascal}Request(completionHandler: handler)
    return request
  }}

  func encodeResult(_ result: [VNObservation]) -> [[String: Any]] {{
    Logger.d("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map {{ ($0 as? VN/* FIXME */Observation)?.toDict() ?? [:] }}
  }}
}}
""".strip()


def dart_observation_template(observation_pascal: str, extends_pascal: str) -> str:
    return f"""
import 'package:unified_apple_vision/src/utility/json.dart';

import '{pascal_to_snake_case(extends_pascal) if extends_pascal else 'observation'}.dart';

class Vision{observation_pascal}Observation extends Vision{extends_pascal}Observation {{
  Vision{observation_pascal}Observation.withParent({{
    required Vision{extends_pascal}Observation parent,
  }}) : super.clone(parent);

  Vision{observation_pascal}Observation.clone(Vision{observation_pascal}Observation other)
      : this.withParent(parent: other);

  factory Vision{observation_pascal}Observation.fromJson(Json json) {{
    return Vision{observation_pascal}Observation.withParent(
      parent: Vision{extends_pascal}Observation.fromJson(json),
    );
  }}
}}
""".strip()


def dart_observation_extension_template(observation_pascal: str) -> str:
    return f"""
import 'package:flutter/material.dart';
import 'package:unified_apple_vision/unified_apple_vision.dart';

import 'vision_observation.dart';

extension Vision{observation_pascal}ObservationEx on Vision{observation_pascal}Observation {{
  Widget build() => customPaint(_Painter(this));
}}

class _Painter extends CustomPainter {{
  final Vision{observation_pascal}Observation observation;

  _Painter(this.observation);

  @override
  void paint(Canvas canvas, Size size) {{
  }}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {{
    return false;
  }}
}}
""".strip()


def swift_observation_template(class_name: str, ios: str, macos: str) -> str:
    return f"""
import Vision

@available(iOS {ios}, macOS {macos}, *)
extension {class_name} {{
  @objc override func toDict() -> [String: Any] {{
    return [
    ] + super.toDict()
  }}
}}
""".strip()


if __name__ == "__main__":
    main()
