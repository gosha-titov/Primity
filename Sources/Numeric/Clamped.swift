/// A wrapper that clamps its value to a closed range.
///
/// ## Example 1
/// ```
/// typealias Progress = Clamped<`0.0`, `1.0`, Double>
///
/// let progress: Progress = 0.97
/// ```
///
/// ## Example 2
/// ```
/// typealias Percentage = Clamped<`0`, `100`, Int>
///
/// let percentage: Percentage = 97
/// ```
public struct Clamped<LowerBound: Bound, UpperBound: Bound, Wrapped: Clampable>: Wrapping where LowerBound.Value == UpperBound.Value, LowerBound.Value == Wrapped.Bound {
    
    /// The underlying clamped value.
    public let value: Wrapped
    
    /// Creates an instance by clamping the given value.
    public init(_ value: Wrapped) {
        let range = LowerBound.value...UpperBound.value
        self.value = value.clamped(to: range)
    }
    
}



// MARK: - Behavior Extensions

extension Clamped: ExpressibleByIntegerLiteral where Wrapped: ExpressibleByIntegerLiteral {}
extension Clamped: ExpressibleByFloatLiteral where Wrapped: ExpressibleByFloatLiteral {}
extension Clamped: Comparable where Wrapped: Comparable {}
extension Clamped: Equatable where Wrapped: Equatable {}
extension Clamped: Hashable where Wrapped: Hashable {}
extension Clamped: Sendable where Wrapped: Sendable {}
extension Clamped: Codable where Wrapped: Codable {}
