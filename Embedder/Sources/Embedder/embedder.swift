import Foundation

struct BagOfWords: Codable {
    let sortedArrayOfWords: [String]

    init(setOfWords: Set<String>) {
        sortedArrayOfWords = Array(setOfWords).sorted()
    }

    func embed(arrayOfWords: [String]) -> [Int] {


        return [Int]()
    }
}