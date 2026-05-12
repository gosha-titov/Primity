# Primity

A collection of generic, reusable type primitives for building type-safe systems in Swift. 
These primitives enforce invariants at compile time, eliminating runtime checks and reducing boilerplate.


## Overview

Primity follows a simple but powerful principle: **move validation from runtime to compile time**. 
Instead of scattering validation logic throughout your codebase, encapsulate it in types that guarantee their invariants.

This approach:
- **Eliminates boilerplate** — No more repeated manual validation logic
- **Prevents bugs** — Invalid states become unrepresentable
- **Improves readability** — Type signatures communicate requirements
- **Enables composition** — Build complex validations from simple primitives

These primitives are intentionally **domain-agnostic**. 
They contain no business logic, application-specific knowledge, or external dependencies.


## What Are Type Primitives?

Type primitives are lightweight wrapper types that enforce a single invariant. 
They're the building blocks for creating robust domain models.

### Before: Scattered Runtime Validation

```swift
struct User {
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

### After: Compile-Time Guarantees

```swift
struct User {
    let name: NonEmpty<Trimmed<String>>
    let awards: Descended<Array<Award>>
    let progress: NonNegative<Double>
}
```

### Recommended Style: Nested Typealiases

For cleaner APIs and better encapsulation, define domain-specific aliases inside your model:

```swift
struct User: Equatable, Codable, Sendable {
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


## Composition

The real power comes from stacking primitives. 
Complex validations are built by composing simple ones:

```swift
typealias Tag = NonEmpty<Lowercased<Truncated<Collapsed<Trimmed<Stripped<String>>>>>>

typealias Paragraph = NonEmpty<Collapsed<Trimmed<String>>>

typealias AnswerOption = NonEmpty<Truncated<Collapsed<Trimmed<String>>>>

typealias AnswerOptions = TwoThroughNine<OrderedSet<AnswerOption>>
```

Each layer enforces one invariant.


## Immutable Mutations

Wrappers provide functional mutation APIs — every operation returns a new instance:

```swift
typealias Tags = NonEmpty<Array<Lowercased<String>>>
 
let tags: Tags? = ["swift", "ios"]
// ...
let tags1 = tags?.appending("macos") // ["swift", "ios", "macos"]
// ...
let tags2 = tags1?.removing("ios") // ["swift", "macos"]
```


## Design Philosophy

1. **One invariant per type** — Each primitive does exactly one thing
2. **Zero domain knowledge** — No business logic, no external dependencies
3. **Compose, don't configure** — Stack types instead of passing validation rules
4. **Fail fast at the boundary** — Invalid values are rejected at creation time


**PS.** These primitives honestly made my life easier. 
I've gutted thousands of lines of validation and adjustment code across the whole project. 
Every model now just stacks these blocks — or custom wrappers you can write yourself for any domain-specific rule.
It's cleaner to read, effortless to support, and the code basically writes itself.


# Installation

In order to install `Primity`, you add the following url in Xcode with the Swift Package Manager.

```
https://github.com/gosha-titov/Primity.git
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/gosha-titov/Primity.git", 
        .upToNextMinor(from: "1.0.0")
    )
]
```
