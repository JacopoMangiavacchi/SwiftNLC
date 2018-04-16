import Foundation

//JSON INPUT FROM IMPORTER

struct Intent: Codable {
    let intent: String
    let utterances: [String]
} 

struct Dataset : Codable {
    let intents: [Intent]
}


//JSON OUTPUT FOR MODEL TRAINING

struct OneHotTrainingIntent: Codable {
    var intent: String
    var embeddedUtterances: [[Int]]
} 

struct OneHotTrainingDataset : Codable {
    var embeddingSize: Int
    var intents: [OneHotTrainingIntent]
}


struct FastTextTrainingIntent: Codable {
    var intent: String
    var sentenceVectors: [[Float]]
} 

struct FastTextTrainingDataset : Codable {
    var vectorSize: Int
    var intents: [FastTextTrainingIntent]
}
