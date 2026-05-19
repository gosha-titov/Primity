/// A type that can be checked against a closed range.
public protocol Boundable {
    
    /// The type used for range boundaries.
    associatedtype Bound: Comparable
    
    /// Returns `true` if the instance falls within the given range.
    func isWithin(_ range: ClosedRange<Bound>) -> Bool
    
}



// MARK: - Compatibility Extensions

extension Array: Boundable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension String: Boundable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension Set: Boundable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension Dictionary: Boundable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension Int: Boundable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(self)
    }
}

extension Double: Boundable {
    public func isWithin(_ range: ClosedRange<Double>) -> Bool {
        return range.contains(self)
    }
}

extension Float: Boundable {
    public func isWithin(_ range: ClosedRange<Float>) -> Bool {
        return range.contains(self)
    }
}
