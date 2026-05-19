/// A type that can produce a lowercase version of itself, where all letters are uppercased.
public protocol Uppercaseable {
    
    /// Returns a copy with all letters uppercased.
    /// ## Example
    /// ```
    /// let string = "Hello, World!"
    /// string.uppercased() // "HELLO, WORLD!"
    /// ```
    func uppercased() -> Self
    
}



// MARK: - Compatibility Extensions

extension Wrapping where Value: Uppercaseable {
    public func uppercased() -> Self {
        return Self(value.uppercased())
    }
}

extension String: Uppercaseable {}

extension Stripped: Uppercaseable where Value: Uppercaseable {}
extension Truncated: Uppercaseable where Value: Uppercaseable {}
extension Collapsed: Uppercaseable where Value: Uppercaseable {}
extension Ragged: Uppercaseable where Value: Uppercaseable {}
extension Trimmed: Uppercaseable where Value: Uppercaseable {}
