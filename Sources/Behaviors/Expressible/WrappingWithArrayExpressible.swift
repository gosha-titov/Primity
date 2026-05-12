/// A bridging protocol that enables array literal initialization through the wrapped value.
///
/// Conforming types can be created from array literals when the wrapped value is itself `ArrayExpressible`.
/// 
/// ## Example
/// ```
/// typealias Numbers = Descended<Array<Int>>
///
/// let numbers: Numbers = [4, 1, 3, 2]
/// ```
public protocol WrappingWithArrayExpressible: Wrapping, ArrayExpressible where Value: ArrayExpressible {
    // No additional requirements
}


/// A type that can be initialized with an array value.
public protocol ArrayExpressible: ExpressibleByArrayLiteral {
    
    /// The type of the elements of an array literal.
    associatedtype ArrayLiteralElement
    
    /// Creates an instance from the array.
    init(array: [ArrayLiteralElement])
    
}



// MARK: - Behavior Extensions

extension WrappingWithArrayExpressible {
    public init(array: [Value.ArrayLiteralElement]) {
        self.init(Value(array: array))
    }
}

extension ArrayExpressible {
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self.init(array: elements)
    }
}

extension Array: ArrayExpressible {
    public init(array: [Element]) {
        self = array
    }
}

extension Set: ArrayExpressible where ArrayLiteralElement: Hashable {
    public init(array: [Element]) {
        self = Set(array)
    }
}



// MARK: - Compatibility Extensions

extension Sorted: WrappingWithArrayExpressible, ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Capitalized: WrappingWithArrayExpressible, ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Lowercased: WrappingWithArrayExpressible, ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Uppercased: WrappingWithArrayExpressible, ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Stripped: WrappingWithArrayExpressible, ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Truncated: WrappingWithArrayExpressible, ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Collapsed: WrappingWithArrayExpressible, ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Ragged: WrappingWithArrayExpressible, ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Trimmed: WrappingWithArrayExpressible, ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}


extension Optional: @retroactive ExpressibleByArrayLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ArrayExpressible {
    
    public init(arrayLiteral elements: Wrapped.Expressed.ArrayLiteralElement...) {
        self = Wrapped(expressing: Wrapped.Expressed(array: elements))
    }
    
}
