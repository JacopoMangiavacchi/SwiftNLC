import Foundation
import CoreML

class SwiftNLCGloVeModel {

    lazy var wordDictionary: [String: Int] = {
        return try! JSONDecoder().decode(Dictionary<String, Int>.self, from: Data(contentsOf: Bundle.main.url(forResource:"Words", withExtension: "json")!))
    }()
    
    

    
    var lemmatizer = Lemmatizer()
    
    func predict(_ utterance: String) -> (String, Double)? {
        let words = lemmatizer.lemmatize(text: utterance).compactMap { $0.0 } //$0.1 for lemma -- $0.0 Do not take lemma but original word !!!

        var embedding = [Int]()
        for word in words {
            embedding.append(wordDictionary[word] ?? 0)
        }
        
        let model = SwiftNLCGloveRNN()

        guard let input_data = try? MLMultiArray(shape:[20,1,1], dataType:.double) else {
            fatalError("Unexpected runtime error. input_data")
        }
        guard let gru_1_h_in = try? MLMultiArray(shape:[100], dataType:.double) else {
            fatalError("Unexpected runtime error. gru_1_h_in")
        }
        
        for i in 0..<100 {
            gru_1_h_in[i] = NSNumber(value: 0.0)
        }
        
        var i = 0
        while i<embedding.count {
            input_data[i] = NSNumber(value: embedding[i])
            i += 1
        }
        while i<20 {
            input_data[i] = NSNumber(value: 0.0)
            i += 1
        }

        let input = SwiftNLCGloveRNNInput(vectors: input_data, gru_1_h_in: gru_1_h_in)
        
        guard let prediction = try? model.prediction(input: input) else {
            fatalError("Unexpected runtime error. Prediction")
        }
            
        var max:Double = 0.0
        var pos = -1
        for i in 0..<8 {
            let value = prediction.entities[i].doubleValue
            if value > max {
                max = value
                pos = i
            }
        }

        return ("\(pos)", max)
    }
}
