import Foundation

struct BagOfWords: Codable {
    let sortedArrayOfWords: [String]

    init(setOfWords: Set<String>) {
        sortedArrayOfWords = Array(setOfWords).sorted()
    }

    internal func binarySearch(_ word: String) -> Int? {
        var lowerIndex = 0
        var upperIndex = sortedArrayOfWords.count - 1

        while true {
            let currentIndex = (lowerIndex + upperIndex) / 2
            if sortedArrayOfWords[currentIndex] == word {
                return currentIndex
            } 
            else if lowerIndex > upperIndex {
                return nil
            } 
            else {
                if sortedArrayOfWords[currentIndex] > word {
                    upperIndex = currentIndex - 1
                } 
                else {
                    lowerIndex = currentIndex + 1
                }
            }
        }
    }

    func embed(arrayOfWords: [String]) -> [Int] {
        var embedding = [Int](repeating: 0, count: sortedArrayOfWords.count)

        for word in arrayOfWords {
            if let index = binarySearch(word) {
                embedding[index] = 1
            }
        }

        return embedding
    }
}