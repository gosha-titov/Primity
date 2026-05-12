import Foundation

/// A type that can produce a trimmed version of itself, where whitespace is removed from both ends.
public protocol Trimmable {
    
    /// Returns a copy with whitespace removed from the start and end.
    /// 
    /// ## Example
    /// ```
    /// let string = " hello \n"
    /// string.trimmed() // "hello"
    /// ```
    func trimmed() -> Self
    
}



// MARK: - Behavior

/// A behavior that forwards `trimmed()` through the wrapped value.
public protocol WrappingWithTrimmable: Wrapping, Trimmable where Value: Trimmable {
    // No additional requirements
}

extension WrappingWithTrimmable {
    public func trimmed() -> Self {
        return Self(value.trimmed())
    }
}



// MARK: - Compatibility Extensions

extension String: Trimmable {
    
    public func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}


extension Capitalized: WrappingWithTrimmable, Trimmable where Value: Trimmable {}
extension Lowercased: WrappingWithTrimmable, Trimmable where Value: Trimmable {}
extension Uppercased: WrappingWithTrimmable, Trimmable where Value: Trimmable {}
extension Stripped: WrappingWithTrimmable, Trimmable where Value: Trimmable {}
extension Truncated: WrappingWithTrimmable, Trimmable where Value: Trimmable {}
extension Collapsed: WrappingWithTrimmable, Trimmable where Value: Trimmable {}
extension Ragged: WrappingWithTrimmable, Trimmable where Value: Trimmable {}
