/// A wrapper that ensures a value is non-empty.
///
/// Returns `nil` when attempting to wrap an empty value during initialization.
///
/// ## Example
/// ```
/// typealias Title = NonEmpty<String>
///
/// let title: Title? = "Swift Development"
/// ```
public struct NonEmpty<Wrapped>: MaybeWrapping where Wrapped: Emptyable {
    
    /// The underlying non‑empty value.
    public let value: Wrapped
    
    /// Creates an instance by wrapping the given value, or returns `nil` if the value is empty.
    public init?(_ value: Wrapped) {
        guard !value.isEmpty else { return nil }
        self.value = value
    }
    
}



// MARK: - Behavior Extensions

extension NonEmpty {

    public static func errorMessage(for value: Wrapped) -> String {
        return "Value must not be empty"
    }
    
    /// Creates an instance by wrapping the given value, or returns `nil` if the value doesn't exist or empty.
    public init?(_ value: Wrapped?) {
        guard let value, !value.isEmpty else { return nil }
        self.value = value
    }
    
}


extension NonEmpty where Wrapped: Expressible {
    
    /// Creates an instance from the given raw value, or returns `nil` if the value doesn't exist or empty.
    public static func expressing(_ value: Expressed?) -> Self? {
        return Self(expressing: value)
    }
    
    /// Creates an instance from the given raw value, or returns `nil` if the value doesn't exist or empty.
    public init?(expressing value: Wrapped.Expressed?) {
        guard let value else { return nil }
        self.init(expressing: value)
    }
    
}


extension NonEmpty where Wrapped: Expressible, Wrapped.Expressed: _PrimityArray {
    
    /// Creates a non-empty wrapper containing a single element.
    ///
    /// ## Example
    /// ```
    /// typealias Numbers = NonEmpty<Array<Int>>
    ///
    /// let numbers = Numbers.single(10)
    /// ```
    public static func single(_ element: Expressed.Element) -> Self {
        return NonEmpty(expressing: [element] as! Expressed)!
    }
    
}


extension NonEmpty where Wrapped: Expressible, Wrapped.Expressed: _PrimitySet {
    
    /// Creates a non-empty wrapper containing a single element.
    ///
    /// ## Example
    /// ```
    /// typealias Numbers = NonEmpty<Set<Int>>
    ///
    /// let numbers = Numbers.single(10)
    /// ```
    public static func single(_ element: Expressed.Element) -> Self {
        return NonEmpty(expressing: Set([element]) as! Expressed)!
    }
    
}


extension NonEmpty where Wrapped: Expressible, Wrapped.Expressed: _PrimityDictionary {
    
    /// Creates a non-empty wrapper containing a single key-value pair.
    ///
    /// ## Example
    /// ```
    /// typealias Greetings = NonEmpty<Dictionary<Stirng, String>>
    ///
    /// let greetings = Greetings.single("Hello", for: "en")
    /// ```
    public static func single(_ value: Expressed.Value, for key: Expressed.Key) -> Self {
        return NonEmpty(expressing: [key: value] as! Expressed)!
    }
    
}


extension NonEmpty where Wrapped: Collection {
    
    /// The first element of the collection.
    public var first: Wrapped.Element { value.first! }
    
    /// Returns a random element of the collection.
    public func random() -> Wrapped.Element {
        return value.randomElement()!
    }
    
}


extension NonEmpty where Wrapped: BidirectionalCollection {
    
    /// The last element of the collection.
    public var last: Wrapped.Element { value.last! }
    
}


extension NonEmpty where Wrapped: Collection, Wrapped.Element: Comparable {
    
    /// Returns the maximum element in the sequence.
    public func max() -> Wrapped.Element {
        return value.max()!
    }
    
    /// Returns the minimum element in the sequence.
    public func min() -> Wrapped.Element {
        return value.min()!
    }
    
}


extension NonEmpty: Sequence where Wrapped: Sequence {}
extension NonEmpty: Collection where Wrapped: Collection {}
extension NonEmpty: BidirectionalCollection where Wrapped: BidirectionalCollection {}
extension NonEmpty: Equatable where Wrapped: Equatable {}
extension NonEmpty: Hashable where Wrapped: Hashable {}
extension NonEmpty: Sendable where Wrapped: Sendable {}
extension NonEmpty: Codable where Wrapped: Codable {}
