/// A wrapper that truncates its value on creation.
///
/// Excess characters from the end are removed during initialization.
///
/// ## Example
/// ```
/// typealias Text = Truncated<`32`, String>
///
/// let text: Text = "Hello, world! Hello, world! Hello, world!")
/// //               "Hello, world! Hello, world! Hell"
/// ```
public struct Truncated<Length: Bound, Wrapped: Truncatable>: Wrapping where Wrapped.Bound == Length.Value {
    
    /// The underlying trancated textual value.
    public let value: Wrapped
    
    /// Creates an instance by truncating the given value.
    public init(_ value: Wrapped) {
        self.value = value.truncated(to: Length.value)
    }
    
}



// MARK: - Behavior Extensions

extension Truncated: Sequence where Wrapped: Sequence {}
extension Truncated: Collection where Wrapped: Collection {}
extension Truncated: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Truncated: Equatable where Wrapped: Equatable {}
extension Truncated: Hashable where Wrapped: Hashable {}
extension Truncated: Sendable where Wrapped: Sendable {}
extension Truncated: Codable where Wrapped: Codable {}

extension Truncated: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Truncated: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
