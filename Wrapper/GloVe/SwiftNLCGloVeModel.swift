import Foundation
import CoreML

class SwiftNLCGloVeModel {

    lazy var words: [String: Int] = {
        return try! JSONDecoder().decode(Dictionary<String, Int>.self, from: Data(contentsOf: Bundle.main.url(forResource:"Words", withExtension: "json")!))
    }()
    
    

    
    var lemmatizer = Lemmatizer()
    
    func predict(_ utterance: String) -> (String, Float)? {
        let lemmas = lemmatizer.lemmatize(text: utterance).compactMap { $0.1 }

        print(lemmas)

        //let embedding = bagOfWords.embed(arrayOfWords: lemmas)

        let model = SwiftNLCGloveRNN()
        
        return ("NIL", 0.0)
        
        
//        let size = NSNumber(value: embedding.count)
//        let mlMultiArrayInput = try! MLMultiArray(shape:[size], dataType:MLMultiArrayDataType.double)
//
//        for i in 0..<size.intValue {
//            mlMultiArrayInput[i] = NSNumber(floatLiteral: Double(embedding[i]))
//        }
//
//        let prediction = try! model.prediction(input: SwiftNLCInput(embeddings: mlMultiArrayInput))
//
//        var pos = -1
//        var max:Float = 0.0
//
//        for i in 0..<prediction.entities.count {
//            let p = prediction.entities[i].floatValue
//            if p > max {
//                max = p
//                pos = i
//            }
//        }
//
//        return pos >= 0 ? (intents[pos], max) : nil
    }
}
