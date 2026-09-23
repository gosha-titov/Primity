//
// Implementation Notes
// ––––––––––––––––––––
//
// In order to make a wrapper comparabale, simply add this line:
//
//      extension YourWrapper: Comparable where Wrapped: Comparable {}
//
// No manual implementation is needed because the default one is automatically provided.

extension AnyWrapping where Wrapped: Comparable {
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.value < rhs.value
    }
    
}
