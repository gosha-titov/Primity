//
// Implementation Notes
// ––––––––––––––––––––
//
// In order to make a wrapper serializable, simply add this line:
//
//      extension YourWrapper: Codable where Value: Codable {}
//
// No manual implementation is needed because the default one is automatically provided.
//
// Wrappers encode their underlying value directly using a single-value container,
// so the serialized format contains no wrapper metadata — just the raw value.
//
// For adjusters (Wrapping), decoding always succeeds.
// For validators (MaybeWrapping), decoding throws if the raw value fails validation.
//

extension Wrapping where Value: Codable {
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(try container.decode(Value.self))
    }
    
}


extension MaybeWrapping where Value: Codable {
    
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
