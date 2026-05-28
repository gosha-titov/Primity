/// A wrapper that ensures a value falls within a closed range.
///
/// Returns `nil` if the value is outside the bounds during initialization.
///
/// ## Example 1
/// ```
/// typealias OneThroughFive<Wrapped: Withinable> = Within<`1`, `5`, Wrapped> where Wrapped.Bound == Int
///
/// typealias Numbers = OneThroughFive<Array<Int>>
///
/// let numbers: Numbers? = [2, 1, 4, 3]
/// ```
///
/// ## Example 2
/// ```
/// typealias Child<Wrapped: Withinable> = Within<`0`, `18`, Wrapped> where Wrapped.Bound == Int
///
/// if let child = Child(user) {
///     pediatricHospital.makeApointment(for: child)
/// }
/// ```
public struct Within<LowerBound: Bound, UpperBound: Bound, Wrapped: Withinable>: MaybeWrapping where LowerBound.Value == UpperBound.Value, LowerBound.Value == Wrapped.Bound {
    
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

extension Within {

    public static func errorMessage(for value: Wrapped) -> String {
        return "Value '\(value)' must be within bounds \(LowerBound.value...UpperBound.value)"
    }
    
}


extension Within: Sequence where Wrapped: Sequence {}
extension Within: Collection where Wrapped: Collection {}
extension Within: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Within: Equatable where Wrapped: Equatable {}
extension Within: Hashable where Wrapped: Hashable {}
extension Within: Sendable where Wrapped: Sendable {}
extension Within: Codable where Wrapped: Codable {}
