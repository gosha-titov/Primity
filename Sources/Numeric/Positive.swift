/// A wrapper that ensures a value is positive.
///
/// Returns `nil` when attempting to wrap a non-positive value during initialization.
/// ## Example
/// ```
/// typealias PieChartSliceValue = Positive<Double>
///
/// let value: PieChartSliceValue? = 263.333
/// ```
public struct Positive<Wrapped>: MaybeWrapping where Wrapped: Positivable {
    
    /// The underlying positive value.
    public let value: Wrapped
    
    /// Creates an instance by wrapping the given value, or returns `nil` if the value is not positive.
    public init?(_ value: Wrapped) {
        guard value.isPositive else { return nil }
        self.value = value
    }
    
}



// MARK: - Behavior Extensions

extension Positive {
    
    public static func errorMessage(for value: Wrapped) -> String {
        return "Value '\(value)' must be positive"
    }
    
}


extension Positive: Equatable where Wrapped: Equatable {}
extension Positive: Hashable where Wrapped: Hashable {}
extension Positive: Sendable where Wrapped: Sendable {}
extension Positive: Codable where Wrapped: Codable {}
