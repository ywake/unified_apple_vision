/// Dictionary merge operator
func + <K, V>(left: [K: V], right: [K: V]) -> [K: V] {
  return left.merging(right) { _, new in new }
}

func += <K, V>(left: inout [K: V], right: [K: V]) {
  left = left + right
}
