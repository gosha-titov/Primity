/// A wrapper that ensures a value is non-negative.
///
/// Returns `nil` when attempting to wrap a negative value during initialization.
///
/// ## Example
/// ```
/// typealias PlayerLevel = NonNegative<Double>
///
/// let level: PlayerLevel? = 48.27
/// ```
public struct NonNegative<Value>: MaybeWrapping where Value: Negativable {
    
    /// The underlying non‑negative value.
    public let value: Value
    
    /// Creates an instance by wrapping the given value, or returns `nil` if the value is negative.
    public init?(_ value: Value) {
        guard !value.isNegative else { return nil }
        self.value = value
    }
    
}



// MARK: - Behavior Extensions

extension NonNegative: Equatable where Value: Equatable {}
extension NonNegative: Hashable where Value: Hashable {}
extension NonNegative: Sendable where Value: Sendable {}
