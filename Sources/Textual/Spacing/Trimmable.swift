import Foundation

/// A type that can produce a trimmed version of itself, where whitespace is removed from both ends.
public protocol Trimmable {
    
    /// Returns a copy with whitespace removed from the start and end.
    /// ## Example
    /// ```
    /// let string = " hello \n"
    /// string.trimmed() // "hello"
    /// ```
    func trimmed() -> Self
    
}



// MARK: - Compatibility Extensions

extension Wrapping where Wrapped: Trimmable {
    public func trimmed() -> Self {
        return Self(value.trimmed())
    }
}

extension String: Trimmable {
    
    public func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}


extension Capitalized: Trimmable where Wrapped: Trimmable {}
extension Lowercased: Trimmable where Wrapped: Trimmable {}
extension Uppercased: Trimmable where Wrapped: Trimmable {}
extension Stripped: Trimmable where Wrapped: Trimmable {}
extension Truncated: Trimmable where Wrapped: Trimmable {}
extension Collapsed: Trimmable where Wrapped: Trimmable {}
extension Ragged: Trimmable where Wrapped: Trimmable {}
