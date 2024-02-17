import Vision

extension VNBarcodeObservation {
  @objc override func toDict() -> [String: Any] {
    var dict: [String: Any] = [
      "payload_string_value": self.payloadStringValue,
      "symbology": self.symbology.toString(),
    ]
    if #available(iOS 17.0, macOS 14.0, *) {
      let additionalData: [String: Any] = [
        "payload_data": self.payloadData?.base64EncodedString(),
        "supplemental_payload_string_value": self.supplementalPayloadString,
        "supplemental_payload_data": self.supplementalPayloadData?.base64EncodedString(),
        "supplemental_composite_type": self.supplementalCompositeType.toString(),
        "payload_string_value": self.payloadStringValue,
        "is_gs1_data_carrier": self.isGS1DataCarrier,
        "is_color_inverted": self.isColorInverted,
      ]
      dict.merge(additionalData) { (old, _) in old }
    }

    return dict.merging(super.toDict()) { (old, _) in old }
  }
}

extension VNBarcodeSymbology {
  func toString() -> String {
    switch self {
    case .aztec: return "aztec"
    case .code39: return "code39"
    case .code39Checksum: return "code39Checksum"
    case .code39FullASCII: return "code39FullASCII"
    case .code39FullASCIIChecksum: return "code39FullASCIIChecksum"
    case .code93: return "code93"
    case .code93i: return "code93i"
    case .code128: return "code128"
    case .dataMatrix: return "dataMatrix"
    case .ean8: return "ean8"
    case .ean13: return "ean13"
    case .i2of5: return "i2of5"
    case .i2of5Checksum: return "i2of5Checksum"
    case .itf14: return "itf14"
    case .pdf417: return "pdf417"
    case .qr: return "qr"
    case .upce: return "upce"
    default: break
    }
    if #available(iOS 15.0, macOS 12.0, *) {
      switch self {
      case .gs1DataBar: return "gs1DataBar"
      case .gs1DataBarExpanded: return "gs1DataBarExpanded"
      case .gs1DataBarLimited: return "gs1DataBarLimited"
      case .microPDF417: return "microPDF417"
      case .microQR: return "microQR"
      default: break
      }
    }
    if #available(iOS 17.0, macOS 14.0, *) {
      switch self {
      case .msiPlessey: return "msiPlessey"
      default: break
      }
    }
    return "unknown"
  }
}

@available(iOS 17.0, macOS 14.0, *)
extension VNBarcodeCompositeType {
  func toString() -> String {
    switch self {
    case .gs1TypeA: return "gs1TypeA"
    case .gs1TypeB: return "gs1TypeB"
    case .gs1TypeC: return "gs1TypeC"
    case .linked: return "linked"
    case .none: return "none"
    }
  }
}
