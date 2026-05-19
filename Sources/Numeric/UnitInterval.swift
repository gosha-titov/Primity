/// A wrapper that clamps its value to the unit interval `0...1`.
///
/// Values below `0` become `0`; values above `1` become `1`.
/// ## Example
/// ```
/// typealias Progress = UnitInterval<Double>
///
/// let progress: Progress = 0.97
/// ```
public struct UnitInterval<Value>: Wrapping where Value: FloatingPoint {
    
    /// The underlying value between `0` and `1`.
    public let value: Value
    
    /// Creates an instance with the given value clamped to `0...1`.
    public init(_ value: Value) {
        self.value = value.clamped(to: 0...1)
    }
    
}



// MARK: - Behavior Extensions

extension UnitInterval: ExpressibleByFloatLiteral where Value: ExpressibleByFloatLiteral {}
extension UnitInterval: Equatable where Value: Equatable {}
extension UnitInterval: Hashable where Value: Hashable {}
extension UnitInterval: Sendable where Value: Sendable {}
extension UnitInterval: Codable where Value: Codable {}



// MARK: - Helpers

public extension Comparable {
    
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return max(limits.lowerBound, min(self, limits.upperBound))
    }
    
}
