//
// Implementation Notes
// ––––––––––––––––––––
//
// In order to add a collection behavior for a wrapper, simply add these lines:
//
//      extension YourWrapper: Sequence where Wrapped: Sequence {}
//      extension YourWrapper: Collection where Wrapped: Collection {}
//      extension YourWrapper: BidirectionalCollection where Wrapped: BidirectionalCollection {}
//
// No manual implementations are needed because the default ones are automatically provided.
//

extension AnyWrapping where Wrapped: Sequence {
    
    public func makeIterator() -> Wrapped.Iterator {
        return value.makeIterator()
    }
    
}


extension AnyWrapping where Wrapped: Collection {
    
    public var startIndex: Wrapped.Index { value.startIndex }
    
    public var endIndex: Wrapped.Index { value.endIndex }
    
    public func index(after index: Wrapped.Index) -> Wrapped.Index {
        return value.index(after: index)
    }
    
    public subscript(index: Wrapped.Index) -> Wrapped.Element {
        get { value[index] }
    }
    
}


extension AnyWrapping where Wrapped: BidirectionalCollection {
    
    public func index(before index: Wrapped.Index) -> Wrapped.Index {
        return value.index(before: index)
    }
    
}
