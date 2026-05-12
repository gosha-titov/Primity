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



// MARK: - Behavior

/// A behavior that forwards `capitalized()` through the wrapped value.
public protocol WrappingWithCapitalizable: Wrapping, Capitalizable where Value: Capitalizable {
    // No additional requirements
}

extension WrappingWithCapitalizable {
    public func capitalized() -> Self {
        return Self(value.capitalized())
    }
}



// MARK: - Compatibility Extensions

extension String: Capitalizable {
    public func capitalized() -> String {
        return capitalized
    }
}

extension Stripped: WrappingWithCapitalizable, Capitalizable where Value: Capitalizable {}
extension Truncated: WrappingWithCapitalizable, Capitalizable where Value: Capitalizable {}
extension Collapsed: WrappingWithCapitalizable, Capitalizable where Value: Capitalizable {}
extension Ragged: WrappingWithCapitalizable, Capitalizable where Value: Capitalizable {}
extension Trimmed: WrappingWithCapitalizable, Capitalizable where Value: Capitalizable {}
