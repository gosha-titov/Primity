/// A type that can produce a truncated copy of itself, where excess characters are removed from the end.
public protocol Truncatable {
    
    /// Returns a copy truncated to a maximum length.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, world! Hello, world! Hello, world!"
    /// string.truncated() // "Hello, world! Hello, world! Hell"
    /// ```
    func truncated() -> Self
    
}



// MARK: - Compatibility Extensions

extension Wrapping where Value: Truncatable {
    public func truncated() -> Self {
        return Self(value.truncated())
    }
}

extension String: Truncatable {
    public func truncated() -> String {
        return String(prefix(32))
    }
}

extension Capitalized: Truncatable where Value: Truncatable {}
extension Lowercased: Truncatable where Value: Truncatable {}
extension Uppercased: Truncatable where Value: Truncatable {}
extension Stripped: Truncatable where Value: Truncatable {}
extension Collapsed: Truncatable where Value: Truncatable {}
extension Ragged: Truncatable where Value: Truncatable {}
extension Trimmed: Truncatable where Value: Truncatable {}
