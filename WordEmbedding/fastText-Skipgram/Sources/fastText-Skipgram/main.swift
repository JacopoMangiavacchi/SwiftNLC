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

            for intent in dataset.intents {
                for utterance in intent.utterances {
                    let _ = ft.getSentenceVector(sentence: utterance)
                }
            }


            // let vectorizedDatasetData = try JSONEncoder().encode(vectorizedDataset)
            // try vectorizedDatasetData.write(to: URL(fileURLWithPath: "vectorizedDataset.json"))

            // let intentsArray = vectorizedDataset.intents.map { $0.intent }
            // let intentsData = try JSONEncoder().encode(intentsArray)
            // try intentsData.write(to: URL(fileURLWithPath: "intents.json"))

            print("done!")
        }
        catch let error {
            print("inputPath not valid - \(error.localizedDescription)")
        }   
    }
}

let importer = CLI(name: "fastText-Skipgram", version: "1.0.0", description: "SwiftNLC - Dataset JSON importer")
importer.commands = [ImportCommand()]
let _ = importer.go()




