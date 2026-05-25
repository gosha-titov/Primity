/// A wrapper that uppercases its value on creation.
///
/// All letters are uppercased during initialization.
/// ## Example
/// ```
/// typealias Abbreviation = Uppercased<String>
///
/// let text: Abbreviation = "url"
/// print(text) //           "URL"
/// ```
public struct Uppercased<Wrapped>: Wrapping where Wrapped: Uppercaseable {
    
    /// The underlying uppercased textual value.
    public let value: Wrapped
    
    /// Creates an instance by uppercasing the given value.
    public init(_ value: Wrapped) {
        self.value = value.uppercased()
    }
    
}



// MARK: - Behavior Extensions

extension Uppercased: Sequence where Wrapped: Sequence {}
extension Uppercased: Collection where Wrapped: Collection {}
extension Uppercased: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Uppercased: Equatable where Wrapped: Equatable {}
extension Uppercased: Hashable where Wrapped: Hashable {}
extension Uppercased: Sendable where Wrapped: Sendable {}
extension Uppercased: Codable where Wrapped: Codable {}

extension Uppercased: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Uppercased: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
