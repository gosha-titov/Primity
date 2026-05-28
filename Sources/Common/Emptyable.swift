/// A type that can indicate whether it is empty.
public protocol Emptyable {
    
    /// A boolean value indicating whether the instance is empty.
    var isEmpty: Bool { get }
    
}



// MARK: - Compatibility Extensions

extension Wrapping where Wrapped: Emptyable {
    public var isEmpty: Bool {
        return value.isEmpty
    }
}

extension Sorted: Emptyable where Wrapped: Emptyable {}

extension Capitalized: Emptyable where Wrapped: Emptyable {}
extension Lowercased: Emptyable where Wrapped: Emptyable {}
extension Uppercased: Emptyable where Wrapped: Emptyable {}
extension Stripped: Emptyable where Wrapped: Emptyable {}
extension Truncated: Emptyable where Wrapped: Emptyable {}
extension Collapsed: Emptyable where Wrapped: Emptyable {}
extension Ragged: Emptyable where Wrapped: Emptyable {}
extension Trimmed: Emptyable where Wrapped: Emptyable {}

extension Dictionary: Emptyable {}
extension String: Emptyable {}
extension Array: Emptyable {}
extension Range: Emptyable {}
extension Set: Emptyable {}
