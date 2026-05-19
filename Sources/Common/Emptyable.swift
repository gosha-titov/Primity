/// A type that can indicate whether it is empty.
public protocol Emptyable {
    
    /// A boolean value indicating whether the instance is empty.
    var isEmpty: Bool { get }
    
}



// MARK: - Compatibility Extensions

extension Wrapping where Value: Emptyable {
    public var isEmpty: Bool {
        return value.isEmpty
    }
}

extension Sorted: Emptyable where Value: Emptyable {}

extension Capitalized: Emptyable where Value: Emptyable {}
extension Lowercased: Emptyable where Value: Emptyable {}
extension Uppercased: Emptyable where Value: Emptyable {}
extension Stripped: Emptyable where Value: Emptyable {}
extension Truncated: Emptyable where Value: Emptyable {}
extension Collapsed: Emptyable where Value: Emptyable {}
extension Ragged: Emptyable where Value: Emptyable {}
extension Trimmed: Emptyable where Value: Emptyable {}


extension Dictionary: Emptyable {}
extension String: Emptyable {}
extension Array: Emptyable {}
extension Range: Emptyable {}
extension Set: Emptyable {}
