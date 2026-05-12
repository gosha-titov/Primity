/// A type that can be initialized from an underlying raw value.
///
/// Nested wrappers can be created concisely without manually writing every layer.
///
/// ## Example
/// ```
/// typealias Name = Trimmed<Stripped<String>>
///
/// let name = Name(expressing: "Mia")
/// //         Trimmed(Stripped("Mia"))
///
/// let stirng = name.expressed() // "Mia"
/// ```
public protocol Expressible: AnyExpressible {
    
    /// Creates an instance from the given raw value.
    init(expressing value: Expressed)
    
}


/// A type that can be initialized from an underlying raw value, returning `nil` if the value is invalid.
///
/// Use this protocol for constrained types where the raw representation might not satisfy requirements.
///
/// ## Example
/// ```
/// typealias Name = NonEmpty<Trimmed<String>>>
///
/// if let name = Name(expressing: "Mia") {...}
/// //            NonEmpty(Trimmed("Mia"))
/// ```
public protocol MaybeExpressible: AnyExpressible {
    
    /// Creates an instance from the given raw value, or returns `nil` if the value is invalid.
    init?(expressing value: Expressed)
    
}


/// A base protocol for types that convert to and from an underlying raw value.
///
/// This protocol sits at the root of the expressible hierarchy, refined by `Expressible` and `MaybeExpressible`.
public protocol AnyExpressible {
    
    /// The raw value type.
    associatedtype Expressed = Self
    
    /// Return an underlying raw value.
    func expressed() -> Expressed
    
}



// MARK: - Behavior Extensions

extension AnyExpressible where Expressed == Self {
    
    /// Return `self` as the raw value.
    public func expressed() -> Self {
        return self
    }
    
}


extension Expressible where Expressed == Self {
    
    /// Creates an instance from the given value.
    public init(expressing value: Self) {
        self = value
    }
    
}



// MARK: - Wrapping Behavior

/// A behavior that bridges `Wrapping` and `Expressible` when the wrapped value is itself `Expressible`.
public protocol WrappingWithExpressible: Wrapping, Expressible where Value: Expressible {
    // No additional requirements
}

/// A behavior that bridges `MaybeWrapping` and `MaybeExpressible` when the wrapped value is itself `Expressible`.
public protocol MaybeWrappingWithExpressible: MaybeWrapping, MaybeExpressible where Value: Expressible {
    // No additional requirements
}


extension WrappingWithExpressible {
    public func expressed() -> Value.Expressed {
        return value.expressed()
    }
    public init(expressing value: Value.Expressed) {
        self.init(Value(expressing: value))
    }
}

extension MaybeWrappingWithExpressible {
    public func expressed() -> Value.Expressed {
        return value.expressed()
    }
    public init?(expressing value: Value.Expressed) {
        self.init(Value(expressing: value))
    }
}



// MARK: - Compatibility Extensions

extension NonEmpty: MaybeWrappingWithExpressible, MaybeExpressible, AnyExpressible where Value: Expressible {}
extension InRange: MaybeWrappingWithExpressible, MaybeExpressible, AnyExpressible where Value: Expressible {}
extension Sorted: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}

extension NonNegative: MaybeWrappingWithExpressible, MaybeExpressible, AnyExpressible where Value: Expressible {}
extension Positive: MaybeWrappingWithExpressible, MaybeExpressible, AnyExpressible where Value: Expressible {}
extension UnitInterval: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}

extension Capitalized: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}
extension Lowercased: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}
extension Uppercased: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}
extension Stripped: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}
extension Truncated: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}
extension Collapsed: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}
extension Ragged: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}
extension Trimmed: WrappingWithExpressible, Expressible, AnyExpressible where Value: Expressible {}


extension Array: Expressible {}
extension Dictionary: Expressible {}
extension Set: Expressible {}
extension String: Expressible {}
extension Character: Expressible {}
extension Double: Expressible {}
extension Float: Expressible {}
extension Int: Expressible {}
