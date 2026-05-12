//
// Implementation Notes
// ––––––––––––––––––––
//
// Yes, with the Swift feature of integer generic parameters (SE-0452), we could write:
//
// `struct InRange<let lowerBound: Int, let upperBound: Int, Value: Collection>`
//
// But let’s be realistic: this is supported only from iOS 26+
//

/// A wrapper that ensures a collection's count falls within a closed range.
///
/// Returns `nil` if the collection's count is outside the bounds during initialization.
///
/// ## Example
/// ```
/// typealias OneThroughFive<Value: Collection> = InRange<RangeBoundOne, RangeBoundFive, Value>
///
/// typealias Numbers = OneThroughFive<Array<Int>>
///
/// let numbers: Numbers? = [2, 1, 4, 3]
/// ```
public struct InRange<LowerBound: RangeBound, UpperBound: RangeBound, Value: Collection>: MaybeWrapping {
    
    /// The underlying value, guaranteed to have a count within the specified range.
    public let value: Value
    
    /// Creates an instance by wrapping the given value, or returns `nil` if its count is out of bounds.
    public init?(_ value: Value) {
        let range = LowerBound.value...UpperBound.value
        guard range.contains(value.count) else { return nil }
        self.value = value
    }
    
}



// MARK: - Behavior Extensions

extension InRange: Equatable where Value: Equatable {}
extension InRange: Hashable where Value: Hashable {}
extension InRange: Sendable where Value: Sendable {}

