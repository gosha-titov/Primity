//public protocol WrappingWithIntegerExpressible: Wrapping, ExpressibleByIntegerLiteral where Value: ExpressibleByIntegerLiteral {
//    // No additional requirements
//}



// MARK: - Behavior Extensions

//extension WrappingWithIntegerExpressible {
//
//    public init(integerLiteral value: Value.IntegerLiteralType) {
//        self.init(Value(integerLiteral: value))
//    }
//
//}



// MARK: - Compatibility Extensions

extension Optional: @retroactive ExpressibleByIntegerLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Wrapped.Expressed.IntegerLiteralType) {
        self = Wrapped(expressing: Wrapped.Expressed(integerLiteral: value))
    }
    
}
