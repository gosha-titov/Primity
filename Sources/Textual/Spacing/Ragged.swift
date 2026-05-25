/// A wrapper that rags its value on creation.
///
/// Trailing whitespace is removed from each line during initialization.
/// 
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
public struct Ragged<Wrapped>: Wrapping where Wrapped: Raggable {
    
    /// The underlying ragged textual value.
    public let value: Wrapped
    
    /// Creates an instance by ragging the given value.
    public init(_ value: Wrapped) {
        self.value = value.ragged()
    }
    
}



// MARK: - Behavior Extensions

extension Ragged: Sequence where Wrapped: Sequence {}
extension Ragged: Collection where Wrapped: Collection {}
extension Ragged: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Ragged: Equatable where Wrapped: Equatable {}
extension Ragged: Hashable where Wrapped: Hashable {}
extension Ragged: Sendable where Wrapped: Sendable {}
extension Ragged: Codable where Wrapped: Codable {}

extension Ragged: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Ragged: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
