//
// Implementation Notes
// ––––––––––––––––––––
//
// Methods are automaticaly available for any wrapper whose underlying value supports them.
// No manual implementation needed.
// They work out of the box.
//

extension AnyWrapping where Wrapped: Expressible {
    
    /// Returns the result of transforming the underlying raw value.
    ///
    /// ## Example
    /// ```
    /// let progress = UnitInterval(0.674)
    ///
    /// let string = progress.mapped { "Loading... \($0 * 100)%" }
    /// // "Loading... 67.4%"
    /// ```
    public func mapped<T>(_ transform: (Wrapped.Expressed) throws -> T ) rethrows -> T {
        return try transform(value.expressed())
    }
    
}



// MARK: - Default Representations

extension AnyWrapping where Self: AnyExpressible, Wrapped: AnyExpressible, Wrapped.Expressed: _PrimityArray {
 
    /// Unwraps the underlying array value.
    public func asArray() -> Array<Wrapped.Expressed.Element> {
        return expressed() as! Array<Wrapped.Expressed.Element>
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Wrapped: AnyExpressible, Wrapped.Expressed: _PrimityDictionary {
    
    /// Unwraps the underlying dictionary value.
    public func asDictionary() -> Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value> {
        return expressed() as! Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Wrapped: AnyExpressible, Wrapped.Expressed: _PrimitySet {
    
    /// Unwraps the underlying set value.
    public func asSet() -> Set<Wrapped.Expressed.Element> {
        return expressed() as! Set<Wrapped.Expressed.Element>
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Expressed == String {
    
    /// Unwraps the underlying string value.
    public func asString() -> String {
        return expressed()
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Expressed == Character {
    
    /// Unwraps the underlying character value.
    public func asCharacter() -> Character {
        return expressed()
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Expressed == Double {
    
    /// Unwraps the underlying double value.
    public func asDouble() -> Double {
        return expressed()
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Expressed == Float {
    
    /// Unwraps the underlying float value.
    public func asFloat() -> Float {
        return expressed()
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Expressed == Int {
    
    /// Unwraps the underlying integer value.
    public func asInt() -> Int {
        return expressed()
    }

}



// MARK: - Array Extensions

extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityArray {
    
    /// Returns a copy with the element added to the end of the array.
    public func appending(_ newElement: Wrapped.Expressed.Element) -> Self {
        return mutated { $0.append(newElement) }
    }
    
    /// Returns a copy with the elements added to the end of the array.
    public func appending<S: Sequence>(contentsOf newElements: S) -> Self where S.Element == Wrapped.Expressed.Element {
        return mutated { $0.append(contentsOf: newElements) }
    }
    
    /// Returns a copy with the element added at the beginning of the array.
    public func prepending(_ newElement: Wrapped.Expressed.Element) -> Self {
        return mutated { $0.insert(newElement, at: .zero) }
    }
    
    /// Returns a copy with the elements added at the beginning of the array.
    public func prepending<C: Collection>(contentsOf newElements: C) -> Self where C.Element == Wrapped.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: .zero) }
    }
    
    /// Returns a copy with the element inserted at the specified position.
    public func inserting(_ newElement: Wrapped.Expressed.Element, at index: Int) -> Self {
        return mutated { $0.insert(newElement, at: index) }
    }
    
    /// Returns a copy with elements inserted at the specified position.
    public func inserting<C: Collection>(contentsOf newElements: C, at index: Int) -> Self where C.Element == Wrapped.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: index) }
    }
    
    /// Returns a copy with the element set at the specified position.
    public func setting(_ newElement: Wrapped.Expressed.Element, at index: Int) -> Self {
        return mutated { $0[index] = newElement }
    }
    
    /// Returns a copy with the element removed at the specified position.
    public func removing(at index: Int) -> Self {
        return mutated { $0.remove(at: index) }
    }
    
    /// Returns a copy containing all elements but the specified one.
    public func removing(_ oldElement: Wrapped.Expressed.Element) -> Self where Wrapped.Expressed.Element: Equatable {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy containing all elements but the specified ones.
    public func removing<S: Sequence>(contentsOf oldElements: S) -> Self where S.Element == Wrapped.Expressed.Element, S.Element: Equatable {
        return mutated { $0.remove(contentsOf: oldElements) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Wrapped.Expressed.Element]) throws -> Void) rethrows -> Self {
        var array = asArray()
        try mutate(&array)
        return Self(expressing: array as! Wrapped.Expressed)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityArray {
    
    /// Returns a copy with the element added to the end of the array.
    public func appending(_ newElement: Wrapped.Expressed.Element) -> Self? {
        return mutated { $0.append(newElement) }
    }
    
    /// Returns a copy with the elements added to the end of the array.
    public func appending<S: Sequence>(contentsOf newElements: S) -> Self? where S.Element == Wrapped.Expressed.Element {
        return mutated { $0.append(contentsOf: newElements) }
    }
    
    /// Returns a copy with the element added at the beginning of the array.
    public func prepending(_ newElement: Wrapped.Expressed.Element) -> Self? {
        return mutated { $0.insert(newElement, at: .zero) }
    }
    
    /// Returns a copy with the elements added at the beginning of the array.
    public func prepending<C: Collection>(contentsOf newElements: C) -> Self? where C.Element == Wrapped.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: .zero) }
    }
    
    /// Returns a copy with the element inserted at the specified position.
    public func inserting(_ newElement: Wrapped.Expressed.Element, at index: Int) -> Self? {
        return mutated { $0.insert(newElement, at: index) }
    }
    
    /// Returns a copy with elements inserted at the specified position.
    public func inserting<C: Collection>(contentsOf newElements: C, at index: Int) -> Self? where C.Element == Wrapped.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: index) }
    }
    
    /// Returns a copy with the element set at the specified position.
    public func setting(_ newElement: Wrapped.Expressed.Element, at index: Int) -> Self? {
        return mutated { $0[index] = newElement }
    }
    
    /// Returns a copy with the element removed at the specified position.
    public func removing(at index: Int) -> Self? {
        return mutated { $0.remove(at: index) }
    }
    
    /// Returns a copy containing all elements but the specified one.
    public func removing(_ oldElement: Wrapped.Expressed.Element) -> Self? where Wrapped.Expressed.Element: Equatable {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy containing all elements but the specified ones.
    public func removing<S: Sequence>(contentsOf oldElements: S) -> Self? where S.Element == Wrapped.Expressed.Element, S.Element: Equatable {
        return mutated { $0.remove(contentsOf: oldElements) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Wrapped.Expressed.Element]) throws -> Void) rethrows -> Self? {
        var array = asArray()
        try mutate(&array)
        return Self(expressing: array as! Wrapped.Expressed)
    }
    
}



// MARK: - Set Extensions

extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: _PrimitySet {
    
    /// Returns a copy with the element inserted.
    public func inserting(_ newElement: Wrapped.Expressed.Element) -> Self {
        return mutated { $0.insert(newElement) }
    }
    
    /// Returns a copy with the element inserted.
    public func inserting<S: Sequence>(contentsOf newElements: S) -> Self where S.Element == Wrapped.Expressed.Element {
        return mutated { $0 = $0.union(newElements) }
    }
    
    /// Returns a copy with the element removed.
    public func removing(_ oldElement: Wrapped.Expressed.Element) -> Self {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy with the elements removed.
    public func removing<S: Sequence>(contentsOf oldElement: S) -> Self where S.Element == Wrapped.Expressed.Element {
        return mutated { $0.subtract(oldElement) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Set<Wrapped.Expressed.Element>) throws -> Void) rethrows -> Self {
        var set = asSet()
        try mutate(&set)
        return Self(expressing: set as! Wrapped.Expressed)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimitySet {
    
    /// Returns a copy with the element inserted.
    public func inserting(_ newElement: Wrapped.Expressed.Element) -> Self? {
        return mutated { $0.insert(newElement) }
    }
    
    /// Returns a copy with the element inserted.
    public func inserting<S: Sequence>(contentsOf newElements: S) -> Self? where S.Element == Wrapped.Expressed.Element {
        return mutated { $0 = $0.union(newElements) }
    }
    
    /// Returns a copy with the element removed.
    public func removing(_ oldElement: Wrapped.Expressed.Element) -> Self? {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy with the elements removed.
    public func removing<S: Sequence>(contentsOf oldElement: S) -> Self? where S.Element == Wrapped.Expressed.Element {
        return mutated { $0.subtract(oldElement) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Wrapped.Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Set<Wrapped.Expressed.Element>) throws -> Void) rethrows -> Self? {
        var set = asSet()
        try mutate(&set)
        return Self(expressing: set as! Wrapped.Expressed)
    }
    
}



// MARK: - Dictionary Extensions

extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityDictionary {
    
    /// Returns a copy with the value updated or added for the specified key.
    public func setting(_ newValue: Wrapped.Expressed.Value, for key: Wrapped.Expressed.Key) -> Self {
        return mutated { $0[key] = newValue }
    }
    
    /// Returns a copy with a value removed for the specified key.
    public func removing(for key: Wrapped.Expressed.Key) -> Self {
        return mutated { $0[key] = nil }
    }
    
    /// Returns a copy containing the key-value pairs except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>) throws -> Void) rethrows -> Self {
        var dictionary = asDictionary()
        try mutate(&dictionary)
        return Self(expressing: dictionary as! Wrapped.Expressed)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityDictionary {
    
    /// Returns a copy with the value updated or added for the specified key.
    public func setting(_ newValue: Wrapped.Expressed.Value, for key: Wrapped.Expressed.Key) -> Self? {
        return mutated { $0[key] = newValue }
    }
    
    /// Returns a copy with a value removed for the specified key.
    public func removing(for key: Wrapped.Expressed.Key) -> Self? {
        return mutated { $0[key] = nil }
    }
    
    /// Returns a copy containing the key-value pairs except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) rethrows -> Self? {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>.Element) throws -> Bool) rethrows -> Self? {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Dictionary<Wrapped.Expressed.Key, Wrapped.Expressed.Value>) throws -> Void) rethrows -> Self? {
        var dictionary = asDictionary()
        try mutate(&dictionary)
        return Self(expressing: dictionary as! Wrapped.Expressed)
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Wrapped: Expressible, Wrapped.Expressed: _PrimityDictionary {
    
    /// Returns a value for the specified key.
    public subscript(key: Wrapped.Expressed.Key) -> Wrapped.Expressed.Value? {
        get { return asDictionary()[key] }
    }
    
}



// MARK: - String Extensions

extension Wrapping where Self: Expressible, Expressed == String {
    
    /// Returns a copy with the character added to the end of the string.
    public func appending(_ newCharacter: Character) -> Self {
        return mutated { $0.append(newCharacter) }
    }
    
    /// Returns a copy with the characters added to the end of the string.
    public func appending<S: Sequence>(contentsOf newCharacters: S) -> Self where S.Element == Character {
        return mutated { $0.append(contentsOf: newCharacters) }
    }
    
    /// Returns a copy with the character added at the beginning of the array.
    public func prepending(_ newCharacter: Character) -> Self {
        return mutated { $0.insert(newCharacter, at: $0.startIndex) }
    }
    
    /// Returns a copy with the characters added at the beginning of the array.
    public func prepending<C: Collection>(contentsOf newCharacters: C) -> Self where C.Element == Character {
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


extension MaybeWrapping where Self: MaybeExpressible, Expressed == String {
    
    /// Returns a copy with the character added to the end of the string.
    public func appending(_ newCharacter: Character) -> Self? {
        return mutated { $0.append(newCharacter) }
    }
    
    /// Returns a copy with the characters added to the end of the string.
    public func appending<S: Sequence>(contentsOf newCharacters: S) -> Self? where S.Element == Character {
        return mutated { $0.append(contentsOf: newCharacters) }
    }
    
    /// Returns a copy with the character added at the beginning of the array.
    public func prepending(_ newCharacter: Character) -> Self? {
        return mutated { $0.insert(newCharacter, at: $0.startIndex) }
    }
    
    /// Returns a copy with the characters added at the beginning of the array.
    public func prepending<C: Collection>(contentsOf newCharacters: C) -> Self? where C.Element == Character {
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



// MARK: - Number Extensions

extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: Numeric {
    
    /// Returns a copy with the given number added to the underlying value.
    public func adding(_ number: Wrapped.Expressed) -> Self {
        return Self(expressing: expressed() + number)
    }
    
    /// Returns a copy with the given number subtracted from the underlying value.
    public func subtracting(_ number: Wrapped.Expressed) -> Self {
        return Self(expressing: expressed() - number)
    }
    
    /// Returns a copy with the underlying value multiplied by the given number.
    public func multiplying(by number: Wrapped.Expressed) -> Self {
        return Self(expressing: expressed() * number)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: Numeric {
    
    /// Returns a copy with the given number added to the underlying value.
    public func adding(_ number: Wrapped.Expressed) -> Self? {
        return Self(expressing: expressed() + number)
    }
    
    /// Returns a copy with the given number subtracted from the underlying value.
    public func subtracting(_ number: Wrapped.Expressed) -> Self? {
        return Self(expressing: expressed() - number)
    }
    
    /// Returns a copy with the underlying value multiplied by the given number.
    public func multiplying(by number: Wrapped.Expressed) -> Self? {
        return Self(expressing: expressed() * number)
    }
    
}



extension Wrapping where Self: Expressible, Wrapped: Expressible, Wrapped.Expressed: FloatingPoint {
    
    /// Returns a copy with the underlying value divided by the given number.
    public func dividing(by number: Wrapped.Expressed) -> Self {
        return Self(expressing: expressed() / number)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Wrapped: Expressible, Wrapped.Expressed: FloatingPoint {
    
    /// Returns a copy with the underlying value divided by the given number.
    public func dividing(by number: Wrapped.Expressed) -> Self? {
        return Self(expressing: expressed() / number)
    }
    
}



// MARK: - Markers

/// A marker protocol identifying `Array` types.
///
/// Used to enable conditional behavior when an expressed value is known to be an array.
public protocol _PrimityArray {
    associatedtype Element
}

extension Array: _PrimityArray {}


/// A marker protocol identifying `Dictionary` types.
///
/// Used to enable conditional behavior when an expressed value is known to be a dictionary.
public protocol _PrimityDictionary {
    associatedtype Key: Hashable
    associatedtype Value
}

extension Dictionary: _PrimityDictionary {}


/// A marker protocol identifying `Set` types.
///
/// Used to enable conditional behavior when an expressed value is known to be a set.
public protocol _PrimitySet {
    associatedtype Element: Hashable
}

extension Set: _PrimitySet {}



// MARK: - Helpers

extension Array where Element: Equatable {

    mutating func remove(_ oldElement: Element) {
        removeAll(where: { $0 == oldElement })
    }
    
    mutating func remove<S: Sequence>(contentsOf oldElements: S) where S.Element == Element {
        removeAll(where: oldElements.contains)
    }
    
}

