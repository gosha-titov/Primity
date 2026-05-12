/// A convenience protocol for wrappers that expose their underlying value as common primitive types.
///
/// Conforming types combine `AnyWrapping` and `AnyExpressible`,
/// providing ergonomic accessors that avoid manually chaining `.value` through nested wrappers or calling `expressed()` repeatedly.
///
/// ## Example
/// ```
/// typealias Name = Capitalized<Trimmed<Stripped<String>>>
/// let name: Name = "Mia"
///
/// let string = name.asString()
/// //           name.expressed() // same but less clear
/// //           name.value.value.value
/// ```
///
/// You can extend this protocol with your own types to add domain-specific accessors:
/// ```
/// extension WrappingWithRepresentable where Expressed == RichText {
///     public func asRichText() -> RichText {
///         return expressed()
///     }
/// }
/// ```
public protocol WrappingWithRepresentable: AnyWrapping, AnyExpressible {
    // No additional requirements
}



// MARK: - Behavior Extensions

extension WrappingWithRepresentable where Expressed: _PrimityArray {
    public func asArray() -> Array<Expressed.Element> {
        return expressed() as! Array<Expressed.Element>
    }
}

extension WrappingWithRepresentable where Expressed: _PrimityDictionary {
    public func asDictionary() -> Dictionary<Expressed.Key, Expressed.Value> {
        return expressed() as! Dictionary<Expressed.Key, Expressed.Value>
    }
}

extension WrappingWithRepresentable where Expressed: _PrimitySet {
    public func asSet() -> Set<Expressed.Element> {
        return expressed() as! Set<Expressed.Element>
    }
}

extension WrappingWithRepresentable where Expressed == String {
    public func asString() -> String {
        return expressed()
    }
}

extension WrappingWithRepresentable where Expressed == Character {
    public func asCharacter() -> Character {
        return expressed()
    }
}

extension WrappingWithRepresentable where Expressed == Double {
    public func asDouble() -> Double {
        return expressed()
    }
}

extension WrappingWithRepresentable where Expressed == Float {
    public func asFloat() -> Float {
        return expressed()
    }
}

extension WrappingWithRepresentable where Expressed == Int {
    public func asInt() -> Int {
        return expressed()
    }
}



// MARK: - Compatibility Extensions

extension NonEmpty: WrappingWithRepresentable where Value: Expressible {}
extension InRange: WrappingWithRepresentable where Value: Expressible {}
extension Sorted: WrappingWithRepresentable where Value: Expressible {}

extension NonNegative: WrappingWithRepresentable where Value: Expressible {}
extension Positive: WrappingWithRepresentable where Value: Expressible {}
extension UnitInterval: WrappingWithRepresentable where Value: Expressible {}

extension Capitalized: WrappingWithRepresentable where Value: Expressible {}
extension Lowercased: WrappingWithRepresentable where Value: Expressible {}
extension Uppercased: WrappingWithRepresentable where Value: Expressible {}
extension Stripped: WrappingWithRepresentable where Value: Expressible {}
extension Truncated: WrappingWithRepresentable where Value: Expressible {}
extension Collapsed: WrappingWithRepresentable where Value: Expressible {}
extension Ragged: WrappingWithRepresentable where Value: Expressible {}
extension Trimmed: WrappingWithRepresentable where Value: Expressible {}



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
