/// A wrapper that trims its value on creation.
///
/// Whitespace is removed from both ends during initialization.
/// ## Example
/// ```
/// let text = Trimmed(" hello \n")
/// print(text) // "hello"
/// ```
public struct Trimmed<Wrapped>: Wrapping where Wrapped: Trimmable {
    
    /// The underlying trimmed textual value.
    public let value: Wrapped
    
    /// Creates an instance by trimming the given value.
    public init(_ value: Wrapped) {
        self.value = value.trimmed()
    }
    
}



// MARK: - Behavior Extensions

extension Trimmed: Sequence where Wrapped: Sequence {}
extension Trimmed: Collection where Wrapped: Collection {}
extension Trimmed: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Trimmed: Equatable where Wrapped: Equatable {}
extension Trimmed: Hashable where Wrapped: Hashable {}
extension Trimmed: Sendable where Wrapped: Sendable {}
extension Trimmed: Codable where Wrapped: Codable {}

extension Trimmed: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Trimmed: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
