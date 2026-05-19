/// A wrapper that ensures a value is positive.
///
/// Returns `nil` when attempting to wrap a non-positive value during initialization.
/// ## Example
/// ```
/// typealias PieChartSliceValue = Positive<Double>
///
/// let value: PieChartSliceValue? = 263.333
/// ```
public struct Positive<Value>: MaybeWrapping where Value: Positivable {
    
    /// The underlying positive value.
    public let value: Value
    
    /// Creates an instance by wrapping the given value, or returns `nil` if the value is not positive.
    public init?(_ value: Value) {
        guard value.isPositive else { return nil }
        self.value = value
    }
    
}



// MARK: - Behavior Extensions

extension Positive: Equatable where Value: Equatable {}
extension Positive: Hashable where Value: Hashable {}
extension Positive: Sendable where Value: Sendable {}
extension Positive: Codable where Value: Codable {}
