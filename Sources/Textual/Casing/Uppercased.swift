/// A wrapper that uppercases its value on creation.
///
/// All letters are uppercased during initialization.
///
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

extension Uppercased: Equatable where Value: Equatable {}
extension Uppercased: Hashable where Value: Hashable {}
extension Uppercased: Sendable where Value: Sendable {}
