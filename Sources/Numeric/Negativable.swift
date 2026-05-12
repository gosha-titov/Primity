/// A type that can indicate whether it is negative.
public protocol Negativable {
    
    /// A boolean value indicating whether the instance is negative.
    var isNegative: Bool { get }
    
}



// MARK: - Compatibility Extensions

extension Double: Negativable {
    public var isNegative: Bool {
        return self < .zero
    }
}

extension Float: Negativable {
    public var isNegative: Bool {
        return self < .zero
    }
}

extension Int: Negativable {
    public var isNegative: Bool {
        return self < .zero
    }
}
