/// A type that can be clamped to a closed range.
public protocol Clampable {
    
    /// The type used for range boundaries.
    associatedtype Bound: Comparable
    
    /// Returns a copy clamped to the given limiting range.
    func clamped(to bounds: ClosedRange<Bound>) -> Self
    
}



// MARK: - Compatibility Extensions

public extension Comparable {
    
    /// Returns an instance value clamped to the given limiting range.
    ///
    /// ## Example
    /// ```
    /// let limits = 5...8
    /// 3.clamped(to: limits) // 5
    /// 7.clamped(to: limits) // 7
    /// 9.clamped(to: limits) // 8
    /// ```
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return max(limits.lowerBound, min(self, limits.upperBound))
    }
    
}


extension Int: Clampable {}
extension Double: Clampable {}
extension Float: Clampable {}
