/// A type that provides a static integer bound for range validation.
///
/// Typically implemented by empty enums that define compile-time range limits.
///
/// ## Example
/// ```
/// enum MinLength: RangeBound { static let value = 3 }
/// enum MaxLength: RangeBound { static let value = 10 }
/// ```
public protocol RangeBound: Sendable {
    
    /// The integer value of this bound.
    static var value: Int { get }
    
}



// MARK: - Default Implementations

public enum RangeBoundOne: RangeBound, Sendable {
    public static let value = 1
}

public enum RangeBoundTwo: RangeBound, Sendable {
    public static let value = 2
}

public enum RangeBoundThree: RangeBound, Sendable {
    public static let value = 3
}

public enum RangeBoundFour: RangeBound, Sendable {
    public static let value = 4
}

public enum RangeBoundFive: RangeBound, Sendable {
    public static let value = 5
}

public enum RangeBoundNine: RangeBound, Sendable {
    public static let value = 9
}

public enum RangeBoundTen: RangeBound, Sendable {
    public static let value = 10
}
