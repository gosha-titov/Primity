/// A wrapper that strips its value on creation.
///
/// Decorative elements (like emojis) are removed during initialization.
///
/// ## Example
/// ```
/// let text = Stripped("Hello, 👋 World! 🌍 Let's meet at 3️⃣ PM.")
/// print(text.value) // "Hello,  World!  Let's meet at  PM."
/// ```
public struct Stripped<Value>: Wrapping where Value: Strippable {
    
    /// The underlying stripped textual value.
    public let value: Value
    
    /// Creates an instance by stripping the given value.
    public init(_ value: Value) {
        self.value = value.stripped()
    }
    
}



// MARK: - Behavior Extensions

extension Stripped: Equatable where Value: Equatable {}
extension Stripped: Hashable where Value: Hashable {}
extension Stripped: Sendable where Value: Sendable {}
