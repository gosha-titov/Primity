/// A type that can indicate whether it is empty.
public protocol Emptyable {
    
    /// A boolean value indicating whether the instance is empty.
    var isEmpty: Bool { get }
    
}



// MARK: - Behavior

/// A behavior that forwards `isEmpty` through the wrapped value.
public protocol WrappingWithEmptyable: AnyWrapping, Emptyable where Value: Emptyable {
    // No additional requirements
}

extension WrappingWithEmptyable {
    public var isEmpty: Bool {
        return value.isEmpty
    }
}



// MARK: - Compatibility Extensions

extension Sorted: WrappingWithEmptyable, Emptyable where Value: Emptyable {}

extension Capitalized: WrappingWithEmptyable, Emptyable where Value: Emptyable {}
extension Lowercased: WrappingWithEmptyable, Emptyable where Value: Emptyable {}
extension Uppercased: WrappingWithEmptyable, Emptyable where Value: Emptyable {}
extension Stripped: WrappingWithEmptyable, Emptyable where Value: Emptyable {}
extension Truncated: WrappingWithEmptyable, Emptyable where Value: Emptyable {}
extension Collapsed: WrappingWithEmptyable, Emptyable where Value: Emptyable {}
extension Ragged: WrappingWithEmptyable, Emptyable where Value: Emptyable {}
extension Trimmed: WrappingWithEmptyable, Emptyable where Value: Emptyable {}


extension Dictionary: Emptyable {}
extension String: Emptyable {}
extension Array: Emptyable {}
extension Range: Emptyable {}
extension Set: Emptyable {}
