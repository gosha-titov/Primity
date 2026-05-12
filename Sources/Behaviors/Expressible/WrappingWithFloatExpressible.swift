/// A bridging protocol that enables floating-point literal initialization through the wrapped value.
///
/// Conforming types can be created from floating-point literals when the wrapped value is itself `ExpressibleByFloatLiteral`.
///
/// ## Example
/// ```
/// typealias Progress = UnitInterval<Double>
///
/// let progress: Progerss = 0.97
/// ```
public protocol WrappingWithFloatExpressible: Wrapping, ExpressibleByFloatLiteral where Value: ExpressibleByFloatLiteral {
    // No additional requirements
}



// MARK: - Behavior Extensions

extension WrappingWithFloatExpressible {
    
    public init(floatLiteral value: Value.FloatLiteralType) {
        self.init(Value(floatLiteral: value))
    }
    
}



// MARK: - Compatibility Extensions

extension UnitInterval: WrappingWithFloatExpressible, ExpressibleByFloatLiteral where Value: ExpressibleByFloatLiteral {}


extension Optional: @retroactive ExpressibleByFloatLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Wrapped.Expressed.FloatLiteralType) {
        self = Wrapped(expressing: Wrapped.Expressed(floatLiteral: value))
    }
    
}
