/// A wrapper that ensures a value falls within a closed range.
///
/// Returns `nil` if the value is outside the bounds during initialization.
///
/// ## Example 1
/// ```
/// typealias OneThroughFive<Value: Boundable> = Bounded<Bounds.`0`, Bounds.`5`, Value> where Value.Bound == Int
///
/// typealias Numbers = OneThroughFive<Array<Int>>
///
/// let numbers: Numbers? = [2, 1, 4, 3]
/// ```
///
/// ## Example 2
/// ```
/// typealias Child<Value: Boundable> = Bounded<Bounds.`0`, Bounds.`18`, Value> where Value.Bound == Int
///
/// if let child = Child(user) {
///     pediatricHospital.makeApointment(for: child)
/// }
/// ```
public struct Bounded<LowerBound: Bound, UpperBound: Bound, Value: Boundable>: MaybeWrapping where LowerBound.Value == UpperBound.Value, LowerBound.Value == Value.Bound {
    
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

extension Bounded: Sequence where Value: Sequence {}
extension Bounded: Collection where Value: Collection {}
extension Bounded: BidirectionalCollection where Value: BidirectionalCollection {}
extension Bounded: Equatable where Value: Equatable {}
extension Bounded: Hashable where Value: Hashable {}
extension Bounded: Sendable where Value: Sendable {}
extension Bounded: Codable where Value: Codable {}
