/// A type that can be checked against a closed range.
public protocol Rangable {
    
    /// The type used for range boundaries.
    associatedtype RangeBound: Comparable
    
    /// Returns `true` if the instance falls within the given range.
    func isWithin(_ range: ClosedRange<RangeBound>) -> Bool
    
}



// MARK: - Compatibility Extensions

extension Array: Rangable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension String: Rangable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension Set: Rangable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension Dictionary: Rangable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension Int: Rangable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(self)
    }
}

extension Double: Rangable {
    public func isWithin(_ range: ClosedRange<Double>) -> Bool {
        return range.contains(self)
    }
}

extension Float: Rangable {
    public func isWithin(_ range: ClosedRange<Float>) -> Bool {
        return range.contains(self)
    }
}
