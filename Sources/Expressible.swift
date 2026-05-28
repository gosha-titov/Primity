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

extension Expressible {
    
    /// Creates an instance from the given raw value.
    public static func expressing(_ value: Expressed) -> Self {
        return Self(expressing: value)
    }
    
}


extension MaybeExpressible {
    
    /// Creates an instance from the given raw value, or returns `nil` if the value is invalid.
    public static func expressing(_ value: Expressed) -> Self? {
        return Self(expressing: value)
    }
    
}


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

extension AnyWrapping where Wrapped: AnyExpressible {
    public typealias Expressed = Wrapped.Expressed
    public func expressed() -> Wrapped.Expressed {
        return value.expressed()
    }
}

extension Wrapping where Wrapped: Expressible {
    public init(expressing value: Wrapped.Expressed) {
        self.init(Wrapped(expressing: value))
    }
}

extension MaybeWrapping where Wrapped: Expressible {
    public init?(expressing value: Wrapped.Expressed) {
        self.init(Wrapped(expressing: value))
    }
}

extension NonEmpty: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}
extension Within: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}
extension Sorted: Expressible, AnyExpressible where Wrapped: Expressible {}

extension NonNegative: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}
extension Positive: MaybeExpressible, AnyExpressible where Wrapped: Expressible {}
extension Clamped: Expressible, AnyExpressible where Wrapped: Expressible {}

extension Capitalized: Expressible, AnyExpressible where Wrapped: Expressible {}
extension Lowercased: Expressible, AnyExpressible where Wrapped: Expressible {}
extension Uppercased: Expressible, AnyExpressible where Wrapped: Expressible {}
extension Stripped: Expressible, AnyExpressible where Wrapped: Expressible {}
extension Truncated: Expressible, AnyExpressible where Wrapped: Expressible {}
extension Collapsed: Expressible, AnyExpressible where Wrapped: Expressible {}
extension Ragged: Expressible, AnyExpressible where Wrapped: Expressible {}
extension Trimmed: Expressible, AnyExpressible where Wrapped: Expressible {}


extension Array: Expressible {}
extension Dictionary: Expressible {}
extension Set: Expressible {}
extension String: Expressible {}
extension Character: Expressible {}
extension Double: Expressible {}
extension Float: Expressible {}
extension Int: Expressible {}
