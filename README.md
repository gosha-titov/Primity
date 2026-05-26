
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
 
For every model. In a large project that is thousands of lines of boilerplate — plus all the corresponding tests for empty strings, negative numbers, and unsorted arrays. 
You end up testing `guard` statements, not business logic.


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


## Order of Application

Wrappers apply right to left:

```swift
typealias Tag = Lowercased<Truncated<Collapsed<Trimmed<Stripped<String>>>>>

// Equivalent chain
let tag = string
    .stripped()    // remove decorative symbols
    .trimmed()     // trim edges
    .collapsed()   // collapse multiple spaces into one
    .truncated()   // cut to length limit
    .lowercased()  // convert to lowercase
```

Order matters. If you truncate first and then collapse spaces, the result may end up shorter than intended.


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

// Without this you write:
// let paragraph = Paragraph(Collapsed(Trimmed(text)))
```

Extracting values:

```swift
let string = Trimmed(Stripped("swift")).asString()
let array = NonEmpty(Ascended([5, 1, 3, 2, 4]))!.asArray()
let double = NonNegative(95.97)!.asDouble()

let text = Truncated(Collapsed(richText)).expressed()
```

For your own types, add a convenience method:

```swift
extension AnyWrapping where Self: AnyExpressible, Expressed == RichText {

    func asRichText() -> RichText {
        return expressed()
    }
    
}
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
    
NonNegative(16.7)?
    .multiplying(by: 9.4)
```

Methods are available for arrays, strings, dictionaries, sets and numbers.


## Validate Once

The real power is not just cleaner models. 
Once a value is created by a wrapper, you can pass it through your system freely.

Before, a method received a `String` and had to re-check: is it empty? Are there leading spaces? Is the array sorted?

Now the method accepts `User.Name` — and the type already guarantees correctness. 
No guard inside the method, no adjustments. 
Validation happened once, at creation, and never again.

These guarantees shrink your codebase significantly. 
**Validation disappears not only from models, but from methods, services, controllers, and their tests.**


## Tests Are No Longer Needed

Every initializer used to need tests: empty string, negative number, unsorted array. 
We tested `guard`, not business logic.

With wrappers, checks are built into the type. 
`NonEmpty` cannot be empty because the compiler forbids it. 
`NonNegative` cannot be negative by definition.

Like `Hashable` — you do not test that a dictionary hashes keys correctly. 
Validation moved from runtime into the type system. 
Testing it in your models is pointless.

Tests stay for business logic. 
"Not empty", "not negative", "sorted" — **is no longer your concern**.


## `Codable`

A wrapper encodes its inner value directly — no metadata, no `value` field. 
`JSON` stays flat and backward-compatible.

```json
// Encodes and decodes directly
"swift dev"

// Without this it would be
{"value":{"value":{"value":{"value":{"value":"swift dev"}}}}}
```

Wrappers work with the same serialized data you had before. 
**Nothing to change or adapt anywhere.**

During decoding, the wrapper calls its own `init(_:)` or `init?(_:)`. 
If validation fails, it throws a clear error: "Value must not be empty", "Value '19' must be within bounds 0...18", and so on.


## Performance

A wrapper is a single-field struct. 
In Swift it is a value type that lives on the stack or inline in its parent — no extra allocations. 
`NonEmpty<Trimmed<String>>` takes exactly the same memory as `String`.

Also, typealias is an alias, not a new type. 
If `User.Name` and `Player.Name` point to the same composition, the compiler treats them as one type and does not duplicate metadata.

In practice, unique combinations are few: for string fields, a project typically has only three or four patterns that all models reuse. 
The overhead is negligible.


## Downsides

Migrating an existing project takes time. 
You need to replace types in models, reconcile code across the system, remove now-redundant checks and tests. 
New features can be introduced gradually, but it is best to convert a module — or the entire project — in one go.

At boundaries with external libraries, you will need to unwrap and re-wrap: extract the value for an external API, wrap it again on the way back. 
This is occasionally inconvenient, but it is the price for guarantees inside your own code.

After the transition, the speed of adding new models and methods increases significantly. 
Less boilerplate, fewer validation tests, less mental overhead when reading code.


## Architecture

Protocol-oriented programming, no magic.

The library is built on four base protocols:

- `AnyWrapping` branches into `Wrapping` (adjusters, init always succeeds) and `MaybeWrapping` (validators, init fails on bad data)
- `AnyExpressible` branches into `Expressible` (creation from raw values always succeeds) and `MaybeExpressible` (creation may return `nil`)

Every standard protocol has a default implementation that forwards to value.
You write `extension Capitalized: Codable where Value: Codable {}` — empty, no body — and `Capitalized<String>` becomes `Codable` instantly.
The wrapper serializes the inner value directly, without metadata.

Each wrapper requires exactly one protocol from its wrapped value: `Trimmed` asks for `Trimmable`, `Capitalized` asks for `Capitalizable`, `Sorted` asks for `Sortable`. 
**The wrapper itself does nothing — it merely duplicates the behavior of the wrapped value.**

In a chain like `Capitalized<Trimmed<String>>`, the inner `String` must be both `Capitalizable` and `Trimmable`. 
Each layer adds one constraint, and the compiler assembles them together.
`NonEmpty<String>` behaves like `String`.
`Sorted<Array<Int>>` behaves like `Array`.
`Codable`, `Collection`, etc — all work out of the box with empty-body extensions.

A wrapper is just a container.
No bridging protocols. No generated code. Just conditional conformance and default implementations.


## Custom Types

Conform your type to the required protocol. That is all.

- `Capitalizable` — for `Capitalized`
- `Sortable` — for `Sorted`
- `Trimmable` — for `Trimmed`

```swift
extension RichText: Expressible {}

extension RichText: Trimmable {
    func trimmed() -> RichText {...}
}

extension RichText: Collapsible {
    func collapsed() -> RichText {...}
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
extension Wrapping where Wrapped: Normalizable {
    func normalized() -> Self {
        Self(value.normalized())
    }
}

// Forward through existing wrappers
extension Capitalized: Normalizable where Wrapped: Normalizable {}
extension Lowercased: Normalizable where Wrapped: Normalizable {}
```

### 2. Create the wrapper

```swift
struct Normalized<Wrapped: Normalizable>: Wrapping {
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
extension Normalized: Equatable where Wrapped: Equatable {}
extension Normalized: Hashable where Wrapped: Hashable {}
extension Normalized: Sendable where Wrapped: Sendable {}
extension Normalized: Codable where Wrapped: Codable {}

// Collection — no body needed
extension Normalized: Sequence where Wrapped: Sequence {}
extension Normalized: Collection where Wrapped: Collection {}
extension Normalized: BidirectionalCollection where Wrapped: BidirectionalCollection {}

// Literals — no body needed
extension Normalized: ArrayExpressible, ExpressibleByArrayLiteral where Wrapped: ArrayExpressible {}
extension Normalized: DictionaryExpressible, ExpressibleByDictionaryLiteral where Wrapped: DictionaryExpressible {}
extension Normalized: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {}
extension Normalized: ExpressibleByIntegerLiteral where Wrapped: ExpressibleByIntegerLiteral {}
extension Normalized: ExpressibleByFloatLiteral where Wrapped: ExpressibleByFloatLiteral {}

// Compatibility with other wrappers — no body needed
extension Normalized: Emptyable where Wrapped: Emptyable {}
extension Normalized: Trimmable where Wrapped: Trimmable {}
extension Normalized: Collapsible where Wrapped: Collapsible {}
```

Pick what you need. The rest is automatic.


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
        .upToNextMinor(from: "2.2.2")
    )
]
```


## Design Philosophy

1. **One invariant per type** — Each primitive does exactly one thing
2. **Zero domain knowledge** — No business logic, no external dependencies
3. **Compose, don't configure** — Stack types instead of passing validation rules
4. **Fail fast at the boundary** — Invalid values are rejected at creation time
