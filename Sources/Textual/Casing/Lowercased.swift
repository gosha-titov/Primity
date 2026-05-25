/// A wrapper that lowercases its value on creation.
///
/// All letters are lowercased during initialization.
/// ## Example
/// ```
/// typealias Tag = Lowercased<String>
///
/// let tag: Tag = "Memory"
/// print(tag) //  "memory"
/// ```
public struct Lowercased<Wrapped>: Wrapping where Wrapped: Lowercaseable {
    
    /// The underlying lowercased textual value.
    public let value: Wrapped
    
    /// Creates an instance by lowercasing the given value.
    public init(_ value: Wrapped) {
        self.value = value.lowercased()
    }
    
}



// MARK: - Behavior Extensions

extension Lowercased: Sequence where Wrapped: Sequence {}
extension Lowercased: Collection where Wrapped: Collection {}
extension Lowercased: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Lowercased: Equatable where Wrapped: Equatable {}
extension Lowercased: Hashable where Wrapped: Hashable {}
extension Lowercased: Sendable where Wrapped: Sendable {}
extension Lowercased: Codable where Wrapped: Codable {}

extension Lowercased: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Lowercased: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
