import sys
import re
from pathlib import Path


def main():
    if len(sys.argv) != 2:
        print("Usage: tools.py VNClassNameRequest")
    else:
        create_files(sys.argv[1])


def pascal_to_snake_case(name: str):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()


def pascal_to_camel_case(name: str):
    return name[0].lower() + name[1:]


def create_files(class_name: str):
    # Extract the meaningful part of the class name
    if not class_name.startswith('VN') or not class_name.endswith('Request'):
        print('Invalid class name. e.g. "VNDetectRectanglesRequest"')
        return
    # Removes 'VN' prefix and 'Request' suffix
    request_pascal = class_name[2:-7]
    create_file(
        f'lib/src/model/request/{pascal_to_snake_case(request_pascal)}.dart',
        dart_template(request_pascal)
    )
    create_file(
        f'darwin/Classes/Model_{request_pascal}Request.swift',
        swift_request_template(request_pascal)
    )
    create_file(
        f'darwin/Classes/Model_{request_pascal}Results.swift',
        swift_results_template(request_pascal)
    )
    print(f'File created')


def create_file(path: str, content: str):
    file_path = Path(path)
    file_path.parent.mkdir(parents=True, exist_ok=True)
    if not file_path.exists():
        file_path.write_text(content)


def dart_template(request_pascal: str) -> str:
    return f"""
import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/request/analysis_request.dart';

class Vision{request_pascal}Request extends AnalysisRequest {{
  const Vision{request_pascal}Request() : super(type: VisionRequestType.{pascal_to_camel_case(request_pascal)});

  @override
  Map<String, dynamic> toMap() {{
    throw UnimplementedError();
  }}
}}
""".strip()


def swift_request_template(request_pascal: str) -> str:
    return f"""
import Vision

class {request_pascal}Request: AnalyzeRequest {{

  init() {{}}

  convenience init?(_ arg: [String: Any]?) {{
    guard let arg = arg else {{ return nil }}
    self.init()
  }}

  func type() -> RequestType {{
    return .{pascal_to_camel_case(request_pascal)}
  }}

  func makeRequest(_ handler: @escaping VNRequestCompletionHandler) -> VNRequest? {{
    if #available(iOS 13.0, macOS 10.15, *) {{
      return _makeRequest(handler)
    }} else {{
      Logger.error(
        "{request_pascal}Request requires iOS 13.0+ or macOS 10.15+",
        "\(self.type().rawValue)>makeRequest"
      )
      return nil
    }}
  }}

  @available(iOS 13.0, macOS 10.15, *)
  private func _makeRequest(_ handler: @escaping VNRequestCompletionHandler)
    -> VN{request_pascal}Request
  {{
    // TODO: Implement
    let request = VN{request_pascal}Request(completionHandler: handler)
    return request
  }}

  func makeResults(_ observations: [VNObservation]) -> AnalyzeResults? {{
    if #available(iOS 13.0, macOS 10.15, *) {{
      // TODO: Implement
      return {request_pascal}Results(
        observations as! [VN{request_pascal}Observation]
      )
    }} else {{
      Logger.error(
        "{request_pascal}Request requires iOS 13.0+ or macOS 10.15+",
        "\(self.type().rawValue)>makeResults"
      )
      return nil
    }}
  }}
}}
""".strip()


def swift_results_template(request_pascal: str) -> str:
    return f"""
import Vision

@available(iOS 13.0, macOS 10.15, *)
class {request_pascal}Results: AnalyzeResults {{
  let observations: [VN{request_pascal}Observation]

  init(_ observations: [VN{request_pascal}Observation]) {{
    self.observations = observations
  }}

  func type() -> RequestType {{
    return .{pascal_to_camel_case(request_pascal)}
  }}

  func toDict() -> [[String: Any]] {{
    return [
      "observations": self.observations.map {{ observation in
        return observation.toDict()
      }}
    ]
  }}
}}
""".strip()


if __name__ == "__main__":
    main()
