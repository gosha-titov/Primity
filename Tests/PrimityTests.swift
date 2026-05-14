import Testing
@testable import Primity

@Test func composition() async throws {
    
    typealias Tag = NonEmpty<Lowercased<Truncated<Collapsed<Trimmed<Stripped<String>>>>>>
    
    var tag: Tag? = "  Swift   💙 DEvelopment   💻  "
    #expect(tag!.value == "swift development")
    
    tag = " 💙 \n 💻"
    #expect(tag == nil)
    
}


@Test func nonempty() async throws {
    
    #expect(NonEmpty("") == nil)
    #expect(NonEmpty("1") != nil)
    #expect(NonEmpty("hello") != nil)
    
    #expect(NonEmpty<Array<Int>>([]) == nil)
    #expect(NonEmpty([1]) != nil)
    #expect(NonEmpty([1, 2, 3]) != nil)
    
    #expect(NonEmpty<Set<Int>>([]) == nil)
    #expect(NonEmpty(Set([1])) != nil)
    #expect(NonEmpty(Set([1, 2, 3])) != nil)
    
    #expect(NonEmpty([Int: String]()) == nil)
    #expect(NonEmpty([1: "one"]) != nil)
    #expect(NonEmpty([1: "one", 2: "two"]) != nil)
    
}


@Test func inrange() async throws {
    
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, Int>(0) == nil)
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, [Int]>([]) == nil)
    
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, Int>(2) != nil)
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, [Int]>([1, 2]) != nil)
    
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, Int>(3) != nil)
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, [Int]>([1, 2, 3]) != nil)
    
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, Int>(5) != nil)
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, [Int]>([1, 2, 3, 4, 5]) != nil)
    
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, Int>(6) == nil)
    #expect(InRange<RangeBounds.`2`, RangeBounds.`5`, [Int]>([1, 2, 3, 4, 5, 6]) == nil)

}


@Test func sorted() async throws {
    
    #expect(Ascended<Array<Int>>([]).value == [])
    #expect(Descended<Array<Int>>([]).value == [])
    
    #expect(Ascended([3, 2, 1, 4]).value == [1, 2, 3, 4])
    #expect(Descended([3, 2, 1, 4]).value == [4, 3, 2, 1])
    
    #expect(Ascended([3, 1, 2, 1]).value == [1, 1, 2, 3])
    #expect(Descended([3, 1, 2, 1]).value == [3, 2, 1, 1])
    
    #expect(Ascended([67]).value == [67])
    #expect(Descended([67]).value == [67])
    
}


@Test func nonnegative() async throws {
    
    #expect(NonNegative(-1.0) == nil)
    #expect(NonNegative(-0.1) == nil)
    #expect(NonNegative(-1) == nil)
    
    #expect(NonNegative(-0) != nil)
    #expect(NonNegative(0.0) != nil)
    
    #expect(NonNegative(5) != nil)
    #expect(NonNegative(1.23) != nil)
    
}


@Test func positive() async throws {
    
    #expect(Positive(-1.0) == nil)
    #expect(Positive(-0.1) == nil)
    #expect(Positive(-1) == nil)
    
    #expect(Positive(-0) == nil)
    #expect(Positive(0.0) == nil)
    
    #expect(Positive(5) != nil)
    #expect(Positive(1.23) != nil)
    
}


@Test func unitinterval() async throws {
    
    #expect(UnitInterval(-1.0).value == 0.0)
    #expect(UnitInterval(-0.0001).value == 0.0)
    
    #expect(UnitInterval(0.0).value == 0.0)
    #expect(UnitInterval(0.5).value == 0.5)
    #expect(UnitInterval(0.9999).value == 0.9999)
    #expect(UnitInterval(1.0).value == 1.0)
    
    #expect(UnitInterval(1.0001).value == 1.0)
    #expect(UnitInterval(2.0).value == 1.0)
    
}


@Test func collapsed() async throws {
    
    var string = ""
    var result: String {
        return Collapsed(string).value
    }
    
    #expect(result == "")
    
    string = "hello world"
    #expect(result == "hello world")
    
    string = "ABC \n   DEF  \t GHI  JKL"
    #expect(result == "ABC DEF GHI JKL")
    
    string = "   \n\t  "
    #expect(result == " ")
    
}


@Test func ragged() async throws {
    
    var string = ""
    var result: String {
        return Ragged(string).value
    }
    
    string = "hello world"
    #expect(result == "hello world")
    
    string = "hello    "
    #expect(result == "hello")
    
    string = """
    hello     
    world   \t  
    """
    #expect(result == """
    hello
    world
    """)
    
}


@Test func stripped() async throws {
    
    var string = ""
    var result: String {
        return Stripped(string).value
    }
    
    #expect(result == "")
    
    string = "hello world"
    #expect(result == "hello world")
    
    string = "👋🌍3️⃣"
    #expect(result == "")
    
    string = "Hello, 👋 World! 🌍 Let's meet at 3️⃣ PM."
    #expect(result == "Hello,  World!  Let's meet at  PM.")
    
}
