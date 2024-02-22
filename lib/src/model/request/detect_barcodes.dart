import 'package:unified_apple_vision/src/enum/barcode_symbology.dart';
import 'package:unified_apple_vision/src/enum/request_type.dart';
import 'package:unified_apple_vision/src/model/observation/barcode.dart';

import 'image_based.dart';

/// **iOS 11.0+, macOS 10.13+**
///
/// A request that detects barcodes in an image.
///
/// This request returns an array of [VisionBarcodeObservation] objects, one for each barcode it detects.
///
class VisionDetectBarcodesRequest extends VisionImageBasedRequest {
  /// The barcode symbologies that the request detects in an image.
  ///
  /// By default, a request scans for all symbologies. Specify a subset of symbologies to limit the request’s detection range.
  final List<VisionBarcodeSymbology>? symbologies;

  /// **iOS 17.0+, macOS 14.0+**
  ///
  /// A Boolean value that indicates whether to coalesce multiple codes based on the symbology.
  final bool? coalesceCompositeSymbologies;

  const VisionDetectBarcodesRequest({
    this.symbologies,
    this.coalesceCompositeSymbologies,
    super.regionOfInterest,
    required super.onResults,
  }) : super(type: VisionRequestType.detectBarcodes);

  static List<VisionBarcodeSymbology> supportedSymbologies() {
    return [];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'symbologies': symbologies?.map((e) => e.name).toList(),
      'coalesce_composite_symbologies': coalesceCompositeSymbologies,
    };
  }
}
