/// A wrapper that rags its value on creation.
///
/// Trailing whitespace is removed from each line during initialization.
/// ## Example (underscores represent spaces)
/// ```
/// typealias CodeSnippet = Ragged<String>
///
/// let snippet: CodeSnippet = """
/// __Hello___
/// _world!__
/// """
/// 
/// print(snippet)
/// /* """
/// __Hello
/// _world!
/// """ */
/// ```
public struct Ragged<Value>: Wrapping where Value: Raggable {
    
    /// The underlying ragged textual value.
    public let value: Value
    
    /// Creates an instance by ragging the given value.
    public init(_ value: Value) {
        self.value = value.ragged()
    }
    
}



// MARK: - Behavior Extensions

extension Ragged: Sequence where Value: Sequence {}
extension Ragged: Collection where Value: Collection {}
extension Ragged: BidirectionalCollection where Value: BidirectionalCollection {}
extension Ragged: Equatable where Value: Equatable {}
extension Ragged: Hashable where Value: Hashable {}
extension Ragged: Sendable where Value: Sendable {}
extension Ragged: Codable where Value: Codable {}

extension Ragged: ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Ragged: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Value: ExpressibleByStringLiteral {}
