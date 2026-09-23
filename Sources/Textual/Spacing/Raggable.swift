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



// MARK: - Compatibility Extensions

extension Wrapping where Wrapped: Raggable {
    public func ragged() -> Self {
        return Self(value.ragged())
    }
}


extension String: Raggable {
    
    public func ragged() -> String {
            var result = String()
            result.reserveCapacity(utf8.count)
            var trailingWhitespace = String()
            for character in self {
                if character.isNewline {
                    trailingWhitespace.removeAll(keepingCapacity: true)
                    result.append(character)
                } else if character.isWhitespaceOnly {
                    trailingWhitespace.append(character)
                } else {
                    result.append(trailingWhitespace)
                    trailingWhitespace.removeAll(keepingCapacity: true)
                    result.append(character)
                }
            }
            return result
        }
    
}


private extension Character {
    @inline(__always)
    var isWhitespaceOnly: Bool {
        return unicodeScalars.allSatisfy(\.properties.isWhitespace)
    }
}


extension Capitalized: Raggable where Wrapped: Raggable {}
extension Lowercased: Raggable where Wrapped: Raggable {}
extension Uppercased: Raggable where Wrapped: Raggable {}
extension Stripped: Raggable where Wrapped: Raggable {}
extension Truncated: Raggable where Wrapped: Raggable {}
extension Collapsed: Raggable where Wrapped: Raggable {}
extension Trimmed: Raggable where Wrapped: Raggable {}



// MARK: - Helpers

private extension String {
    @inline(__always)
    static var newline: String {
        return "\n"
    }
}
