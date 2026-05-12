/// A wrapper that trims its value on creation.
///
/// Whitespace is removed from both ends during initialization.
///
/// ## Example
/// ```
/// let text = Trimmed(" hello \n")
/// print(text) // "hello"
/// ```
public struct Trimmed<Value>: Wrapping where Value: Trimmable {
    
    /// The underlying trimmed textual value.
    public let value: Value
    
    /// Creates an instance by trimming the given value.
    public init(_ value: Value) {
        self.value = value.trimmed()
    }
    
}



// MARK: - Behavior Extensions

extension Trimmed: Equatable where Value: Equatable {}
extension Trimmed: Hashable where Value: Hashable {}
extension Trimmed: Sendable where Value: Sendable {}
