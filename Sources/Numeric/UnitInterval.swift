/// A wrapper that clamps its value to the unit interval `0...1`.
///
/// Values below `0` become `0`; values above `1` become `1`.
/// ## Example
/// ```
/// typealias Progress = UnitInterval<Double>
///
/// let progress: Progress = 0.97
/// ```
public struct UnitInterval<Wrapped>: Wrapping where Wrapped: FloatingPoint {
    
    /// The underlying value between `0` and `1`.
    public let value: Wrapped
    
    /// Creates an instance with the given value clamped to `0...1`.
    public init(_ value: Wrapped) {
        self.value = value.clamped(to: 0...1)
    }
    
}



// MARK: - Behavior Extensions

extension UnitInterval: ExpressibleByFloatLiteral where Wrapped: ExpressibleByFloatLiteral {}
extension UnitInterval: Equatable where Wrapped: Equatable {}
extension UnitInterval: Hashable where Wrapped: Hashable {}
extension UnitInterval: Sendable where Wrapped: Sendable {}
extension UnitInterval: Codable where Wrapped: Codable {}



// MARK: - Helpers

public extension Comparable {
    
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return max(limits.lowerBound, min(self, limits.upperBound))
    }
    
}
