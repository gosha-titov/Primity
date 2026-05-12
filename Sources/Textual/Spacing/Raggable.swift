/// A type that can produce a ragged version of itself, where trailing whitespace is removed from each line.
public protocol Raggable {
    
    /// Returns a copy with trailing whitespace removed from each line.
    ///
    /// ## Example (underscores represent spaces)
    /// ```
    /// let string = """
    /// __Hello___
    /// _world!__
    /// """
    ///
    /// string.ragged()
    /// /* """
    /// __Hello
    /// _world!
    /// """ */
    /// ```
    func ragged() -> Self
    
}



// MARK: - Behavior

/// A behavior that forwards `ragged()` through the wrapped value.
public protocol WrappingWithRaggable: Wrapping, Raggable where Value: Raggable {
    // No additional requirements
}

extension WrappingWithRaggable {
    public func ragged() -> Self {
        return Self(value.ragged())
    }
}



// MARK: - Compatibility Extensions

extension String: Raggable {
    
    public func ragged() -> String {
        return self
            .components(separatedBy: .newlines)
            .map { $0.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) }
            .joined(separator: "\n")
    }
    
}


extension Capitalized: WrappingWithRaggable, Raggable where Value: Raggable {}
extension Lowercased: WrappingWithRaggable, Raggable where Value: Raggable {}
extension Uppercased: WrappingWithRaggable, Raggable where Value: Raggable {}
extension Stripped: WrappingWithRaggable, Raggable where Value: Raggable {}
extension Truncated: WrappingWithRaggable, Raggable where Value: Raggable {}
extension Collapsed: WrappingWithRaggable, Raggable where Value: Raggable {}
extension Trimmed: WrappingWithRaggable, Raggable where Value: Raggable {}
