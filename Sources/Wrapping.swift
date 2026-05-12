/// A type that wraps a single underlying value, always accepting any input.
///
/// Use this protocol for transformations that cannot fail, such as `Trimmed` or `Lowercased`.
/// The initializer always succeeds because every input value produces a valid wrapped result.
public protocol Wrapping: AnyWrapping {
    
    /// Creates an instance by wrapping the given value.
    init(_ value: Value)
    
}


/// A type that wraps a single underlying value, validating its input.
///
/// Use this protocol for constrained types such as `NonEmpty` or `NonNegative`,
/// where not every underlying value satisfies the wrapper's requirements.
/// The failable initializer returns `nil` when the value is invalid.
public protocol MaybeWrapping: AnyWrapping {
    
    /// Creates an instance by wrapping the given value, or returns `nil` if the value does not satisfy the wrapper's requirements.
    init?(_ value: Value)
    
}


/// A base protocol for all single-value wrappers.
///
/// Conforming types expose a single underlying value via the `value` property.
public protocol AnyWrapping: CustomStringConvertible {
    
    /// The type of the wrapped underlying value.
    associatedtype Value
    
    /// The underlying wrapped value.
    var value: Value { get }
    
}



// MARK: - Behavior Extensions

extension AnyWrapping {
    
    /// A textual representation of the wrapped value.
    public var description: String {
        return "\(value)"
    }
    
}
