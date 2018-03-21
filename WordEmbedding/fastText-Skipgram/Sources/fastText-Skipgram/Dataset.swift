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
    let intent: String
    let embeddedUtterances: [[Int]]
} 

struct OneHotTrainingDataset : Codable {
    let embeddingSize: Int
    let intents: [OneHotTrainingIntent]
}


struct FastTextTrainingIntent: Codable {
    let intent: String
    let sentenceVectors: [[Float]]
} 

struct FastTextTrainingDataset : Codable {
    let vectorSize: Int
    let intents: [FastTextTrainingIntent]
}
