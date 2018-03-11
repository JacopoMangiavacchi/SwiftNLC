import Foundation
import SwiftCLI

class ImportCommand: Command {
    let name = "import"
    let shortDescription = "import an IBM Watson workspace JSON file"
    let inputPath = Parameter()
    let outputPath = Parameter()
    
    func execute() throws {
        print("Importing \(inputPath.value) to \(outputPath.value)")

        do {
            let workspace = try WatsonConversationWorkspace(fromURL: URL(fileURLWithPath: inputPath.value))
            
            // for intent in workspace.intents {
            //     print(intent.intent)
            //     for sample in intent.examples {
            //         print(" \(sample.text)")
            //     }
            // }

            let dataset = Dataset(intents: workspace.intents.map{ Intent(intent: $0.intent, utterances: $0.examples.map{ $0.text }  ) })

            let data = try JSONEncoder().encode(dataset)
            try data.write(to: URL(fileURLWithPath: outputPath.value))

            // let string = String(data: data, encoding: String.Encoding.utf8)
            // print(string)

            print("done!")
        }
        catch let error {
            print("inputPath not valid - \(error.localizedDescription)")
        }   
    }
}

let importer = CLI(name: "Watson", version: "1.0.0", description: "SwiftNLC - IBM Watson Converstation workspace importer")
importer.commands = [ImportCommand()]
let _ = importer.go()
