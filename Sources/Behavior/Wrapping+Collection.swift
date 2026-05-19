//
// Implementation Notes
// ––––––––––––––––––––
//
// In order to add a collection behavior for a wrapper, simply add these lines:
//
//      extension YourWrapper: Sequence where Value: Sequence {}
//      extension YourWrapper: Collection where Value: Collection {}
//      extension YourWrapper: BidirectionalCollection where Value: BidirectionalCollection {}
//
// No manual implementations are needed because the default ones are automatically provided.
//

extension AnyWrapping where Value: Sequence {
    
    public func makeIterator() -> Value.Iterator {
        return value.makeIterator()
    }
    
}


extension AnyWrapping where Value: Collection {
    
    public var startIndex: Value.Index { value.startIndex }
    
    public var endIndex: Value.Index { value.endIndex }
    
    public func index(after index: Value.Index) -> Value.Index {
        return value.index(after: index)
    }
    
    public subscript(index: Value.Index) -> Value.Element {
        get { value[index] }
    }
    
}


extension AnyWrapping where Value: BidirectionalCollection {
    
    public func index(before index: Value.Index) -> Value.Index {
        return value.index(before: index)
    }
    
}
