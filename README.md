
<img width="1344" height="768" alt="primity_logo" src="https://github.com/user-attachments/assets/8b5c3147-ac38-43cb-9852-178c47507c26" />

# Primity

Type primitives for Swift that move validation from runtime to compile time.

No `guard`. No manual `Codable`. No tests for "not empty". Stack types and get guarantees for free.


## The Problem

You write a model. 
You add an initializer. 
You add `guard`. 
You add `Codable` manually. 
**You add tests for every branch.**

```swift
struct User: Sendable {
    let name: String      // Should be non-empty and trimmed at sides
    let awards: [Award]   // Should be sorted in descending order
    let progress: Double  // Should be not negative

    init?(name: String, awards: [Award], progress: Double) {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty, progress >= 0 else { return nil }
        self.name = name
        self.awards = awards.sorted(by: >)
        self.progress = progress
    }
}
```

Three fields but a wall of logic. 
And the `Codable` part is still ahead — auto-synthesis bypasses your `init`, so you write `init(from:)` by hand:

```swift
extension User: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let user = User(
            name: try container.decode(String.self, forKey: .name),
            awards: try container.decode([Award].self, forKey: .awards),
            progress: try container.decode(Double.self, forKey: .progress)
        ) else {
            throw DecodingError.dataCorrupted(.init(
                codingPath: decoder.codingPath,
                debugDescription: "Invalid Data"
            ))
        }
        self = user
    }
}
```
 
For every model. In a large project that is thousands of lines of boilerplate.


## The Solution

The same model with `Primity`:

```swift
struct User: Codable, Sendable {
    let name: Name
    let awards: Awards
    let progress: Progress
}

extension User {
    typealias Name = NonEmpty<Trimmed<String>>
    typealias Awards = Descended<Array<Award>>
    typealias Progress = NonNegative<Double>
}
```

No `guard`. No manual `Codable`. 
The type `Name` says: non-empty, trimmed. 
`Awards` says: descending-sorted. 
`Progress` says: non-negative.

`Codable` works automatically. 
Wrappers serialize their contents directly, without metadata.


### Why nested typealiases?

Client code should not know what is inside `User.Name`. 
If you change `NonEmpty<Trimmed<String>>` to `NonEmpty<Collapsed<Trimmed<String>>>`, call sites stay the same.

```swift
// Good: hidden implementation
let name = User.Name(expressing: input)

// Bad: breaks on every change
let name = NonEmpty(Trimmed(input))
```


## How It Works

Wrappers come in two flavors.

**Validators** reject bad input (`init?`):
- `NonEmpty` — not empty
- `NonNegative` / `Positive` — numeric bounds
- `Bounded` — value within bounds

**Adjusters** always accept and transform:
- `Trimmed`, `Stripped`, `Collapsed` — whitespace
- `Capitalized`, `Lowercased`, `Uppercased` — casing
- `Sorted` — via `Ascended` / `Descended`
- `Truncated` — length limit
- `UnitInterval` — clamps to `0…1`


## Composition

Stack them. Each layer does one thing.

```swift
typealias Tag = NonEmpty<Lowercased<Truncated<Collapsed<Trimmed<Stripped<String>>>>>>

let tag: Tag? = "  Swift   💙 DEVelopment   💻  "
print(tag) // "swift development"
```

```swift
typealias TwoThroughNine<Value: Boundable> = Bounded<Bounds.`2`, Bounds.`9`, Value> where Value.Bound == Int
typealias AnswerOption = NonEmpty<Truncated<Collapsed<Trimmed<String>>>>
typealias AnswerOptions = TwoThroughNine<OrderedSet<AnswerOption>>
```


### Favorite Textual Compositions

Combinations I use every day:

```swift
typealias Title = NonEmpty<Truncated<Collapsed<Trimmed<String>>>>

typealias Paragraph = NonEmpty<Collapsed<Trimmed<String>>>

typealias Name = NonEmpty<Truncated<Collapsed<Trimmed<Stripped<String>>>>>

typealias Tag = NonEmpty<Lowercased<Truncated<Collapsed<Trimmed<Stripped<String>>>>>>
```

```swift
let title: Title? = "   Swift   Development   "
// "Swift Development"

let name: Name? = "👋 Mia 🌍"
// "Mia"

let tag: Tag? = "  SWIFT  DeV  "
// "swift dev"
```


## Usage

Wrappers understand literals:

```swift
let string: Trimmed<Stripped<String>> = "hello world"
let array: NonEmpty<Ascended<Array<Int>>>? = [5, 1, 3, 2, 4]
let double: NonNegative<Double>? = 95.97
```

Custom types use `init(expressing:)`:

```swift
typealias Paragraph = NonEmpty<Collapsed<Trimmed<RichText>>>
let paragraph = Paragraph(expressing: text)
```

Without this you write:

```swift
let paragraph = Paragraph(Collapsed(Trimmed(text)))
```

Extracting values:

```swift
let string = Trimmed(Stripped("swift")).asString()
let array = NonEmpty(Ascended([5, 1, 3, 2, 4]))!.asArray()
let double = NonNegative(95.97)!.asDouble()

let text = Truncated(Collapsed(richText)).expressed()
```


## Immutable Mutations

Every operation returns a new instance.

```swift
Ascended([5, 2, 1, 4, 3])
    .appending(6)

NonEmpty(["en": "Hello", "fr": "Bonjour"])?
    .setting("Привет", for: "ru")

Trimmed("Jobs")
    .prepending("Steve ")
```

Methods are available for arrays, strings, dictionaries, sets and numbers.


## Tests Are No Longer Needed

Every initializer used to need tests: empty string, negative number, unsorted array. We tested `guard`, not business logic.

With wrappers, checks are built into the type. 
`NonEmpty` cannot be empty because the compiler forbids it. 
`NonNegative` cannot be negative by definition.

Like `Equatable` or `Hashable` — you do not test that a dictionary hashes keys correctly. 
Validation moved from runtime into the type system. 
Testing it in your models is pointless.

Tests stay for business logic. "Not empty", "not negative", "sorted" — **is no longer your concern**.


## Little Note

A wrapper never changes the type of the wrapped value. 
It only validates or adjusts.

That is why `Mapped` — replacing the element type — is against the philosophy and not implemented.


## Custom Types

Conform your type to the required protocol. That is all.

- `Capitalizable` — for `Capitalized`
- `Sortable` — for `Sorted`
- `Trimmable` — for `Trimmed`

```swift
extension RichText: Expressible {}

extension RichText: Trimmable {
    func trimmed() -> RichText { /* ... */ }
}

extension RichText: Collapsible {
    func collapsed() -> RichText { /* ... */ }
}

extension AnyWrapping where Self: AnyExpressible, Expressed == RichText {
    func asRichText() -> RichText {
        return expressed()
    }
}

typealias Bio = Collapsed<Trimmed<RichText>>
```


## Custom Wrappers

Three steps. No implementation code needed.

### 1. Define the protocol

```swift
protocol Normalizable {
    func normalized() -> Self
}
```

Add a default implementation for all wrappers:

```swift
extension Wrapping where Value: Normalizable {
    func normalized() -> Self {
        Self(value.normalized())
    }
}

// Forward through existing wrappers
extension Capitalized: Normalizable where Value: Normalizable {}
extension Lowercased: Normalizable where Value: Normalizable {}
```

### 2. Create the wrapper

```swift
struct Normalized<Value: Normalizable>: Wrapping {
    let value: Value
    init(_ value: Value) {
        self.value = value.normalized()
    }
}
```

### 3. Declare conformances — empty extensions

That is the trick. 
`Primity` provides default implementations for everything. 
You just declare that your wrapper conforms, and the compiler fills in the rest.

```swift
// Standard protocols — no body needed
extension Normalized: Equatable where Value: Equatable {}
extension Normalized: Hashable where Value: Hashable {}
extension Normalized: Sendable where Value: Sendable {}
extension Normalized: Codable where Value: Codable {}

// Collection — no body needed
extension Normalized: Sequence where Value: Sequence {}
extension Normalized: Collection where Value: Collection {}
extension Normalized: BidirectionalCollection where Value: BidirectionalCollection {}

// Literals — no body needed
extension Normalized: ArrayExpressible, ExpressibleByArrayLiteral where Value: ArrayExpressible {}
extension Normalized: DictionaryExpressible, ExpressibleByDictionaryLiteral where Value: DictionaryExpressible {}
extension Normalized: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Value: ExpressibleByStringLiteral {}
extension Normalized: ExpressibleByIntegerLiteral where Value: ExpressibleByIntegerLiteral {}
extension Normalized: ExpressibleByFloatLiteral where Value: ExpressibleByFloatLiteral {}

// Compatibility with other wrappers — no body needed
extension Normalized: Emptyable where Value: Emptyable {}
extension Normalized: Trimmable where Value: Trimmable {}
extension Normalized: Collapsible where Value: Collapsible {}
```

Pick what you need. The rest is automatic.


## Architecture

Protocol-oriented programming, no magic.

- `Wrapping` — adjusters, init always succeeds
- `MaybeWrapping` — validators, init fails on bad data
- `Expressible` — creation from raw values

Every standard protocol has a default implementation that forwards to `value`. 
You write `extension Capitalized: Codable where Value: Codable {}` — empty, no body — and `Capitalized<String>` becomes `Codable` instantly. 
The wrapper serializes the inner value directly, without metadata.

`NonEmpty<String>` behaves like `String`. 
`Sorted<Array<Int>>` behaves like `Array`. 
`Codable`, `Collection`, `Equatable`, `Hashable` — all work out of the box with empty-body extensions.

A wrapper is just a container.

No bridging protocols. No generated code. Just conditional conformance and default implementations.


## Installation

Add `Primity` via Swift Package Manager:

```
https://github.com/gosha-titov/Primity.git
```

Or in `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/gosha-titov/Primity.git",
        .upToNextMinor(from: "2.0.2")
    )
]
```


## Design Philosophy

1. **One invariant per type** — Each primitive does exactly one thing
2. **Zero domain knowledge** — No business logic, no external dependencies
3. **Compose, don't configure** — Stack types instead of passing validation rules
4. **Fail fast at the boundary** — Invalid values are rejected at creation time


---

**PS.** I have gutted thousands of lines of validation and adjustment code across the whole project. 
Models now stack from blocks in seconds. 
Need something specific — write a wrapper in five lines, it works with everything else. 
Reads like English. Supports itself. The code describes itself.
