/// A type that provides a static bound for range validation.
///
/// Typically implemented by empty enums that define compile-time range limits.
///
/// ## Example
/// ```
/// enum MinLength: Bound { static let value = 3 }
/// enum MaxLength: Bound { static let value = 10 }
/// ```
public protocol Bound: Sendable {
    
    /// The type of the bound value.
    associatedtype Value: Comparable
    
    /// The value of this bound.
    static var value: Value { get }
    
}



// MARK: - Default Implementations

/// Pre-defined bounds for common numeric values.
public enum Bounds {
    
    public enum `0`: Bound {
        public static let value = 0
    }
    
    public enum `0.0`: Bound {
        public static let value = 0.0
    }
    
    public enum `1`: Bound {
        public static let value = 1
    }
    
    public enum `1.0`: Bound {
        public static let value = 1.0
    }
    
    public enum `2`: Bound {
        public static let value = 2
    }
    
    public enum `3`: Bound {
        public static let value = 3
    }
    
    public enum `4`: Bound {
        public static let value = 4
    }
    
    public enum `5`: Bound {
        public static let value = 5
    }
    
    public enum `10`: Bound {
        public static let value = 10
    }
    
}
