prefix operator *

/// Return an underlying raw value of the given wrapper.
///
/// Use this operator instead of manual `.expressed()`.
///
/// ## Example
/// ```
/// typealias Tag = Lowercased<Collapsed<Trimmed<Stripped<String>>>>
///
/// let tag = Tag("swift development")
///
/// let string = *tag
///
/// // Equivalent to:
/// let string = tag.expressed()
/// ```
public prefix func * <W: AnyExpressible>(_ wrapper: W) -> W.Expressed {
    return wrapper.expressed()
}

/// Return an underlying raw value of the given wrapper, if exists.
///
/// Use this operator instead of manual `.expressed()`.
///
/// ## Example
/// ```
/// typealias Tag = NonEmpty<Lowercased<Collapsed<Trimmed<Stripped<String>>>>>
///
/// let maybeTag = Tag("swift development")
///
/// let maybeString = *maybeTag
///
/// // Equivalent to:
/// let maybeString = maybeTag?.expressed()
/// ```
public prefix func * <W: AnyExpressible>(_ wrapper: W?) -> W.Expressed? {
    return wrapper?.expressed()
}
