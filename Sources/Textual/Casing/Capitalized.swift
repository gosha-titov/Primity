/// A wrapper that capitalizes its value on creation.
///
/// The first letter of each word is uppercased during initialization.
/// ## Example
/// ```
/// typealias Title = Capitalized<String>
///
/// let title: Title = "swift best practices"
/// print(title) //    "Swift Best Practices"
/// ```
public struct Capitalized<Wrapped>: Wrapping where Wrapped: Capitalizable {
    
    /// The underlying capitalized textual value.
    public let value: Wrapped
    
    /// Creates an instance by capitalizing the given value.
    public init(_ value: Wrapped) {
        self.value = value.capitalized()
    }
    
}



// MARK: - Behavior Extensions

extension Capitalized: Sequence where Wrapped: Sequence {}
extension Capitalized: Collection where Wrapped: Collection {}
extension Capitalized: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Capitalized: Equatable where Wrapped: Equatable {}
extension Capitalized: Hashable where Wrapped: Hashable {}
extension Capitalized: Sendable where Wrapped: Sendable {}
extension Capitalized: Codable where Wrapped: Codable {}

extension Capitalized: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Capitalized: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
