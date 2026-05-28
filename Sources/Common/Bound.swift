/// A type that provides a static bound for range validation.
///
/// Typically implemented by empty enums that define compile-time range limits.
///
/// ## Example
/// ```
/// extension Bound {
///     enum `16`: Bounding {
///         static let value = 16
///     }
/// }
/// ```
public protocol Bounding: Sendable {
    
    /// The type of the bound value.
    associatedtype Value: Comparable
    
    /// The value of this bound.
    static var value: Value { get }
    
}



// MARK: - Default Implementations

/// Pre-defined bounds for common numeric values.
public enum Bound {
    
    public enum `0`: Bounding {
        public static let value = 0
    }
    
    public enum `0.0`: Bounding {
        public static let value = 0.0
    }
    
    public enum `1`: Bounding {
        public static let value = 1
    }
    
    public enum `1.0`: Bounding {
        public static let value = 1.0
    }
    
    public enum `2`: Bounding {
        public static let value = 2
    }
    
    public enum `3`: Bounding {
        public static let value = 3
    }
    
    public enum `4`: Bounding {
        public static let value = 4
    }
    
    public enum `5`: Bounding {
        public static let value = 5
    }
    
    public enum `10`: Bounding {
        public static let value = 10
    }
    
    public enum `100`: Bounding {
        public static let value = 100
    }
    
}
