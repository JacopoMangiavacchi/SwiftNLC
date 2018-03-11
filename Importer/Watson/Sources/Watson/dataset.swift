import Foundation

struct Intent: Codable {
    let intent: String
    let utterances: [String]
} 

struct Dataset : Codable {
    let intents: [Intent]
}
