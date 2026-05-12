/// A wrapper that collapses its value on creation.
///
/// Consecutive whitespace is replaced with a single space during initialization.
///
/// ## Example
/// ```
/// typealias Paragraph = Collapsed<String>
///
/// let text: Paragraph = "Hello, \n  world!"
/// print(text) //        "Hello, world!"
/// ```
public struct Collapsed<Value>: Wrapping where Value: Collapsible {
    
    /// The underlying collapsed textual value.
    public let value: Value
    
    /// Creates an instance by collapsing the given value.
    public init(_ value: Value) {
        self.value = value.collapsed()
    }
    
}



// MARK: - Behavior Extensions

extension Collapsed: Equatable where Value: Equatable {}
extension Collapsed: Hashable where Value: Hashable {}
extension Collapsed: Sendable where Value: Sendable {}
