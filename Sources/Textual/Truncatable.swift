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



// MARK: - Behavior

/// A behavior that forwards `truncated()` through the wrapped value.
public protocol WrappingWithTruncatable: Wrapping, Truncatable where Value: Truncatable {
    // No additional requirements
}

extension WrappingWithTruncatable {
    public func truncated() -> Self {
        return Self(value.truncated())
    }
}



// MARK: - Compatibility Extensions

extension String: Truncatable {
    public func truncated() -> String {
        return String(prefix(32))
    }
}


extension Capitalized: WrappingWithTruncatable, Truncatable where Value: Truncatable {}
extension Lowercased: WrappingWithTruncatable, Truncatable where Value: Truncatable {}
extension Uppercased: WrappingWithTruncatable, Truncatable where Value: Truncatable {}
extension Stripped: WrappingWithTruncatable, Truncatable where Value: Truncatable {}
extension Collapsed: WrappingWithTruncatable, Truncatable where Value: Truncatable {}
extension Ragged: WrappingWithTruncatable, Truncatable where Value: Truncatable {}
extension Trimmed: WrappingWithTruncatable, Truncatable where Value: Truncatable {}
