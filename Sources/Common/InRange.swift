/// A wrapper that ensures a value falls within a closed range.
///
/// Returns `nil` if the value is outside the bounds during initialization.
///
/// ## Example 1
/// ```
/// typealias OneThroughFive<Value: Rangable> = InRange<RangeBounds.`0`, RangeBounds.`5`, Value>
///
/// typealias Numbers = OneThroughFive<Array<Int>>
///
/// let numbers: Numbers? = [2, 1, 4, 3]
/// ```
///
/// ## Example 2
/// ```
/// typealias Child<Value: Rangable> = InRange<RangeBounds.`0`, RangeBounds.`18`, Value>
///
/// if let child = Child(user) {
///     pediatricHospital.makeApointment(for: child)
/// }
/// ```
public struct InRange<LowerBound: RangeBound, UpperBound: RangeBound, Value: Rangable>: MaybeWrapping where LowerBound.Value == UpperBound.Value, LowerBound.Value == Value.RangeBound {
    
    /// The underlying value, guaranteed to be within the specified range.
    public let value: Value
    
    /// Creates an instance by wrapping the given value, or returns `nil` if it is out of bounds.
    public init?(_ value: Value) {
        let range = LowerBound.value...UpperBound.value
        guard value.isWithin(range) else { return nil }
        self.value = value
    }
    
}



// MARK: - Behavior Extensions

extension InRange: Equatable where Value: Equatable {}
extension InRange: Hashable where Value: Hashable {}
extension InRange: Sendable where Value: Sendable {}
