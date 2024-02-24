import Foundation

class ImageBasedRequest: BaseRequest {
  let regionOfInterest: CGRect?

  init(
    parent: BaseRequest,
    regionOfInterest: CGRect?
  ) {
    self.regionOfInterest = regionOfInterest
    super.init(copy: parent)
  }

  init(copy: ImageBasedRequest) {
    self.regionOfInterest = copy.regionOfInterest
    super.init(copy: copy)
  }

  convenience init(json: Json) throws {
    let rect = json.jsonOr("region_of_interest")
    self.init(
      parent: try BaseRequest(json: json),
      regionOfInterest: rect == nil ? nil : try CGRect(json: rect!)
    )
  }
}
