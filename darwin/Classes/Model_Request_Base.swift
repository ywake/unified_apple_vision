class BaseRequest {
  let requestId: String

  init(requestId: String) {
    self.requestId = requestId
  }

  convenience init(copy: BaseRequest) {
    self.init(requestId: copy.requestId)
  }

  convenience init(json: Json) throws {
    self.init(requestId: try json.str("request_id"))
  }
}
