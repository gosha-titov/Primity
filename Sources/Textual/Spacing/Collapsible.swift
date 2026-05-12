import Foundation

/// A type that can produce a collapsed version of itself, where consecutive whitespace is replaced with a single space.
public protocol Collapsible {
    
    /// Returns a copy with consecutive whitespace characters replaced by a single space.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, \n  world!"
    /// string.collapsed() // "Hello, world!"
    /// ```
    func collapsed() -> Self
    
}



// MARK: - Behavior

/// A behavior that forwards `collapsed()` through the wrapped value.
public protocol WrappingWithCollapsible: Wrapping, Collapsible where Value: Collapsible {
    // No additional requirements
}

extension WrappingWithCollapsible {
    public func collapsed() -> Self {
        return Self(value.collapsed())
    }
}



// MARK: - Compatibility Extensions

extension String: Collapsible {
    
    public func collapsed() -> String {
        let maybeRegex = try? NSRegularExpression(pattern: "\\s+", options: .caseInsensitive)
        guard let regex = maybeRegex else { return self }
        let range = NSRange(startIndex..., in: self)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: " ")
    }
    
}


extension Capitalized: WrappingWithCollapsible, Collapsible where Value: Collapsible {}
extension Lowercased: WrappingWithCollapsible, Collapsible where Value: Collapsible {}
extension Uppercased: WrappingWithCollapsible, Collapsible where Value: Collapsible {}
extension Stripped: WrappingWithCollapsible, Collapsible where Value: Collapsible {}
extension Truncated: WrappingWithCollapsible, Collapsible where Value: Collapsible {}
extension Ragged: WrappingWithCollapsible, Collapsible where Value: Collapsible {}
extension Trimmed: WrappingWithCollapsible, Collapsible where Value: Collapsible {}
