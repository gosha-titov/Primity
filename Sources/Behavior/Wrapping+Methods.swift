//
// Implementation Notes
// ––––––––––––––––––––
//
// Methods are automaticaly available for any wrapper whose underlying value supports them.
// No manual implementation needed.
// They work out of the box.
//

extension AnyWrapping where Value: Expressible {
    
    /// Returns the result of transforming the underlying raw value.
    ///
    /// ## Example
    /// ```
    /// let progress = UnitInterval(0.67)
    ///
    /// let string = progress.mapped { "Loading... \($0 * 100)%" }
    /// ```
    public func mapped<T>(_ transform: (Value.Expressed) throws -> T ) rethrows -> T {
        return try transform(value.expressed())
    }
    
}



// MARK: - Default Representations

extension AnyWrapping where Self: AnyExpressible, Value: AnyExpressible, Value.Expressed: _PrimityArray {
 
    /// Unwraps the underlying array value.
    public func asArray() -> Array<Value.Expressed.Element> {
        return expressed() as! Array<Value.Expressed.Element>
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Value: AnyExpressible, Value.Expressed: _PrimityDictionary {
    
    /// Unwraps the underlying dictionary value.
    public func asDictionary() -> Dictionary<Value.Expressed.Key, Value.Expressed.Value> {
        return expressed() as! Dictionary<Value.Expressed.Key, Value.Expressed.Value>
    }
    
}


extension AnyWrapping where Self: AnyExpressible, Value: AnyExpressible, Value.Expressed: _PrimitySet {
    
    /// Unwraps the underlying set value.
    public func asSet() -> Set<Value.Expressed.Element> {
        return expressed() as! Set<Value.Expressed.Element>
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

extension Wrapping where Self: Expressible, Value: Expressible, Value.Expressed: _PrimityArray {
    
    /// Returns a copy with the element added to the end of the array.
    public func appending(_ newElement: Value.Expressed.Element) -> Self {
        return mutated { $0.append(newElement) }
    }
    
    /// Returns a copy with the elements added to the end of the array.
    public func appending<S: Sequence>(contentsOf newElements: S) -> Self where S.Element == Value.Expressed.Element {
        return mutated { $0.append(contentsOf: newElements) }
    }
    
    /// Returns a copy with the element added at the beginning of the array.
    public func preprending(_ newElement: Value.Expressed.Element) -> Self {
        return mutated { $0.insert(newElement, at: .zero) }
    }
    
    /// Returns a copy with the elements added at the beginning of the array.
    public func preprending<C: Collection>(contentsOf newElements: C) -> Self where C.Element == Value.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: .zero) }
    }
    
    /// Returns a copy with the element inserted at the specified position.
    public func inserting(_ newElement: Value.Expressed.Element, at index: Int) -> Self {
        return mutated { $0.insert(newElement, at: index) }
    }
    
    /// Returns a copy with elements inserted at the specified position.
    public func inserting<C: Collection>(contentsOf newElements: C, at index: Int) -> Self where C.Element == Value.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: index) }
    }
    
    /// Returns a copy with the element set at the specified position.
    public func setting(_ newElement: Value.Expressed.Element, at index: Int) -> Self {
        return mutated { $0[index] = newElement }
    }
    
    /// Returns a copy with the element removed at the specified position.
    public func removing(at index: Int) -> Self {
        return mutated { $0.remove(at: index) }
    }
    
    /// Returns a copy containing all elements but the specified one.
    public func removing(_ oldElement: Value.Expressed.Element) -> Self where Value.Expressed.Element: Equatable {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy containing all elements but the specified ones.
    public func removing<S: Sequence>(contentsOf oldElements: S) -> Self where S.Element == Value.Expressed.Element, S.Element: Equatable {
        return mutated { $0.remove(contentsOf: oldElements) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Value.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Value.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Value.Expressed.Element]) throws -> Void) rethrows -> Self {
        var array = asArray()
        try mutate(&array)
        return Self(expressing: array as! Value.Expressed)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Value: Expressible, Value.Expressed: _PrimityArray {
    
    /// Returns a copy with the element added to the end of the array.
    public func appending(_ newElement: Value.Expressed.Element) -> Self? {
        return mutated { $0.append(newElement) }
    }
    
    /// Returns a copy with the elements added to the end of the array.
    public func appending<S: Sequence>(contentsOf newElements: S) -> Self? where S.Element == Value.Expressed.Element {
        return mutated { $0.append(contentsOf: newElements) }
    }
    
    /// Returns a copy with the element added at the beginning of the array.
    public func preprending(_ newElement: Value.Expressed.Element) -> Self? {
        return mutated { $0.insert(newElement, at: .zero) }
    }
    
    /// Returns a copy with the elements added at the beginning of the array.
    public func preprending<C: Collection>(contentsOf newElements: C) -> Self? where C.Element == Value.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: .zero) }
    }
    
    /// Returns a copy with the element inserted at the specified position.
    public func inserting(_ newElement: Value.Expressed.Element, at index: Int) -> Self? {
        return mutated { $0.insert(newElement, at: index) }
    }
    
    /// Returns a copy with elements inserted at the specified position.
    public func inserting<C: Collection>(contentsOf newElements: C, at index: Int) -> Self? where C.Element == Value.Expressed.Element {
        return mutated { $0.insert(contentsOf: newElements, at: index) }
    }
    
    /// Returns a copy with the element set at the specified position.
    public func setting(_ newElement: Value.Expressed.Element, at index: Int) -> Self? {
        return mutated { $0[index] = newElement }
    }
    
    /// Returns a copy with the element removed at the specified position.
    public func removing(at index: Int) -> Self? {
        return mutated { $0.remove(at: index) }
    }
    
    /// Returns a copy containing all elements but the specified one.
    public func removing(_ oldElement: Value.Expressed.Element) -> Self? where Value.Expressed.Element: Equatable {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy containing all elements but the specified ones.
    public func removing<S: Sequence>(contentsOf oldElements: S) -> Self? where S.Element == Value.Expressed.Element, S.Element: Equatable {
        return mutated { $0.remove(contentsOf: oldElements) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Value.Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Value.Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout [Value.Expressed.Element]) throws -> Void) rethrows -> Self? {
        var array = asArray()
        try mutate(&array)
        return Self(expressing: array as! Value.Expressed)
    }
    
}



// MARK: - Set Extensions

extension Wrapping where Self: Expressible, Value: Expressible, Value.Expressed: _PrimitySet {
    
    /// Returns a copy with the element inserted.
    public func inserting(_ newElement: Value.Expressed.Element) -> Self {
        return mutated { $0.insert(newElement) }
    }
    
    /// Returns a copy with the element inserted.
    public func inserting<S: Sequence>(contentsOf newElements: S) -> Self where S.Element == Value.Expressed.Element {
        return mutated { $0 = $0.union(newElements) }
    }
    
    /// Returns a copy with the element removed.
    public func removing(_ oldElement: Value.Expressed.Element) -> Self {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy with the elements removed.
    public func removing<S: Sequence>(contentsOf oldElement: S) -> Self where S.Element == Value.Expressed.Element {
        return mutated { $0.subtract(oldElement) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Value.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Value.Expressed.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Set<Value.Expressed.Element>) throws -> Void) rethrows -> Self {
        var set = asSet()
        try mutate(&set)
        return Self(expressing: set as! Value.Expressed)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Value: Expressible, Value.Expressed: _PrimitySet {
    
    /// Returns a copy with the element inserted.
    public func inserting(_ newElement: Value.Expressed.Element) -> Self? {
        return mutated { $0.insert(newElement) }
    }
    
    /// Returns a copy with the element inserted.
    public func inserting<S: Sequence>(contentsOf newElements: S) -> Self? where S.Element == Value.Expressed.Element {
        return mutated { $0 = $0.union(newElements) }
    }
    
    /// Returns a copy with the element removed.
    public func removing(_ oldElement: Value.Expressed.Element) -> Self? {
        return mutated { $0.remove(oldElement) }
    }
    
    /// Returns a copy with the elements removed.
    public func removing<S: Sequence>(contentsOf oldElement: S) -> Self? where S.Element == Value.Expressed.Element {
        return mutated { $0.subtract(oldElement) }
    }
    
    /// Returns a copy containing the elements except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Value.Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Value.Expressed.Element) throws -> Bool) rethrows -> Self? {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Set<Value.Expressed.Element>) throws -> Void) rethrows -> Self? {
        var set = asSet()
        try mutate(&set)
        return Self(expressing: set as! Value.Expressed)
    }
    
}



// MARK: - Dictionary Extensions

extension Wrapping where Self: Expressible, Value: Expressible, Value.Expressed: _PrimityDictionary {
    
    /// Returns a copy with the value updated or added for the specified key.
    public func setting(_ newValue: Value.Expressed.Value, for key: Value.Expressed.Key) -> Self {
        return mutated { $0[key] = newValue }
    }
    
    /// Returns a copy with a value removed for the specified key.
    public func removing(for key: Value.Expressed.Key) -> Self {
        return mutated { $0[key] = nil }
    }
    
    /// Returns a copy containing the key-value pairs except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Dictionary<Value.Expressed.Key, Value.Expressed.Value>.Element) throws -> Bool) rethrows -> Self {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Dictionary<Value.Expressed.Key, Value.Expressed.Value>.Element) throws -> Bool) rethrows -> Self {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Dictionary<Value.Expressed.Key, Value.Expressed.Value>) throws -> Void) rethrows -> Self {
        var dictionary = asDictionary()
        try mutate(&dictionary)
        return Self(expressing: dictionary as! Value.Expressed)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Value: Expressible, Value.Expressed: _PrimityDictionary {
    
    /// Returns a copy with the value updated or added for the specified key.
    public func setting(_ newValue: Value.Expressed.Value, for key: Value.Expressed.Key) -> Self? {
        return mutated { $0[key] = newValue }
    }
    
    /// Returns a copy with a value removed for the specified key.
    public func removing(for key: Value.Expressed.Key) -> Self? {
        return mutated { $0[key] = nil }
    }
    
    /// Returns a copy containing the key-value pairs except for those that do not satisfy the given predicate.
    public func removing(where isRemoved: (Dictionary<Value.Expressed.Key, Value.Expressed.Value>.Element) throws -> Bool) rethrows -> Self? {
        return try filtering { try !isRemoved($0) }
    }
    
    /// Returns a copy containing the elements that satisfy the given predicate.
    public func filtering(_ isIncluded: (Dictionary<Value.Expressed.Key, Value.Expressed.Value>.Element) throws -> Bool) rethrows -> Self? {
        return try mutated { $0 = try $0.filter(isIncluded) }
    }
    
    
    /// Returns a copy making some changes.
    private func mutated(_ mutate: (inout Dictionary<Value.Expressed.Key, Value.Expressed.Value>) throws -> Void) rethrows -> Self? {
        var dictionary = asDictionary()
        try mutate(&dictionary)
        return Self(expressing: dictionary as! Value.Expressed)
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



// MARK: - Number Extensions

extension Wrapping where Self: Expressible, Value: Expressible, Value.Expressed: Numeric {
    
    /// Returns a copy with the given number added to the underlying value.
    public func adding(_ number: Value.Expressed) -> Self {
        return Self(expressing: expressed() + number)
    }
    
    /// Returns a copy with the given number subtracted from the underlying value.
    public func subtracting(_ number: Value.Expressed) -> Self {
        return Self(expressing: expressed() - number)
    }
    
    /// Returns a copy with the underlying value multiplied by the given number.
    public func multiplying(by number: Value.Expressed) -> Self {
        return Self(expressing: expressed() * number)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Value: Expressible, Value.Expressed: Numeric {
    
    /// Returns a copy with the given number added to the underlying value.
    public func adding(_ number: Value.Expressed) -> Self? {
        return Self(expressing: expressed() + number)
    }
    
    /// Returns a copy with the given number subtracted from the underlying value.
    public func subtracting(_ number: Value.Expressed) -> Self? {
        return Self(expressing: expressed() - number)
    }
    
    /// Returns a copy with the underlying value multiplied by the given number.
    public func multiplying(by number: Value.Expressed) -> Self? {
        return Self(expressing: expressed() * number)
    }
    
}



extension Wrapping where Self: Expressible, Value: Expressible, Value.Expressed: FloatingPoint {
    
    /// Returns a copy with the underlying value divided by the given number.
    public func dividing(by number: Value.Expressed) -> Self {
        return Self(expressing: expressed() / number)
    }
    
}


extension MaybeWrapping where Self: MaybeExpressible, Value: Expressible, Value.Expressed: FloatingPoint {
    
    /// Returns a copy with the underlying value divided by the given number.
    public func dividing(by number: Value.Expressed) -> Self? {
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

