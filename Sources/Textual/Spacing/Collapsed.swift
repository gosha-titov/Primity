/// A wrapper that collapses its value on creation.
///
/// Consecutive whitespace is replaced with a single space during initialization.
/// ## Example
/// ```
/// typealias Paragraph = Collapsed<String>
///
/// let text: Paragraph = "Hello, \n  world!"
/// print(text) //        "Hello, world!"
/// ```
public struct Collapsed<Wrapped>: Wrapping where Wrapped: Collapsible {
    
    /// The underlying collapsed textual value.
    public let value: Wrapped
    
    /// Creates an instance by collapsing the given value.
    public init(_ value: Wrapped) {
        self.value = value.collapsed()
    }
    
}



// MARK: - Behavior Extensions

extension Collapsed: Sequence where Wrapped: Sequence {}
extension Collapsed: Collection where Wrapped: Collection {}
extension Collapsed: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Collapsed: Equatable where Wrapped: Equatable {}
extension Collapsed: Hashable where Wrapped: Hashable {}
extension Collapsed: Sendable where Wrapped: Sendable {}
extension Collapsed: Codable where Wrapped: Codable {}

extension Collapsed: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Collapsed: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
