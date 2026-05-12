/// A wrapper that ensures a value is non-empty.
///
/// Returns `nil` when attempting to wrap an empty value during initialization.
///
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


extension NonEmpty: Equatable where Value: Equatable {}
extension NonEmpty: Hashable where Value: Hashable {}
extension NonEmpty: Sendable where Value: Sendable {}
