import Foundation

/// A type that can produce a collapsed version of itself, where consecutive whitespace is replaced with a single space.
public protocol Collapsible {
    
    /// Returns a copy with consecutive whitespace characters replaced by a single space.
    /// ## Example
    /// ```
    /// let string = "Hello, \n  world!"
    /// string.collapsed() // "Hello, world!"
    /// ```
    func collapsed() -> Self
    
}



// MARK: - Compatibility Extensions

extension Wrapping where Value: Collapsible {
    public func collapsed() -> Self {
        return Self(value.collapsed())
    }
}

extension String: Collapsible {
    
    public func collapsed() -> String {
        let maybeRegex = try? NSRegularExpression(pattern: "\\s+", options: .caseInsensitive)
        guard let regex = maybeRegex else { return self }
        let range = NSRange(startIndex..., in: self)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: " ")
    }
    
}


extension Capitalized: Collapsible where Value: Collapsible {}
extension Lowercased: Collapsible where Value: Collapsible {}
extension Uppercased: Collapsible where Value: Collapsible {}
extension Stripped: Collapsible where Value: Collapsible {}
extension Truncated: Collapsible where Value: Collapsible {}
extension Ragged: Collapsible where Value: Collapsible {}
extension Trimmed: Collapsible where Value: Collapsible {}
