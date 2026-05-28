/// A type that can produce a truncated copy of itself, where excess characters are removed from the end.
public protocol Truncatable {
    
    /// The type used for range boundaries.
    associatedtype Bound
    
    /// Returns a copy truncated to the given length.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, world! Hello, world! Hello, world!"
    /// string.truncated(to: 32) // "Hello, world! Hello, world! Hell"
    /// ```
    func truncated(to length: Bound) -> Self
    
}



// MARK: - Compatibility Extensions

extension Wrapping where Wrapped: Truncatable {
    public func truncated(to length: Wrapped.Bound) -> Self {
        return Self(value.truncated(to: length))
    }
}

extension String: Truncatable {
    public func truncated(to length: Int) -> String {
        return String(prefix(length))
    }
}

extension Capitalized: Truncatable where Wrapped: Truncatable {}
extension Lowercased: Truncatable where Wrapped: Truncatable {}
extension Uppercased: Truncatable where Wrapped: Truncatable {}
extension Stripped: Truncatable where Wrapped: Truncatable {}
extension Collapsed: Truncatable where Wrapped: Truncatable {}
extension Ragged: Truncatable where Wrapped: Truncatable {}
extension Trimmed: Truncatable where Wrapped: Truncatable {}
