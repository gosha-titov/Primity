import Foundation
import Testing
@testable import Primity

struct Tests {
    
    @Test func codable() async throws {
        
        typealias Tag = NonEmpty<Lowercased<Truncated<`100`, Collapsed<Trimmed<Stripped<String>>>>>>
        let tag = Tag(expressing: "swift development")!
        
        let data = try JSONEncoder().encode(tag)
        let encodedTag = String(data: data, encoding: .utf8)!
        let decodedTag = try JSONDecoder().decode(Tag.self, from: data)
        
        #expect(encodedTag == "\"swift development\"")
        #expect(decodedTag.asString() == "swift development")
        
    }
    
    
    @Test func composition() async throws {
        
        typealias Tag = NonEmpty<Lowercased<Truncated<`100`, Collapsed<Trimmed<Stripped<String>>>>>>
        
        var tag: Tag! = "  Swift   💙 DEvelopment   💻  "
        #expect(*tag == "swift development")
        
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
    
    
    @Test func within() async throws {
        
        typealias TwoThroughFive<Value: Withinable> = Within<`2`, `5`, Value> where Value.Bound == Int
        
        #expect(TwoThroughFive<Int>(0) == nil)
        #expect(TwoThroughFive<[Int]>([]) == nil)
        
        #expect(TwoThroughFive<Int>(2) != nil)
        #expect(TwoThroughFive<[Int]>([1, 2]) != nil)
        
        #expect(TwoThroughFive<Int>(3) != nil)
        #expect(TwoThroughFive<[Int]>([1, 2, 3]) != nil)
        
        #expect(TwoThroughFive<Int>(5) != nil)
        #expect(TwoThroughFive<[Int]>([1, 2, 3, 4, 5]) != nil)
        
        #expect(TwoThroughFive<Int>(6) == nil)
        #expect(TwoThroughFive<[Int]>([1, 2, 3, 4, 5, 6]) == nil)
        
    }
    
    
    @Test func sorted() async throws {
        
        #expect(*Ascended<Array<Int>>([]) == [])
        #expect(*Descended<Array<Int>>([]) == [])
        
        #expect(*Ascended([3, 2, 1, 4]) == [1, 2, 3, 4])
        #expect(*Descended([3, 2, 1, 4]) == [4, 3, 2, 1])
        
        #expect(*Ascended([3, 1, 2, 1]) == [1, 1, 2, 3])
        #expect(*Descended([3, 1, 2, 1]) == [3, 2, 1, 1])
        
        #expect(*Ascended([67]) == [67])
        #expect(*Descended([67]) == [67])
        
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
    
    
    @Test func clamped() async throws {
        
        typealias UnitInterval = Clamped<`0.0`, `1.0`, Double>
        
        #expect(*UnitInterval(-1.0) == 0.0)
        #expect(*UnitInterval(-0.0001) == 0.0)
        
        #expect(*UnitInterval(0.0) == 0.0)
        #expect(*UnitInterval(0.5) == 0.5)
        #expect(*UnitInterval(0.9999) == 0.9999)
        #expect(*UnitInterval(1.0) == 1.0)
        
        #expect(*UnitInterval(1.0001) == 1.0)
        #expect(*UnitInterval(2.0) == 1.0)
        
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
        
        func ragged(_ string: String) -> String {
            return string.ragged()
        }
        
        #expect(ragged("") == "")
        #expect(ragged("hello world") == "hello world")
        #expect(ragged("hello    ") == "hello")
        #expect(ragged("\t hello world \t ") == "\t hello world")
        #expect(ragged("   \t  ") == "")
        #expect(ragged("""
        hello     
        world   \t  
        """) ==  """
        hello
        world
        """)
        
        #expect(ragged("a  \nb\t\n") == "a\nb\n")
        #expect(ragged("a  \r\nb\t\r\nc") == "a\r\nb\r\nc")
        #expect(ragged("a  \rb  \r") == "a\rb\r")
        #expect(ragged("a  \u{2028}b \u{2029} ") == "a\u{2028}b\u{2029}")
        #expect(ragged("a  \nb  \r\nc  \rd  ") == "a\nb\r\nc\rd")
        
        #expect(ragged("  a  b  ") == "  a  b")
        #expect(ragged("a\n   \nb") == "a\n\nb")
        #expect(ragged("a\r\n \t \r\nb") == "a\r\n\r\nb")
        #expect(ragged("a\u{A0}\u{A0}") == "a")
        
        let once = ragged("  a  \r\n b  \n  ")
        #expect(ragged(once) == once)
        
    }
    
    
    @Test func stripped() async throws {
        
        func stripped(_ string: String) -> String {
            return string.stripped()
        }
        
        #expect(stripped("") == "")
        #expect(stripped("0 1 2 3 4 5 6 7 8 9 # & ! @ \" # $ % ^ , . * ( )") == "0 1 2 3 4 5 6 7 8 9 # & ! @ \" # $ % ^ , . * ( )")
        #expect(stripped("hello world") == "hello world")
        #expect(stripped("👋🌍3️⃣") == "")
        #expect(stripped("Hello, 👋 World! 🌍 Let's meet at 3️⃣ PM.") == "Hello,  World!  Let's meet at  PM.")
        
    }
    
}
