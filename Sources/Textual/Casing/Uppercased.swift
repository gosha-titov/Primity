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
public struct Uppercased<Value>: Wrapping where Value: Uppercaseable {
    
    /// The underlying uppercased textual value.
    public let value: Value
    
    /// Creates an instance by uppercasing the given value.
    public init(_ value: Value) {
        self.value = value.uppercased()
    }
    
}



// MARK: - Behavior Extensions

extension Uppercased: Sequence where Value: Sequence {}
extension Uppercased: Collection where Value: Collection {}
extension Uppercased: BidirectionalCollection where Value: BidirectionalCollection {}
extension Uppercased: Equatable where Value: Equatable {}
extension Uppercased: Hashable where Value: Hashable {}
extension Uppercased: Sendable where Value: Sendable {}
extension Uppercased: Codable where Value: Codable {}

extension Uppercased: ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Uppercased: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Value: ExpressibleByStringLiteral {}
