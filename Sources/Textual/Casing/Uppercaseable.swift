/// A type that can produce a lowercase version of itself, where all letters are uppercased.
public protocol Uppercaseable {
    
    /// Returns a copy with all letters uppercased.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, World!"
    /// string.uppercased() // "HELLO, WORLD!"
    /// ```
    func uppercased() -> Self
    
}



// MARK: - Behavior

/// A behavior that forwards `uppercased()` through the wrapped value.
public protocol WrappingWithUppercaseable: Wrapping, Uppercaseable where Value: Uppercaseable {
    // No additional requirements
}

extension WrappingWithUppercaseable {
    public func uppercased() -> Self {
        return Self(value.uppercased())
    }
}



// MARK: - Compatibility Extensions

extension String: Uppercaseable {}

extension Stripped: WrappingWithUppercaseable, Uppercaseable where Value: Uppercaseable {}
extension Truncated: WrappingWithUppercaseable, Uppercaseable where Value: Uppercaseable {}
extension Collapsed: WrappingWithUppercaseable, Uppercaseable where Value: Uppercaseable {}
extension Ragged: WrappingWithUppercaseable, Uppercaseable where Value: Uppercaseable {}
extension Trimmed: WrappingWithUppercaseable, Uppercaseable where Value: Uppercaseable {}
