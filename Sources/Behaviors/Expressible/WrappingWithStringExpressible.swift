/// A bridging protocol that enables string literal initialization through the wrapped value.
///
/// Conforming types can be created from string literals when the wrapped value is itself `ExpressibleByStringLiteral`.
/// 
/// ## Example
/// ```
/// typealias Name = Capitalized<Collapsed<Trimmed<String>>>
///
/// let name: Name = "Mia"
/// ```
public protocol WrappingWithStringExpressible: Wrapping, ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {
    // No additional requirements
}



// MARK: - Behavior Extensions

extension WrappingWithStringExpressible {
    
    public init(stringLiteral value: Value.StringLiteralType) {
        self.init(Value(stringLiteral: value))
    }
    
}



// MARK: - Compatibility Extensions

extension Capitalized: WrappingWithStringExpressible, _ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {}
extension Lowercased: WrappingWithStringExpressible, _ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {}
extension Uppercased: WrappingWithStringExpressible, _ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {}
extension Stripped: WrappingWithStringExpressible, _ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {}
extension Truncated: WrappingWithStringExpressible, _ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {}
extension Collapsed: WrappingWithStringExpressible, _ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {}
extension Ragged: WrappingWithStringExpressible, _ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {}
extension Trimmed: WrappingWithStringExpressible, _ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {}


extension Optional: @retroactive _ExpressibleByStringLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: Wrapped.Expressed.StringLiteralType) {
        self = Wrapped(expressing: Wrapped.Expressed(stringLiteral: value))
    }
    
}


public typealias _ExpressibleByStringLiteral = ExpressibleByStringLiteral & ExpressibleByExtendedGraphemeClusterLiteral & ExpressibleByUnicodeScalarLiteral
