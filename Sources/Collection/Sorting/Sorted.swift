/// A wrapper that sorts a collection on creation
///
/// The collection is sorted using the specified strategy during initialization.
///
/// ## Example
/// ```
/// typealias Strategy = AscendingSortingStrategy<Int>
/// typealias Numbers = Sorted<Array<Int>, Strategy>
///
/// let numbers: Numbers = [3, 1, 4, 2]
/// print(numbers) // [1, 2, 3, 4]
/// ```
public struct Sorted<Value: Sortable, Strategy: SortingStrategy>: Wrapping where Value.Element == Strategy.Element {
    
    /// The underlying sorted collection value.
    public let value: Value
    
    /// Creates an instance by sorting the given collection.
    public init(_ value: Value) {
        self.value = value.sorted(by: Strategy.areInIncreasingOrder(lhs:rhs:))
    }
    
}



// MARK: - Default Implementations

/// A wrapper that sorts a collection in ascending order on creation
///
/// ## Example
/// ```
/// typealias Numbers = Ascended<Array<Int>>
///
/// let numbers: Numbers = [2, 4, 1, 5, 3]
/// print(numbers) // [1, 2, 3, 4, 5]
/// ```
public typealias Ascended<Value: Sortable> = Sorted<Value, AscendingSortingStrategy<Value.Element>> where Value.Element: Comparable

/// A wrapper that sorts a collection in descending order on creation
///
/// ## Example
/// ```
/// typealias Numbers = Descended<Array<Int>>
///
/// let numbers: Numbers = [2, 4, 1, 5, 3]
/// print(numbers) // [5, 4, 3, 2, 1]
/// ```
public typealias Descended<Value: Sortable> = Sorted<Value, DescendingSortingStrategy<Value.Element>> where Value.Element: Comparable



// MARK: - Behavior Extensions

extension Sorted: Equatable where Value: Equatable {}
extension Sorted: Hashable where Value: Hashable {}
extension Sorted: Sendable where Value: Sendable {}
