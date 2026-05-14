/// A type that can return a sorted version of itself.
public protocol Sortable {
    
    /// The type of elements in the collection.
    associatedtype Element
    
    /// Returns a sorted copy using the given comparison predicate.
    ///
    /// ## Example
    /// ```
    /// let array = [3, 1, 4, 2]
    /// array.sorted(by: <) // [1, 2, 3, 4]
    /// ```
    func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Self
    
}



// MARK: - Compatibility Extensions

extension Array: Sortable {}
