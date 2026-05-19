//
// Implementation Notes
// ––––––––––––––––––––
//
// In order to make a wrapper expressible by literals, simply add needed lines:
//
//      extension YourWrapper: ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
//      extension YourWrapped: DictionaryExpressible, ExpressibleByDictionaryLiteral where Value: DictionaryExpressible {}
//      extension YourWrapper: ExpressibleByStringLiteral  & ExpressibleByExtendedGraphemeClusterLiteral & ExpressibleByUnicodeScalarLiteral where Value: ExpressibleByStringLiteral {}
//      extension YourWrapper: ExpressibleByIntegerLiteral where Value: ExpressibleByIntegerLiteral {}
//      extension YourWrapper: ExpressibleByFloatLiteral where Value: ExpressibleByFloatLiteral {}
//
// No manual implementations are needed because the default ones are automatically provided.
//

/// A type that can be initialized with an array value.
public protocol ArrayExpressible: ExpressibleByArrayLiteral {
    
    /// The type of the elements of an array literal.
    associatedtype ArrayLiteralElement
    
    /// Creates an instance from the array.
    init(array: [ArrayLiteralElement])
    
}


extension Wrapping where Value: ArrayExpressible {
    
    public init(arrayLiteral elements: Value.ArrayLiteralElement...) {
        self.init(array: elements)
    }
    
    public init(array: [Value.ArrayLiteralElement]) {
        self.init(Value(array: array))
    }
    
}


extension Optional: @retroactive ExpressibleByArrayLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ArrayExpressible {
    
    public init(arrayLiteral elements: Wrapped.Expressed.ArrayLiteralElement...) {
        self = Wrapped(expressing: Wrapped.Expressed(array: elements))
    }
    
}



// MARK: - Dictionary

public protocol DictionaryExpressible: ExpressibleByDictionaryLiteral where Key: Hashable {

    /// The key type of a dictionary literal.
    associatedtype Key

    /// The value type of a dictionary literal.
    associatedtype Value
    
    /// Creates an instance from the dictionary.
    init(dictionary: Dictionary<Key, Value>)

}


extension Wrapping where Value: DictionaryExpressible {
    
    public init(dictionaryLiteral elements: (Value.Key, Value.Value)...) {
        self.init(dictionary: Dictionary(elements, uniquingKeysWith: { _, second in second }))
    }
    
    public init(dictionary: Dictionary<Value.Key, Value.Value>) {
        self.init(Value(dictionary: dictionary))
    }
    
}


extension Optional: @retroactive ExpressibleByDictionaryLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: DictionaryExpressible {
    
    public init(dictionaryLiteral elements: (Wrapped.Expressed.Key, Wrapped.Expressed.Value)...) {
        self = Wrapped(expressing: Wrapped.Expressed(dictionary: Dictionary(elements, uniquingKeysWith: { _, second in second })))
    }
    
}



// MARK: - String

extension Wrapping where Value: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: Value.StringLiteralType) {
        self.init(Value(stringLiteral: value))
    }
    
}


extension Optional: @retroactive ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: Wrapped.Expressed.StringLiteralType) {
        self = Wrapped(expressing: Wrapped.Expressed(stringLiteral: value))
    }
    
}



// MARK: - Integer

extension Wrapping where Value: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Value.IntegerLiteralType) {
        self.init(Value(integerLiteral: value))
    }
    
}


extension Optional: @retroactive ExpressibleByIntegerLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Wrapped.Expressed.IntegerLiteralType) {
        self = Wrapped(expressing: Wrapped.Expressed(integerLiteral: value))
    }
    
}



// MARK: - Float

extension Wrapping where Value: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Value.FloatLiteralType) {
        self.init(Value(floatLiteral: value))
    }
    
}


extension Optional: @retroactive ExpressibleByFloatLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Wrapped.Expressed.FloatLiteralType) {
        self = Wrapped(expressing: Wrapped.Expressed(floatLiteral: value))
    }
    
}



// MARK: - Compatibility Extensions

extension Array: ArrayExpressible {
    public init(array: [Element]) {
        self = array
    }
}

extension Dictionary: DictionaryExpressible {
    public init(dictionary: Dictionary<Key, Value>) {
        self = dictionary
    }
}

extension Set: ArrayExpressible where ArrayLiteralElement: Hashable {
    public init(array: [Element]) {
        self = Set(array)
    }
}
