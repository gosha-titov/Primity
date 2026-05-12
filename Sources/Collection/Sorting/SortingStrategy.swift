/// A sorting order definition for collection elements.
///
/// Conforming types provide a static comparison function that determines element order.
///
/// ## Example
/// ```
/// struct Strategy: SortingStrategy {
///
///     static func areInIncreasingOrder(lhs: Int, rhs: Int) -> Bool {
///         return lhs < rhs
///     }
///
/// }
/// ```
public protocol SortingStrategy: Sendable {
    
    /// The type of elements being compared.
    associatedtype Element
    
    /// Returns `true` if `lhs` should appear before `rhs` in a sorted collection.
    static func areInIncreasingOrder(lhs: Element, rhs: Element) -> Bool
    
}



// MARK: - Default Implementations

/// A sorting strategy that orders elements in ascending order (smallest first).
public enum AscendingSortingStrategy<Element>: SortingStrategy where Element: Comparable {
    
    static public func areInIncreasingOrder(lhs: Element, rhs: Element) -> Bool {
        return lhs < rhs
    }
    
}


/// A sorting strategy that orders elements in descending order (largest first).
public enum DescendingSortingStrategy<Element>: SortingStrategy where Element: Comparable {
    
    static public func areInIncreasingOrder(lhs: Element, rhs: Element) -> Bool {
        return lhs > rhs
    }
    
}
