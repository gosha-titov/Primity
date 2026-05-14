
<img width="1344" height="768" alt="primity_logo" src="https://github.com/user-attachments/assets/8b5c3147-ac38-43cb-9852-178c47507c26" />

# Primity

A collection of generic, reusable type primitives for building type-safe systems in Swift. 
These primitives move validation from runtime to compile time, eliminating boilerplate and making invalid states unrepresentable.


## Overview

Primity follows one principle: **encode invariants in types**. 
Instead of scattering `guard` checks across initializers, express requirements directly in the type signature.

This approach:
- **Eliminates boilerplate** — No more repeated manual validation
- **Prevents bugs** — Invalid states become literally unrepresentable
- **Improves readability** — The type signature tells you a story
- **Enables composition** — Stack small blocks into complex rules

These primitives are **domain-agnostic**. 
No business logic, no external dependencies.


## The Problem

Every Swift developer has written this:

```swift
struct User: Sendable {
    let name: String        // Should be non-empty and trimmed
    let awards: [Award]     // Should be sorted in descending order
    let progress: Double    // Should be non-negative

    init?(name: String, awards: [Award], progress: Double) {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty, progress >= 0 else { return nil }
        self.name = name
        self.awards = awards.sorted(by: >)
        self.progress = progress
    }
}
```

Three fields, and already a wall of logic in the initializer. 
And that is the simplified example.

Then you add `Codable` manually because auto-synthesis bypasses your `init` and writes values straight to properties. 
So you write a custom `init(from:)` that calls your failable initializer and throws on invalid data. Over and over, for every model.

And do not forget the **tests** — you must cover every `guard` branch in every initializer.


## The Solution

The same `User` with Primity:

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
The type `Name` speaks for itself: a non-empty, trimmed string. 
`Awards` — a descending-sorted array. 
`Progress` — a non-negative number.

`Codable` works automatically. Wrappers serialize their contents transparently while preserving all guarantees.


### Why nested typealiases?

To keep client code independent of the specific wrapper chain. 
You do not need to know what is inside `User.Name`, and you do not rewrite call sites when you change `NonEmpty<Trimmed<String>>` to `NonEmpty<Collapsed<Trimmed<String>>>`.

```swift
// Good: implementation details are hidden
let input: String = //...
if let name = User.Name(expressing: input) {...}

// Bad: tightly coupled to the exact chain, breaks on changes
if let name = NonEmpty(Trimmed(input)) {...}
```


## How It Works

Wrappers come in two flavors.

**Validators** reject invalid input. They return optionals (`init?`):
- `NonEmpty` — non-empty string or collection
- `NonNegative` / `Positive` — numeric constraints
- `InRange` — collection size within bounds

**Adjusters** always accept input and transform it:
- `Trimmed`, `Stripped`, `Collapsed` — whitespace handling
- `Capitalized`, `Lowercased`, `Uppercased` — casing
- `Sorted` (via `Ascended` / `Descended`) — sorting
- `Truncated` — length truncation
- `UnitInterval` — clamps to `0…1`


## Composition

The real power is stacking. Complex rules are built from simple blocks:

```swift
typealias Tag = NonEmpty<Lowercased<Truncated<Collapsed<Trimmed<Stripped<String>>>>>>

let tag: Tag? = "  Swift   💙 DEVelopment   💻  "

print(tag) // "swift development"
```

Each layer does one thing. The result is guaranteed to be clean, non-empty, and lowercased.

```swift
typealias Paragraph = NonEmpty<Collapsed<Trimmed<String>>>

typealias TwoThroughNine<Value: Rangable> = InRange<RangeBounds.`2`, RangeBounds.`9`, Value>
typealias AnswerOption = NonEmpty<Truncated<Collapsed<Trimmed<String>>>>
typealias AnswerOptions = TwoThroughNine<OrderedSet<AnswerOption>>
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

Without this you would write the monstrosity:

```swift
let paragraph = Paragraph(Collapsed(Trimmed(text)))
```

Extracting values is just as easy:

```swift
let string = Trimmed(Stripped("swift")).asString()
let array = NonEmpty(Ascended([5, 1, 3, 2, 4]))?.asArray()
let double = NonNegative(95.97)?.asDouble()

let text = Truncated(Collapsed(richText)).expressed()
```


## Immutable Mutations

Wrappers are immutable. Operations return new instances:

```swift
Ascended([5, 2, 1, 4, 3])
    .appending(6)

NonEmpty(["en": "Hello", "fr": "Bonjour"])?
    .setting("Привет", for: "ru")

Trimmed("Jobs")
    .prepending("Steve ")
```

Methods are available for arrays, strings, dictionaries, and sets.


## Architecture

Under the hood it is protocol-oriented programming, pure and simple:

- `Wrapping` — for adjusters, initialization always succeeds
- `MaybeWrapping` — for validators, initialization fails on bad data
- `Expressible` — creation from a raw value

Bridging protocols (`WrappingWithCollection`, `WrappingWithCodable`, `WrappingWithStringExpressible`) automatically forward conformances through the wrapper chain. `NonEmpty<String>` behaves like `String`. `Sorted<Array<Int>>` behaves like `Array`. `Codable` works out of the box.

There is no magic. A wrapper is just a container that mirrors the behavior of its wrapped value:

```swift
protocol Capitalizable {
    func capitalized() -> Self
}

struct Capitalized<Value: Capitalizable>: Wrapping {
    let value: Value
    init(_ value: Value) {
        self.value = value.capitalized()
    }
}

extension Capitalized: Trimmable where Value: Trimmable {
    func trimmed() -> Self {
        Self(value.trimmed())
    }
}
```


## Custom Types

Want to wrap your own type? Conform it to the required protocol:

- `Capitalizable` — for `Capitalized`
- `Sortable` — for `Sorted`
- `Trimmable` — for `Trimmed`

Example:

```swift
extension RichText: Trimmable {
    func trimmed() -> RichText {...}
}

extension RichText: Collapsible {
    func collapsed() -> RichText {...}
}

typealias Bio = Collapsed<Trimmed<RichText>>
```


## Favorite Textual Compositions

Here are the typealiases I use most often in real projects. 
They show how a few primitives stack into domain-specific, self-documenting types.

```swift
typealias Title = NonEmpty<Truncated<Collapsed<Trimmed<String>>>>

typealias Paragraph = NonEmpty<Collapsed<Trimmed<RichText>>>

typealias Name = NonEmpty<Truncated<Collapsed<Trimmed<Stripped<String>>>>>

typealias Tag = NonEmpty<Lowercased<Truncated<Collapsed<Trimmed<Stripped<String>>>>>>
```

```swift
let title: Title? = "   Swift   Development   "
// title is "Swift Development"

let name: Name? = "👋 Mia 🌍"
// name is "Mia"

let tag: Tag? = "  SWIFT  DeV  "
// tag is "swift dev"
```

## The Philosophy Note

A wrapper never changes the type of the wrapped value. It only validates or adjusts.

That is why `Mapped` — replacing the element type — is against the philosophy and not implemented.


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
        .upToNextMinor(from: "1.0.1")
    )
]
```


## Design Philosophy

1. **One invariant per type** — Each primitive does exactly one thing
2. **Zero domain knowledge** — No business logic, no external dependencies
3. **Compose, don't configure** — Stack types instead of passing validation rules
4. **Fail fast at the boundary** — Invalid values are rejected at creation time


---

**PS.** These primitives honestly made my life easier. 
I have gutted thousands of lines of validation and adjustment code across the whole project. 
Every model now just stacks these blocks — or custom wrappers you can write yourself for any domain-specific rule. 
It's cleaner to read, effortless to support, and the code basically writes itself.
