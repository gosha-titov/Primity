import Foundation

/// A type that can produce a capitalized version of itself, where the first letter of each word is uppercased.
public protocol Capitalizable {
    
    /// Returns a copy with the first character of each word uppercased.
    ///
    /// ## Example
    /// ```
    /// let string = "hello, world!"
    /// string.capitalized() // "Hello, World!"
    /// ```
    func capitalized() -> Self
    
}



// MARK: - Compatibility Extensions

extension Wrapping where Wrapped: Capitalizable {
    public func capitalized() -> Self {
        return Self(value.capitalized())
    }
}

extension String: Capitalizable {
    public func capitalized() -> String {
        return capitalized
    }
}

extension Stripped: Capitalizable where Wrapped: Capitalizable {}
extension Truncated: Capitalizable where Wrapped: Capitalizable {}
extension Collapsed: Capitalizable where Wrapped: Capitalizable {}
extension Ragged: Capitalizable where Wrapped: Capitalizable {}
extension Trimmed: Capitalizable where Wrapped: Capitalizable {}
