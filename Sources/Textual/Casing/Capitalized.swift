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
public struct Capitalized<Value>: Wrapping where Value: Capitalizable {
    
    /// The underlying capitalized textual value.
    public let value: Value
    
    /// Creates an instance by capitalizing the given value.
    public init(_ value: Value) {
        self.value = value.capitalized()
    }
    
}



// MARK: - Behavior Extensions

extension Capitalized: Sequence where Value: Sequence {}
extension Capitalized: Collection where Value: Collection {}
extension Capitalized: BidirectionalCollection where Value: BidirectionalCollection {}
extension Capitalized: Equatable where Value: Equatable {}
extension Capitalized: Hashable where Value: Hashable {}
extension Capitalized: Sendable where Value: Sendable {}
extension Capitalized: Codable where Value: Codable {}

extension Capitalized: ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Capitalized: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Value: ExpressibleByStringLiteral {}
