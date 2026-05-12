/// A type that can produce a lowercase version of itself, where all letters are lowercased.
public protocol Lowercaseable {
    
    /// Returns a copy with all letters lowercased.
    ///
    /// ## Example
    /// ```
    /// let string = "Hello, World!"
    /// string.lowercased() // "hello, world!"
    /// ```
    func lowercased() -> Self
    
}



// MARK: - Behavior

/// A behavior that forwards `lowercased()` through the wrapped value.
public protocol WrappingWithLowercaseable: Wrapping, Lowercaseable where Value: Lowercaseable {
    // No additional requirements
}

extension WrappingWithLowercaseable {
    public func lowercased() -> Self {
        return Self(value.lowercased())
    }
}



// MARK: - Compatibility Extensions

extension String: Lowercaseable {}

extension Stripped: WrappingWithLowercaseable, Lowercaseable where Value: Lowercaseable {}
extension Truncated: WrappingWithLowercaseable, Lowercaseable where Value: Lowercaseable {}
extension Collapsed: WrappingWithLowercaseable, Lowercaseable where Value: Lowercaseable {}
extension Ragged: WrappingWithLowercaseable, Lowercaseable where Value: Lowercaseable {}
extension Trimmed: WrappingWithLowercaseable, Lowercaseable where Value: Lowercaseable {}
