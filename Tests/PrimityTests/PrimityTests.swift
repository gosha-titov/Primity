import Testing
@testable import Primity

@Test func example() async throws {
    typealias Name = NonEmpty<Trimmed<Stripped<String>>>
//    let name = Name(expressing: "Mia")
    let name: Name? = "Mia Miller   "
//    let string = name.asString()
    
    typealias Numbers = InRange<RangeBoundOne, RangeBoundNine, Set<Int>>
    
    let numbers: Numbers? = Numbers([1, 5, 2, 4])?.inserting(6)
    print(numbers)
    
    
    let progress: UnitInterval<Double> = 10.77
    print(progress)
    
}
