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

extension Wrapping where Wrapped: Lowercaseable {
    public func lowercased() -> Self {
        return Self(value.lowercased())
    }
}

extension String: Lowercaseable {}

extension Stripped: Lowercaseable where Wrapped: Lowercaseable {}
extension Truncated: Lowercaseable where Wrapped: Lowercaseable {}
extension Collapsed: Lowercaseable where Wrapped: Lowercaseable {}
extension Ragged: Lowercaseable where Wrapped: Lowercaseable {}
extension Trimmed: Lowercaseable where Wrapped: Lowercaseable {}
