import Foundation

/// A type that can produce a stripped copy of itself, where decorative elements (like emojis) are removed.
public protocol Strippable {
    
    /// Returns a copy with decorative elements removed.
    /// 
    /// ## Example
    /// ```
    /// let string = "Hello, 👋 World! 🌍 Let's meet at 3️⃣ PM."
    /// string.stripped() // "Hello,  World!  Let's meet at  PM."
    /// ```
    func stripped() -> Self
    
}



// MARK: - Behavior

/// A behavior that forwards `stripped()` through the wrapped value.
public protocol WrappingWithStrippable: Wrapping, Strippable where Value: Strippable {
    // No additional requirements
}

extension WrappingWithStrippable {
    public func stripped() -> Self {
        return Self(value.stripped())
    }
}



// MARK: - Compatibility Extensions

extension String: Strippable {

    public func stripped() -> String {
        var string = String()
        enumerateSubstrings(in: startIndex..<endIndex, options: .byComposedCharacterSequences) { substring, _, _, _ in
            if let substring, !substring.contains(where: \.isEmoji) {
                string.append(substring)
            }
        }
        return string
    }
    
}


extension Capitalized: WrappingWithStrippable, Strippable where Value: Strippable {}
extension Lowercased: WrappingWithStrippable, Strippable where Value: Strippable {}
extension Uppercased: WrappingWithStrippable, Strippable where Value: Strippable {}
extension Truncated: WrappingWithStrippable, Strippable where Value: Strippable {}
extension Collapsed: WrappingWithStrippable, Strippable where Value: Strippable {}
extension Ragged: WrappingWithStrippable, Strippable where Value: Strippable {}
extension Trimmed: WrappingWithStrippable, Strippable where Value: Strippable {}



// MARK: - Helpers

private extension Character {
    
    /// A boolean value indicating whether the character is an emoji.
    var isEmoji: Bool {
        return isSimpleEmoji || isCombinedIntoEmoji
    }
    
    /// A boolean value indicating whether the character is a simple, single-scalar emoji.
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return (firstScalar.properties.isEmoji && firstScalar.value > 0x238C) || firstScalar.isEmoji
    }

    /// A boolean value indicating whether the character is a combined emoji sequence.
    var isCombinedIntoEmoji: Bool {
        return unicodeScalars.count > 1 && (unicodeScalars.first?.properties.isEmoji ?? false)
    }
    
}


private extension UnicodeScalar {
    
    /// A boolean value indicating whether the scalar is a recognized emoji character.
    var isEmoji: Bool {
        switch self.value {
            case 0x1F600...0x1F64F,
                 0x1F300...0x1F5FF,
                 0x1F680...0x1F6FF,
                 0x1F1E6...0x1F1FF,
                 0xE0020...0xE007F,
                 0xFE00...0xFE0F,
                 0x1F900...0x1F9FF,
                 0x1F018...0x1F0F5,
                 0x1F200...0x1F270,
                 65024...65039,
                 9100...9300,
                 8400...8447,
                 0x1F004,
                 0x1F18E,
                 0x1F191...0x1F19A,
                 0x1F5E8,
                 0x1FA70...0x1FA73,
                 0x1FA78...0x1FA7A,
                 0x1FA80...0x1FA82,
                 0x1FA90...0x1FA95,
                 0x1FAE0,
                 0x1FAF0...0x1FAF6,
                 0x1F382:
                return true
            case 0x2603,
                 0x265F,
                 0x267E,
                 0x2692,
                 0x26C4,
                 0x26C8,
                 0x26CE,
                 0x26CF,
                 0x26D1...0x26D3,
                 0x26E9,
                 0x26F0...0x26F9,
                 0x2705,
                 0x270A,
                 0x270B,
                 0x2728,
                 0x274E,
                 0x2753...0x2755,
                 0x274C,
                 0x2795...0x2797,
                 0x27B0,
                 0x27BF:
                return true
            default:
                return false
        }
    }
    
}

