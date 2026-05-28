/// A type that can be checked against a closed range.
public protocol Withinable {
    
    /// The type used for range boundaries.
    associatedtype Bound: Comparable
    
    /// Returns `true` if the instance falls within the given range.
    func isWithin(_ range: ClosedRange<Bound>) -> Bool
    
}



// MARK: - Compatibility Extensions

extension Array: Withinable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension String: Withinable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension Set: Withinable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension Dictionary: Withinable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(count)
    }
}

extension Int: Withinable {
    public func isWithin(_ range: ClosedRange<Int>) -> Bool {
        return range.contains(self)
    }
}

extension Double: Withinable {
    public func isWithin(_ range: ClosedRange<Double>) -> Bool {
        return range.contains(self)
    }
}

extension Float: Withinable {
    public func isWithin(_ range: ClosedRange<Float>) -> Bool {
        return range.contains(self)
    }
}
