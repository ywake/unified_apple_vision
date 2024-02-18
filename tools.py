import re
from pathlib import Path
import argparse


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
    # Command
    args = parser.parse_args()
    if args.command == 'request':
        request_creation(args.name, args.ios, args.macos)
    elif args.command == 'observation':
        observation_creation(args.name, args.ios, args.macos)


def request_creation(class_name: str, ios: str, macos: str):
    # Extract the meaningful part of the class name
    if not class_name.startswith('VN') or not class_name.endswith('Request'):
        print('Invalid class name. e.g. "VNDetectRectanglesRequest"')
        return
    # Removes 'VN' prefix and 'Request' suffix
    request_pascal = class_name[2:-7]
    create_file(
        f'lib/src/model/request/{pascal_to_snake_case(request_pascal)}.dart',
        dart_request_template(request_pascal)
    )
    create_file(
        f'darwin/Classes/Model_Request_{request_pascal}.swift',
        swift_request_template(request_pascal, ios, macos)
    )
    print('Files created')


def observation_creation(class_name: str, ios: str, macos: str):
    # Extract the meaningful part of the class name
    if not class_name.startswith('VN') or not class_name.endswith('Observation'):
        print('Invalid class name. e.g. "VNRectangleObservation"')
        return
    # Removes 'VN' prefix and 'Observation' suffix
    observation_pascal = class_name[2:-11]
    create_file(
        f'lib/src/model/observation/{pascal_to_snake_case(observation_pascal)}.dart',
        dart_observation_template(observation_pascal)
    )
    create_file(
        f'darwin/Classes/Extension_{class_name}.swift',
        swift_observation_template(class_name, ios, macos)
    )
    print('Files created')


def create_file(path: str, content: str):
    file_path = Path(path)
    file_path.parent.mkdir(parents=True, exist_ok=True)
    if not file_path.exists():
        file_path.write_text(content)


def pascal_to_snake_case(name: str):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()


def pascal_to_camel_case(name: str):
    return name[0].lower() + name[1:]


def dart_request_template(request_pascal: str, ios: str, macos: str) -> str:
    return f"""
import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/request/analysis_request.dart';

/// **iOS {ios}+, macOS {macos}+**
class Vision{request_pascal}Request extends AnalysisRequest {{
  const Vision{request_pascal}Request()
    : super(type: VisionRequestType.{pascal_to_camel_case(request_pascal)});

  @override
  Map<String, dynamic> toMap() {{
    throw UnimplementedError();
  }}
}}
""".strip()


def swift_request_template(request_pascal: str, ios: str, macos: str) -> str:
    return f"""
import Vision

class {request_pascal}Request: AnalyzeRequest {{
  let requestId: String

  init(
    requestId: String
  ) {{
    self.requestId = requestId 
  }}

  convenience init?(_ arg: [String: Any]?) {{
    guard let arg = arg else {{ return nil }}
    self.init()
  }}

  func type() -> RequestType {{
    return .{pascal_to_camel_case(request_pascal)}
  }}

  func id() -> String {{
    return self.requestId
  }}

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {{
    if #available(iOS {ios}, macOS {macos}, *) {{
      return _makeRequest(handler)
    }} else {{
      Logger.error(
        "{request_pascal}Request requires iOS {ios}+ or macOS {macos}+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
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
    Logger.debug("Encoding: \(self.type().rawValue)", "\(self.type().rawValue)>encodeResult")
    return result.map {{ ($0 as? VN_Observation).toDict() ?? [:] }}
  }}
}}
""".strip()


def dart_observation_template(observation_pascal: str) -> str:
    return f"""
class Vision{observation_pascal}Observation extends VisionObservation {{
  Vision{observation_pascal}Observation.withParent({{
    required VisionObservation parent,
  }}) : super.clone(parent);

  Vision{observation_pascal}Observation.clone(Vision{observation_pascal}Observation other)
      : this.withParent(parent: other);

  factory Vision{observation_pascal}Observation.fromJson(Json json) {{
    return Vision{observation_pascal}Observation.withParent(
      parent: VisionObservation.fromJson(json),
    );
  }}
}}
""".strip()


def swift_observation_template(class_name: str, ios: str, macos: str) -> str:
    return f"""
import Vision

extension {class_name} {{
  @objc override func toDict() -> [String: Any] {{
    return [
    ].merging(super.toDict()) {{ (old, _) in old }}
  }}
}}
""".strip()


if __name__ == "__main__":
    main()
