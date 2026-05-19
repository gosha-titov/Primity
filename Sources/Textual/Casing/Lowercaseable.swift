/// A type that can produce a lowercase version of itself, where all letters are lowercased.
public protocol Lowercaseable {
    
    /// Returns a copy with all letters lowercased.
    /// ## Example
    /// ```
    /// let string = "Hello, World!"
    /// string.lowercased() // "hello, world!"
    /// ```
    func lowercased() -> Self
    
}



// MARK: - Compatibility Extensions

extension Wrapping where Value: Lowercaseable {
    public func lowercased() -> Self {
        return Self(value.lowercased())
    }
}

extension String: Lowercaseable {}

extension Stripped: Lowercaseable where Value: Lowercaseable {}
extension Truncated: Lowercaseable where Value: Lowercaseable {}
extension Collapsed: Lowercaseable where Value: Lowercaseable {}
extension Ragged: Lowercaseable where Value: Lowercaseable {}
extension Trimmed: Lowercaseable where Value: Lowercaseable {}
