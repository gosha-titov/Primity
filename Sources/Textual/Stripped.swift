/// A wrapper that strips its value on creation.
///
/// Decorative elements (like emojis) are removed during initialization.
///
/// ## Example
/// ```
/// let text = Stripped("Hello, 👋 World! 🌍 Let's meet at 3️⃣ PM.")
/// print(text.value) // "Hello,  World!  Let's meet at  PM."
/// ```
public struct Stripped<Wrapped>: Wrapping where Wrapped: Strippable {
    
    /// The underlying stripped textual value.
    public let value: Wrapped
    
    /// Creates an instance by stripping the given value.
    public init(_ value: Wrapped) {
        self.value = value.stripped()
    }
    
}



// MARK: - Behavior Extensions

extension Stripped: Sequence where Wrapped: Sequence {}
extension Stripped: Collection where Wrapped: Collection {}
extension Stripped: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension Stripped: Equatable where Wrapped: Equatable {}
extension Stripped: Hashable where Wrapped: Hashable {}
extension Stripped: Sendable where Wrapped: Sendable {}
extension Stripped: Codable where Wrapped: Codable {}

extension Stripped: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Stripped: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
