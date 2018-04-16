import Foundation
import SwiftCLI
import SwiftFastText

class ImportCommand: Command {
    let name = "import"
    let shortDescription = "import a SwiftNLC Dataset JSON file"
    let inputPath = Parameter()
    let fastTextModelPath = Parameter()
    
    func execute() throws {
        print("Importing \(inputPath.value) to vectorizedDataset.json and intents.json")

        let ft = SwiftFastText(withModelUrl: URL(string: fastTextModelPath.value)!)

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: inputPath.value))
            let dataset =  try JSONDecoder().decode(Dataset.self, from: data)

            var vectorizedDataset = FastTextTrainingDataset(vectorSize: ft.getDimension(), intents: [FastTextTrainingIntent]())

            for intent in dataset.intents {
                var vectorIntent = FastTextTrainingIntent(intent: intent.intent, sentenceVectors: [[Float]]())
                for utterance in intent.utterances {
                    let vector = ft.getSentenceVector(sentence: utterance)
                    vectorIntent.sentenceVectors.append(vector)
                }
                vectorizedDataset.intents.append(vectorIntent)
            }


            let vectorizedDatasetData = try JSONEncoder().encode(vectorizedDataset)
            try vectorizedDatasetData.write(to: URL(fileURLWithPath: "vectorizedDataset.json"))

            let intentsArray = vectorizedDataset.intents.map { $0.intent }
            let intentsData = try JSONEncoder().encode(intentsArray)
            try intentsData.write(to: URL(fileURLWithPath: "intents.json"))

            print("done!")
        }
        catch let error {
            print("inputPath not valid - \(error.localizedDescription)")
        }   
    }
}

let importer = CLI(name: "fastText", version: "1.0.0", description: "SwiftNLC - Dataset JSON importer")
importer.commands = [ImportCommand()]
let _ = importer.go()




