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



// MARK: - Compatibility Extensions

extension AnyWrapping where Value: AnyExpressible {
    public typealias Expressed = Value.Expressed
    public func expressed() -> Value.Expressed {
        return value.expressed()
    }
}

extension Wrapping where Value: Expressible {
    public init(expressing value: Value.Expressed) {
        self.init(Value(expressing: value))
    }
}

extension MaybeWrapping where Value: Expressible {
    public init?(expressing value: Value.Expressed) {
        self.init(Value(expressing: value))
    }
}

extension NonEmpty: MaybeExpressible, AnyExpressible where Value: Expressible {}
extension Bounded: MaybeExpressible, AnyExpressible where Value: Expressible {}
extension Sorted: Expressible, AnyExpressible where Value: Expressible {}

extension NonNegative: MaybeExpressible, AnyExpressible where Value: Expressible {}
extension Positive: MaybeExpressible, AnyExpressible where Value: Expressible {}
extension UnitInterval: Expressible, AnyExpressible where Value: Expressible {}

extension Capitalized: Expressible, AnyExpressible where Value: Expressible {}
extension Lowercased: Expressible, AnyExpressible where Value: Expressible {}
extension Uppercased: Expressible, AnyExpressible where Value: Expressible {}
extension Stripped: Expressible, AnyExpressible where Value: Expressible {}
extension Truncated: Expressible, AnyExpressible where Value: Expressible {}
extension Collapsed: Expressible, AnyExpressible where Value: Expressible {}
extension Ragged: Expressible, AnyExpressible where Value: Expressible {}
extension Trimmed: Expressible, AnyExpressible where Value: Expressible {}


extension Array: Expressible {}
extension Dictionary: Expressible {}
extension Set: Expressible {}
extension String: Expressible {}
extension Character: Expressible {}
extension Double: Expressible {}
extension Float: Expressible {}
extension Int: Expressible {}
