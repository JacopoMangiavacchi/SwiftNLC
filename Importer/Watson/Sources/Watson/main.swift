import Foundation
import SwiftCLI

class ImportCommand: Command {
    let name = "import"
    let shortDescription = "import an IBM Watson workspace JSON file"
    let path = Parameter()
    
    func execute() throws {
        print("Importing \(path.value)")



    }
}

let importer = CLI(name: "Watson", version: "1.0.0", description: "SwiftNLC - IBM Watson Converstation workspace importer")
importer.commands = [ImportCommand()]
let _ = importer.go()
