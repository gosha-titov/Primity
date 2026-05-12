/// A protocol that combines representable access with guaranteed expressible initialization.
///
/// Conforming types can use immutable mutation methods that return new wrapped instances.
///
/// Use this for wrappers that always succeed when created from an expressed value.
public protocol WrappingWithMethods: WrappingWithRepresentable, Expressible {
    // No additional requirements
}

/// A protocol that combines representable access with failable expressible initialization.
///
/// Conforming types can use immutable mutation methods that return new wrapped instances.
///
/// Use this for wrappers that may return `nil` when created from an expressed value.
public protocol MaybeWrappingWithMethods: WrappingWithRepresentable, MaybeExpressible {
    // No additional requirements
}



// MARK: - Array Extensions

extension WrappingWithMethods where Expressed: _PrimityArray {
    
    /// Returns a copy with the element added to the end of the array.
    public func appending(_ newElement: Expressed.Element) -> Self {
        return mutated { $0.append(newElement) }
    }
    
    /// Returns a copy with the elements added to the end of the array.
    public func appending<S: Sequence>(contentsOf newElements: S) -> Self where S.Element == Expressed.Element {
        return mutated { $0.append(contentsOf: newElements) }
    }
    
    /// Returns a copy with the element added at the beginning of the array.
    public func preprending(_ newElement: Expressed.Element) -> Self {
        return mutated { $0.insert(newElement, at: .zero) }
    }
    
    /// Returns a copy with the elements added at the beginning of the array.
    public func preprending<C: Collection>(contentsOf newElements: C) -> Self where C.Element == Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: .zero) }
    }
    
    /// Returns a copy with the element inserted at the specified position.
    public func inserting(_ newElement: Expressed.Element, at index: Int) -> Self {
        return mutated { $0.insert(newElement, at: index) }
    }
    
    /// Returns a copy with elements inserted at the specified position.
    public func inserting<C: Collection>(contentsOf newElements: C, at index: Int) -> Self where C.Element == Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: index) }
    }
    
    /// Returns a copy with the element set at the specified position.
    public func setting(_ newElement: Expressed.Element, at index: Int) -> Self {
        return mutated { $0[index] = newElement }
    }
    
    /// Returns a copy with the element removed at the specified position.
    public func removing(at index: Int) -> Self {
        return mutated { $0.remove(at: index) }
    }
    
    /// Returns a copy containing all elements but the specified one.
    public func removing(_ oldElement: Expressed.Element) -> Self where Expressed.Element: Equatable {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy containing all elements but the specified ones.
    public func removing<S: Sequence>(contentsOf oldElements: S) -> Self where S.Element == Expressed.Element, S.Element: Equatable {
        return mutated { $0.remove(contentsOf: oldElements) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Expressed.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Expressed.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Expressed.Element]) throws -> Void) rethrows -> Self {
        var array = asArray()
        try mutate(&array)
        return Self(expressing: array as! Expressed)
    }
    
}



extension MaybeWrappingWithMethods where Expressed: _PrimityArray {
    
    /// Returns a copy with the element added to the end of the array.
    public func appending(_ newElement: Expressed.Element) -> Self? {
        return mutated { $0.append(newElement) }
    }
    
    /// Returns a copy with the elements added to the end of the array.
    public func appending<S: Sequence>(contentsOf newElements: S) -> Self? where S.Element == Expressed.Element {
        return mutated { $0.append(contentsOf: newElements) }
    }
    
    /// Returns a copy with the element added at the beginning of the array.
    public func preprending(_ newElement: Expressed.Element) -> Self? {
        return mutated { $0.insert(newElement, at: .zero) }
    }
    
    /// Returns a copy with the elements added at the beginning of the array.
    public func preprending<C: Collection>(contentsOf newElements: C) -> Self? where C.Element == Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: .zero) }
    }
    
    /// Returns a copy with the element inserted at the specified position.
    public func inserting(_ newElement: Expressed.Element, at index: Int) -> Self? {
        return mutated { $0.insert(newElement, at: index) }
    }
    
    /// Returns a copy with elements inserted at the specified position.
    public func inserting<C: Collection>(contentsOf newElements: C, at index: Int) -> Self? where C.Element == Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: index) }
    }
    
    /// Returns a copy with the element set at the specified position.
    public func setting(_ newElement: Expressed.Element, at index: Int) -> Self? {
        return mutated { $0[index] = newElement }
    }
    
    /// Returns a copy with the element removed at the specified position.
    public func removing(at index: Int) -> Self? {
        return mutated { $0.remove(at: index) }
    }
    
    /// Returns a copy containing all elements but the specified one.
    public func removing(_ oldElement: Expressed.Element) -> Self? where Expressed.Element: Equatable {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy containing all elements but the specified ones.
    public func removing<S: Sequence>(contentsOf oldElements: S) -> Self? where S.Element == Expressed.Element, S.Element: Equatable {
        return mutated { $0.remove(contentsOf: oldElements) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Expressed.Element]) throws -> Void) rethrows -> Self? {
        var array = asArray()
        try mutate(&array)
        return Self(expressing: array as! Expressed)
    }
    
}



// MARK: - Set Extensions

extension WrappingWithMethods where Expressed: _PrimitySet {
    
    /// Returns a copy with the element inserted.
    public func inserting(_ newElement: Expressed.Element) -> Self {
        return mutated { $0.insert(newElement) }
    }
    
    /// Returns a copy with the element inserted.
    public func inserting<S: Sequence>(contentsOf newElements: S) -> Self where S.Element == Expressed.Element {
        return mutated { $0 = $0.union(newElements) }
    }
    
    /// Returns a copy with the element removed.
    public func removing(_ oldElement: Expressed.Element) -> Self {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy with the elements removed.
    public func removing<S: Sequence>(contentsOf oldElement: S) -> Self where S.Element == Expressed.Element {
        return mutated { $0.subtract(oldElement) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Expressed.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Expressed.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Set<Expressed.Element>) throws -> Void) rethrows -> Self {
        var set = asSet()
        try mutate(&set)
        return Self(expressing: set as! Expressed)
    }
    
}



extension MaybeWrappingWithMethods where Expressed: _PrimitySet {
    
    /// Returns a copy with the element inserted.
    public func inserting(_ newElement: Expressed.Element) -> Self? {
        return mutated { $0.insert(newElement) }
    }
    
    /// Returns a copy with the element inserted.
    public func inserting<S: Sequence>(contentsOf newElements: S) -> Self? where S.Element == Expressed.Element {
        return mutated { $0 = $0.union(newElements) }
    }
    
    /// Returns a copy with the element removed.
    public func removing(_ oldElement: Expressed.Element) -> Self? {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy with the elements removed.
    public func removing<S: Sequence>(contentsOf oldElement: S) -> Self? where S.Element == Expressed.Element {
        return mutated { $0.subtract(oldElement) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Set<Expressed.Element>) throws -> Void) rethrows -> Self? {
        var set = asSet()
        try mutate(&set)
        return Self(expressing: set as! Expressed)
    }
    
}



// MARK: - Dictionary Extensions

extension WrappingWithMethods where Expressed: _PrimityDictionary {
    
    /// Returns a copy with the value updated or added for the specified key.
    public func setting(_ newValue: Expressed.Value, for key: Expressed.Key) -> Self {
        return mutated { $0[key] = newValue }
    }
    
    /// Returns a copy with a value removed for the specified key.
    public func removing(for key: Expressed.Key) -> Self {
        return mutated { $0[key] = nil }
    }
    
    /// Returns a copy containing the key-value pairs except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Dictionary<Expressed.Key, Expressed.Value>.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Dictionary<Expressed.Key, Expressed.Value>.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Dictionary<Expressed.Key, Expressed.Value>) throws -> Void) rethrows -> Self {
        var dictionary = asDictionary()
        try mutate(&dictionary)
        return Self(expressing: dictionary as! Expressed)
    }
    
}



extension MaybeWrappingWithMethods where Expressed: _PrimityDictionary {
    
    /// Returns a copy with the value updated or added for the specified key.
    public func setting(_ newValue: Expressed.Value, for key: Expressed.Key) -> Self? {
        return mutated { $0[key] = newValue }
    }
    
    /// Returns a copy with a value removed for the specified key.
    public func removing(for key: Expressed.Key) -> Self? {
        return mutated { $0[key] = nil }
    }
    
    /// Returns a copy containing the key-value pairs except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Dictionary<Expressed.Key, Expressed.Value>.Element) throws -> Bool) rethrows -> Self? {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Dictionary<Expressed.Key, Expressed.Value>.Element) throws -> Bool) rethrows -> Self? {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Dictionary<Expressed.Key, Expressed.Value>) throws -> Void) rethrows -> Self? {
        var dictionary = asDictionary()
        try mutate(&dictionary)
        return Self(expressing: dictionary as! Expressed)
    }
    
}



// MARK: - String Extensions

extension WrappingWithMethods where Expressed == String {
    
    /// Returns a copy with the character added to the end of the string.
    public func appending(_ newCharacter: Character) -> Self {
        return mutated { $0.append(newCharacter) }
    }
    
    /// Returns a copy with the characters added to the end of the string.
    public func appending<S: Sequence>(contentsOf newCharacters: S) -> Self where S.Element == Character {
        return mutated { $0.append(contentsOf: newCharacters) }
    }
    
    /// Returns a copy with the character added at the beginning of the array.
    public func preprending(_ newCharacter: Character) -> Self {
        return mutated { $0.insert(newCharacter, at: $0.startIndex) }
    }
    
    /// Returns a copy with the characters added at the beginning of the array.
    public func preprending<C: Collection>(contentsOf newCharacters: C) -> Self where C.Element == Character {
        return mutated { $0.insert(contentsOf: newCharacters, at: $0.startIndex) }
    }
    
    /// Returns a copy with the character inserted at the specified position.
    public func inserting(_ newCharacter: Character, at index: String.Index) -> Self {
        return mutated { $0.insert(newCharacter, at: index) }
    }
    
    /// Returns a copy with the characters inserted at the specified position.
    public func inserting<C: Collection>(contentsOf newCharacters: C, at index: String.Index) -> Self where C.Element == Character {
        return mutated { $0.insert(contentsOf: newCharacters, at: index) }
    }
    
    /// Returns a copy with the character removed at the specified position.
    public func removing(at index: String.Index) -> Self {
        return mutated { $0.remove(at: index) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout String) throws -> Void) rethrows -> Self {
        var string = asString()
        try mutate(&string)
        return Self(expressing: string)
    }
    
}



extension MaybeWrappingWithMethods where Expressed == String {
    
    /// Returns a copy with the character added to the end of the string.
    public func appending(_ newCharacter: Character) -> Self? {
        return mutated { $0.append(newCharacter) }
    }
    
    /// Returns a copy with the characters added to the end of the string.
    public func appending<S: Sequence>(contentsOf newCharacters: S) -> Self? where S.Element == Character {
        return mutated { $0.append(contentsOf: newCharacters) }
    }
    
    /// Returns a copy with the character added at the beginning of the array.
    public func preprending(_ newCharacter: Character) -> Self? {
        return mutated { $0.insert(newCharacter, at: $0.startIndex) }
    }
    
    /// Returns a copy with the characters added at the beginning of the array.
    public func preprending<C: Collection>(contentsOf newCharacters: C) -> Self? where C.Element == Character {
        return mutated { $0.insert(contentsOf: newCharacters, at: $0.startIndex) }
    }
    
    /// Returns a copy with the character inserted at the specified position.
    public func inserting(_ newCharacter: Character, at index: String.Index) -> Self? {
        return mutated { $0.insert(newCharacter, at: index) }
    }
    
    /// Returns a copy with the characters inserted at the specified position.
    public func inserting<C: Collection>(contentsOf newCharacters: C, at index: String.Index) -> Self? where C.Element == Character {
        return mutated { $0.insert(contentsOf: newCharacters, at: index) }
    }
    
    /// Returns a copy with the character removed at the specified position.
    public func removing(at index: String.Index) -> Self? {
        return mutated { $0.remove(at: index) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout String) throws -> Void) rethrows -> Self? {
        var string = asString()
        try mutate(&string)
        return Self(expressing: string)
    }
    
}



// MARK: - Compatibility Extensions

extension NonEmpty: MaybeWrappingWithMethods where Value: Expressible {}
extension InRange: MaybeWrappingWithMethods where Value: Expressible {}
extension Sorted: WrappingWithMethods where Value: Expressible {}

extension Capitalized: WrappingWithMethods where Value: Expressible {}
extension Lowercased: WrappingWithMethods where Value: Expressible {}
extension Uppercased: WrappingWithMethods where Value: Expressible {}
extension Stripped: WrappingWithMethods where Value: Expressible {}
extension Truncated: WrappingWithMethods where Value: Expressible {}
extension Collapsed: WrappingWithMethods where Value: Expressible {}
extension Ragged: WrappingWithMethods where Value: Expressible {}
extension Trimmed: WrappingWithMethods where Value: Expressible {}



// MARK: - Helpers

extension Array where Element: Equatable {

    mutating func remove(_ oldElement: Element) {
        removeAll(where: { $0 == oldElement })
    }
    
    mutating func remove<S: Sequence>(contentsOf oldElements: S) where S.Element == Element {
        removeAll(where: oldElements.contains)
    }
    
}

