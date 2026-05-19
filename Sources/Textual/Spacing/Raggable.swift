/// A type that can produce a ragged version of itself, where trailing whitespace is removed from each line.
public protocol Raggable {
    
    /// Returns a copy with trailing whitespace removed from each line.
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



// MARK: - Compatibility Extensions

extension Wrapping where Value: Raggable {
    public func ragged() -> Self {
        return Self(value.ragged())
    }
}


extension String: Raggable {
    
    public func ragged() -> String {
        return self
            .components(separatedBy: .newlines)
            .map { $0.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) }
            .joined(separator: "\n")
    }
    
}


extension Capitalized: Raggable where Value: Raggable {}
extension Lowercased: Raggable where Value: Raggable {}
extension Uppercased: Raggable where Value: Raggable {}
extension Stripped: Raggable where Value: Raggable {}
extension Truncated: Raggable where Value: Raggable {}
extension Collapsed: Raggable where Value: Raggable {}
extension Trimmed: Raggable where Value: Raggable {}
