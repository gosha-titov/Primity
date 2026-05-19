/// A wrapper that ensures a value is non-empty.
///
/// Returns `nil` when attempting to wrap an empty value during initialization.
/// ## Example
/// ```
/// typealias Title = NonEmpty<String>
/// ```
public struct NonEmpty<Value>: MaybeWrapping where Value: Emptyable {
    
    /// The underlying non‑empty value.
    public let value: Value
    
    /// Creates an instance by wrapping the given value, or returns `nil` if the value is empty.
    public init?(_ value: Value) {
        guard !value.isEmpty else { return nil }
        self.value = value
    }
    
}



// MARK: - Behavior Extensions

extension NonEmpty where Value: Expressible, Value.Expressed: _PrimityArray {
    
    /// Creates a non-empty wrapper containing a single element.
    /// ## Example
    /// ```
    /// typealias Numbers = NonEmpty<Array<Int>>
    ///
    /// let numbers: Numbers = .single(10)
    /// ```
    public static func single(_ element: Expressed.Element) -> Self {
        return NonEmpty(expressing: [element] as! Expressed)!
    }
    
}


extension NonEmpty where Value: Expressible, Value.Expressed: _PrimitySet {
    
    /// Creates a non-empty wrapper containing a single-element set.
    /// ## Example
    /// ```
    /// typealias Numbers = NonEmpty<Set<Int>>
    ///
    /// let numbers: Numbers = .single(10)
    /// ```
    public static func single(_ element: Expressed.Element) -> Self {
        return NonEmpty(expressing: Set([element]) as! Expressed)!
    }
    
}


extension NonEmpty where Value: Expressible, Value.Expressed: _PrimityDictionary {
    
    /// Creates a non-empty wrapper containing a single key-value pair.
    /// ## Example
    /// ```
    /// typealias Greetings = NonEmpty<Dictionary<Stirng, String>>
    ///
    /// let numbers: Greetings = .single("Hello", for: "en")
    /// ```
    public static func single(_ value: Expressed.Value, for key: Expressed.Key) -> Self {
        return NonEmpty(expressing: [key: value] as! Expressed)!
    }
    
}


extension NonEmpty where Value: Collection {
    
    /// The first element of the collection.
    public var first: Value.Element { value.first! }
    
    /// Returns a random element of the collection.
    public func random() -> Value.Element {
        return value.randomElement()!
    }
    
}


extension NonEmpty where Value: BidirectionalCollection {
    
    /// The last element of the collection.
    public var last: Value.Element { value.last! }
    
}


extension NonEmpty where Value: Collection, Value.Element: Comparable {
    
    /// Returns the maximum element in the sequence.
    public func max() -> Value.Element {
        return value.max()!
    }
    
    /// Returns the minimum element in the sequence.
    public func min() -> Value.Element {
        return value.min()!
    }
    
}


extension NonEmpty: Sequence where Value: Sequence {}
extension NonEmpty: Collection where Value: Collection {}
extension NonEmpty: BidirectionalCollection where Value: BidirectionalCollection {}
extension NonEmpty: Equatable where Value: Equatable {}
extension NonEmpty: Hashable where Value: Hashable {}
extension NonEmpty: Sendable where Value: Sendable {}
extension NonEmpty: Codable where Value: Codable {}
