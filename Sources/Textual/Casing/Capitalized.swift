/// A wrapper that capitalizes its value on creation.
///
/// The first letter of each word is uppercased during initialization.
///
/// ## Example
/// ```
/// typealias Title = Capitalized<String>
///
/// let title: Title = "swift best practices"
/// print(title) //    "Swift Best Practices"
/// ```
public struct Capitalized<Value>: Wrapping where Value: Capitalizable {
    
    /// The underlying capitalized textual value.
    public let value: Value
    
    /// Creates an instance by capitalizing the given value.
    public init(_ value: Value) {
        self.value = value.capitalized()
    }
    
}



// MARK: - Behavior Extensions

extension Capitalized: Equatable where Value: Equatable {}
extension Capitalized: Hashable where Value: Hashable {}
extension Capitalized: Sendable where Value: Sendable {}
