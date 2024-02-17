enum VisionBarcodeCompositeType {
  /// A type that represents trade items in bulk.
  gs1TypeA,

  /// A type that represents trade items by piece.
  gs1TypeB,

  /// A type that represents trade items in varying quantity.
  gs1TypeC,

  /// A type that represents a linked composite type.
  linked,

  /// A type that represents no composite type.
  none,
  ;
}
