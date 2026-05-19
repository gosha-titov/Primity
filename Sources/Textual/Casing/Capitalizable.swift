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

extension Wrapping where Value: Capitalizable {
    public func capitalized() -> Self {
        return Self(value.capitalized())
    }
}

extension String: Capitalizable {
    public func capitalized() -> String {
        return capitalized
    }
}

extension Stripped: Capitalizable where Value: Capitalizable {}
extension Truncated: Capitalizable where Value: Capitalizable {}
extension Collapsed: Capitalizable where Value: Capitalizable {}
extension Ragged: Capitalizable where Value: Capitalizable {}
extension Trimmed: Capitalizable where Value: Capitalizable {}
