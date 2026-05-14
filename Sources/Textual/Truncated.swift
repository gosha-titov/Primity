/// A wrapper that truncates its value on creation.
///
/// Excess characters from the end are removed during initialization.
///
/// ## Example
/// ```
/// let text = Truncated("Hello, world! Hello, world! Hello, world!")
/// print(text) //       "Hello, world! Hello, world! Hell"
/// ```
public struct Truncated<Value>: Wrapping where Value: Truncatable {
    
    /// The underlying trancated textual value.
    public let value: Value
    
    /// Creates an instance by truncating the given value.
    public init(_ value: Value) {
        self.value = value.truncated()
    }
    
}



// MARK: - Behavior Extensions

extension Truncated: Equatable where Value: Equatable {}
extension Truncated: Hashable where Value: Hashable {}
extension Truncated: Sendable where Value: Sendable {}
