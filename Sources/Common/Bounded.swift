/// A wrapper that ensures a value falls within a closed range.
///
/// Returns `nil` if the value is outside the bounds during initialization.
///
/// ## Example 1
/// ```
/// typealias OneThroughFive<Wrapped: Boundable> = Bounded<Bounds.`0`, Bounds.`5`, Wrapped> where Wrapped.Bound == Int
///
/// typealias Numbers = OneThroughFive<Array<Int>>
///
/// let numbers: Numbers? = [2, 1, 4, 3]
/// ```
///
/// ## Example 2
/// ```
/// typealias Child<Wrapped: Boundable> = Bounded<Bounds.`0`, Bounds.`18`, Wrapped> where Wrapped.Bound == Int
///
/// if let child = Child(user) {
///     pediatricHospital.makeApointment(for: child)
/// }
/// ```
public struct Bounded<LowerBound: Bound, UpperBound: Bound, Wrapped: Boundable>: MaybeWrapping where LowerBound.Value == UpperBound.Value, LowerBound.Value == Wrapped.Bound {
    
    /// The underlying value, guaranteed to be within the specified range.
    public let value: Wrapped
    
    /// Creates an instance by wrapping the given value, or returns `nil` if it is out of bounds.
    public init?(_ value: Wrapped) {
        let range = LowerBound.value...UpperBound.value
        guard value.isWithin(range) else { return nil }
        self.value = value
    }
    
}



// MARK: - Behavior Extensions

extension Bounded {

    public static func errorMessage(for value: Wrapped) -> String {
        return "Value '\(value)' must be within bounds \(LowerBound.value...UpperBound.value)"
    }
    
}


extension Bounded: Sequence where Wrapped: Sequence {}
extension Bounded: Collection where Wrapped: Collection {}
extension Bounded: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Bounded: Equatable where Wrapped: Equatable {}
extension Bounded: Hashable where Wrapped: Hashable {}
extension Bounded: Sendable where Wrapped: Sendable {}
extension Bounded: Codable where Wrapped: Codable {}
