import 'dart:convert';
import 'dart:typed_data';

import 'package:unified_apple_vision/src/enum/barcode_composite_type.dart';
import 'package:unified_apple_vision/src/enum/barcode_symbology.dart';
import 'package:unified_apple_vision/src/model/request/detect_barcodes.dart';

import 'rectangle.dart';

/// An object that represents barcode information that an image analysis request detects.
///
/// This type of observation results from a [VisionDetectBarcodesRequest]. It contains information about the detected barcode, including parsed payload data for supported symbologies.
class VisionBarcodeObservation extends VisionRectangleObservation {
  /// A string value that represents the barcode payload.
  ///
  /// Depending on the symbology or the payload data itself, a string representation of the payload may not be available.
  final String? payloadStringValue;

  /// **iOS 17.0+, macOS 14.0+**
  ///
  /// The raw data representation of the barcode’s payload.
  final Uint8List? payloadData;

  /// **iOS 17.0+, macOS 14.0+**
  ///
  /// The supplemental code decoded as a string value.
  final String? supplementalPayloadString;

  /// **iOS 17.0+, macOS 14.0+**
  final Uint8List? supplementalPayloadData;

  /// **iOS 17.0+, macOS 14.0+**
  /// The supplemental composite type.
  final VisionBarcodeCompositeType? supplementalCompositeType;

  /// **iOS 17.0+, macOS 14.0+**
  ///
  /// A Boolean value that indicates whether the barcode carries any global standards data.
  final bool? isGS1DataCarrier;

  /// The symbology of the observed barcode.
  final VisionBarcodeSymbology symbology;

  /// **iOS 17.0+, macOS 14.0+**
  /// A Boolean value that indicates whether the barcode is color inverted.
  final bool? isColorInverted;

  VisionBarcodeObservation.withParent({
    required VisionRectangleObservation parent,
    this.payloadStringValue,
    this.payloadData,
    this.supplementalPayloadString,
    this.supplementalPayloadData,
    this.supplementalCompositeType,
    this.isGS1DataCarrier,
    required this.symbology,
    this.isColorInverted,
  }) : super.clone(parent);

  VisionBarcodeObservation.clone(VisionBarcodeObservation other)
      : this.withParent(
          parent: other,
          payloadStringValue: other.payloadStringValue,
          payloadData: other.payloadData,
          supplementalPayloadString: other.supplementalPayloadString,
          supplementalPayloadData: other.supplementalPayloadData,
          supplementalCompositeType: other.supplementalCompositeType,
          isGS1DataCarrier: other.isGS1DataCarrier,
          symbology: other.symbology,
          isColorInverted: other.isColorInverted,
        );

  factory VisionBarcodeObservation.fromMap(Map<String, dynamic> map) {
    final payloadStringValue = map['payload_string_value'] as String?;
    final payloadDataBase64 = map['payload_data'] as String?;
    final payloadData =
        payloadDataBase64 == null ? null : base64.decode(payloadDataBase64);
    final supplementalPayloadString =
        map['supplemental_payload_string'] as String?;
    final supplementalPayloadDataBase64 =
        map['supplemental_payload_data'] as String?;
    final supplementalPayloadData = supplementalPayloadDataBase64 == null
        ? null
        : base64.decode(supplementalPayloadDataBase64);
    final supplementalCompositeTypeStr =
        map['supplemental_composite_type'] as String?;
    final supplementalCompositeType = supplementalCompositeTypeStr == null
        ? null
        : VisionBarcodeCompositeType.values
            .byName(supplementalCompositeTypeStr);
    final isGS1DataCarrier = map['is_gs1_data_carrier'] as bool?;
    final symbologyStr = map['symbology'] as String?;
    final symbology = symbologyStr == null
        ? null
        : VisionBarcodeSymbology.values.byName(symbologyStr);
    final isColorInverted = map['is_color_inverted'] as bool?;

    if (symbology == null) {
      throw Exception('Failed to parse VisionBarcodeObservation');
    }

    return VisionBarcodeObservation.withParent(
      parent: VisionRectangleObservation.fromMap(map),
      payloadStringValue: payloadStringValue,
      payloadData: payloadData,
      supplementalPayloadString: supplementalPayloadString,
      supplementalPayloadData: supplementalPayloadData,
      supplementalCompositeType: supplementalCompositeType,
      isGS1DataCarrier: isGS1DataCarrier,
      symbology: symbology,
      isColorInverted: isColorInverted,
    );
  }
}
