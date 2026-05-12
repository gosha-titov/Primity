/// A bridging protocol that enables dictionary literal initialization through the wrapped value.
///
/// Conforming types can be created from dictionary literals when the wrapped value is itself `DictionaryExpressible`.
public protocol WrappingWithDictionaryExpressible: Wrapping, DictionaryExpressible where Value: DictionaryExpressible {
    // No additional requirements
}


public protocol DictionaryExpressible: ExpressibleByDictionaryLiteral where Key: Hashable {

    /// The key type of a dictionary literal.
    associatedtype Key

    /// The value type of a dictionary literal.
    associatedtype Value
    
    /// Creates an instance from the dictionary.
    init(dictionary: Dictionary<Key, Value>)

}



// MARK: - Behavior Extensions

extension WrappingWithDictionaryExpressible {
    public init(dictionary: Dictionary<Value.Key, Value.Value>) {
        self.init(Value(dictionary: dictionary))
    }
}

extension DictionaryExpressible {
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(dictionary: Dictionary(elements, uniquingKeysWith: { _, second in second }))
    }
}

extension Dictionary: DictionaryExpressible {
    public init(dictionary: Dictionary<Key, Value>) {
        self = dictionary
    }
}



// MARK: - Compatibility Extensions

extension Optional: @retroactive ExpressibleByDictionaryLiteral where Wrapped: MaybeExpressible, Wrapped.Expressed: DictionaryExpressible {
    
    public init(dictionaryLiteral elements: (Wrapped.Expressed.Key, Wrapped.Expressed.Value)...) {
        self = Wrapped(expressing: Wrapped.Expressed(dictionary: Dictionary(elements, uniquingKeysWith: { _, second in second })))
    }
    
}
