/// A wrapper that ensures a value is non-negative.
///
/// Returns `nil` when attempting to wrap a negative value during initialization.
/// ## Example
/// ```
/// typealias PlayerLevel = NonNegative<Double>
///
/// let level: PlayerLevel? = 48.27
/// ```
public struct NonNegative<Wrapped>: MaybeWrapping where Wrapped: Negativable {
    
    /// The underlying non‑negative value.
    public let value: Wrapped
    
    /// Creates an instance by wrapping the given value, or returns `nil` if the value is negative.
    public init?(_ value: Wrapped) {
        guard !value.isNegative else { return nil }
        self.value = value
    }
    
}



// MARK: - Behavior Extensions

extension NonNegative {
    
    public static func errorMessage(for value: Wrapped) -> String {
        return "Value '\(value)' must not be negative"
    }
    
}

extension NonNegative: Equatable where Wrapped: Equatable {}
extension NonNegative: Hashable where Wrapped: Hashable {}
extension NonNegative: Sendable where Wrapped: Sendable {}
extension NonNegative: Codable where Wrapped: Codable {}
