import Foundation
import CoreML

class SwiftNLCFastTextModel {
    lazy var intents: [String] = {
        return try! JSONDecoder().decode(Array<String>.self, from: Data(contentsOf: Bundle.main.url(forResource:"intents", withExtension: "json")!))
    }()
    
    let ft = SwiftFastText(withModelUrl: Bundle.main.url(forResource:"wikimodel", withExtension: "bin")!)
    
    func predict(_ utterance: String) -> (String, Float)? {
        let vector = ft.getSentenceVector(sentence: utterance)
        
        let model = SwiftNLCFastText()
        
        let size = NSNumber(value: vector.count)
        let mlMultiArrayInput = try! MLMultiArray(shape:[size], dataType:MLMultiArrayDataType.double)
        
        for i in 0..<size.intValue {
            mlMultiArrayInput[i] = NSNumber(floatLiteral: Double(vector[i]))
        }

        let prediction = try! model.prediction(fromVectors: mlMultiArrayInput, gru_1_h_in: nil)

        var pos = -1
        var max:Float = 0.0
        
        for i in 0..<prediction.entities.count {
            let p = prediction.entities[i].floatValue
            
            print("\(prediction.entities[i].doubleValue) - \(intents[i])")
            
            if p > max {
                max = p
                pos = i
            }
        }
        
        return pos >= 0 ? (intents[pos], max) : nil
    }
}
