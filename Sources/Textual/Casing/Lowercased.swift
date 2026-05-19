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
public struct Lowercased<Value>: Wrapping where Value: Lowercaseable {
    
    /// The underlying lowercased textual value.
    public let value: Value
    
    /// Creates an instance by lowercasing the given value.
    public init(_ value: Value) {
        self.value = value.lowercased()
    }
    
}



// MARK: - Behavior Extensions

extension Lowercased: Sequence where Value: Sequence {}
extension Lowercased: Collection where Value: Collection {}
extension Lowercased: BidirectionalCollection where Value: BidirectionalCollection {}
extension Lowercased: Equatable where Value: Equatable {}
extension Lowercased: Hashable where Value: Hashable {}
extension Lowercased: Sendable where Value: Sendable {}
extension Lowercased: Codable where Value: Codable {}

extension Lowercased: ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Lowercased: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Value: ExpressibleByStringLiteral {}
