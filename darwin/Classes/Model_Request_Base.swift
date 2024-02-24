class BaseRequest {
  let requestId: String

  init(requestId: String) {
    self.requestId = requestId
  }

  init(copy: BaseRequest) {
    self.requestId = copy.requestId
  }

  convenience init(json: Json) throws {
    self.init(requestId: try json.str("request_id"))
  }
}
