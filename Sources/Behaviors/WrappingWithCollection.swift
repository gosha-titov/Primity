/// A bridging protocol that forwards `Collection` conformance through the wrapped value.
///
/// Conforming types receive default implementations for `Collection` requirements
/// that delegate index and element access to the underlying value.
public protocol WrappingWithCollection: AnyWrapping, Collection where Value: Collection {
    // No additional requirements
}


/// A bridging protocol that forwards `BidirectionalCollection` conformance through the wrapped value.
///
/// Conforming types receive default implementations for `BidirectionalCollection` requirements
/// that delegate index traversal to the underlying value.
public protocol WrappingWithBidirectionalCollection: AnyWrapping, BidirectionalCollection where Value: BidirectionalCollection {
    // No additional requirements
}



// MARK: - Behavior Extensions

extension WrappingWithCollection {
    
    public var startIndex: Value.Index { value.startIndex }
    
    public var endIndex: Value.Index { value.endIndex }
    
    public func makeIterator() -> Value.Iterator {
        return value.makeIterator()
    }
    
    public func index(after index: Value.Index) -> Value.Index {
        return value.index(after: index)
    }
    
    public subscript(index: Value.Index) -> Value.Element {
        get { value[index] }
    }
    
}


extension WrappingWithBidirectionalCollection {
    
    public func index(before index: Value.Index) -> Value.Index {
        return value.index(before: index)
    }
    
}



// MARK: - Compatibility Extensions

extension NonEmpty: WrappingWithCollection, Collection, Sequence where Value: Collection {}
extension InRange: WrappingWithCollection, Collection, Sequence where Value: Collection {}
extension Sorted: WrappingWithCollection, Collection, Sequence where Value: Collection {}

extension Capitalized: WrappingWithCollection, Collection, Sequence where Value: Collection {}
extension Lowercased: WrappingWithCollection, Collection, Sequence where Value: Collection {}
extension Uppercased: WrappingWithCollection, Collection, Sequence where Value: Collection {}
extension Stripped: WrappingWithCollection, Collection, Sequence where Value: Collection {}
extension Truncated: WrappingWithCollection, Collection, Sequence where Value: Collection {}
extension Collapsed: WrappingWithCollection, Collection, Sequence where Value: Collection {}
extension Ragged: WrappingWithCollection, Collection, Sequence where Value: Collection {}
extension Trimmed: WrappingWithCollection, Collection, Sequence where Value: Collection {}


extension NonEmpty: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
extension InRange: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
extension Sorted: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}

extension Capitalized: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
extension Lowercased: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
extension Uppercased: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
extension Stripped: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
extension Truncated: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
extension Collapsed: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
extension Ragged: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
extension Trimmed: WrappingWithBidirectionalCollection, BidirectionalCollection where Value: BidirectionalCollection {}
