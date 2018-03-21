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

struct TrainingIntent: Codable {
    let intent: String
    let embeddedUtterances: [[Int]]
} 

struct TrainingDataset : Codable {
    let embeddingSize: Int
    let intents: [TrainingIntent]
}
