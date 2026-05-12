/// A bridging protocol that forwards `Codable` conformance through the wrapped value.
///
/// Conforming types encode and decode their underlying value directly,
/// without including the wrapper itself in the serialized representation.
public protocol WrappingWithCodable: AnyWrapping, Codable where Value: Codable {
    // No additional requirements
}



// MARK: - Behavior Extensions

extension WrappingWithCodable where Self: Wrapping {
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(try container.decode(Value.self))
    }
    
}


extension WrappingWithCodable where Self: MaybeWrapping {
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Value.self)
        guard let wrapper = Self(value) else {
            throw DecodingError.dataCorrupted(.init(
                codingPath: decoder.codingPath,
                debugDescription: "Invalid value"
            ))
        }
        self = wrapper
    }
    
}



// MARK: - Compatibility Extensions

extension NonEmpty: WrappingWithCodable, Codable where Value: Codable {}
extension InRange: WrappingWithCodable, Codable where Value: Codable {}
extension Sorted: WrappingWithCodable, Codable where Value: Codable {}

extension NonNegative: WrappingWithCodable, Codable where Value: Codable {}
extension Positive: WrappingWithCodable, Codable where Value: Codable {}
extension UnitInterval: WrappingWithCodable, Codable where Value: Codable {}
 
extension Capitalized: WrappingWithCodable, Codable where Value: Codable {}
extension Lowercased: WrappingWithCodable, Codable where Value: Codable {}
extension Uppercased: WrappingWithCodable, Codable where Value: Codable {}
extension Stripped: WrappingWithCodable, Codable where Value: Codable {}
extension Truncated: WrappingWithCodable, Codable where Value: Codable {}
extension Collapsed: WrappingWithCodable, Codable where Value: Codable {}
extension Ragged: WrappingWithCodable, Codable where Value: Codable {}
extension Trimmed: WrappingWithCodable, Codable where Value: Codable {}
