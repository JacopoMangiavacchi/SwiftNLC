import Foundation
import SwiftCLI

class ImportCommand: Command {
    let name = "import"
    let shortDescription = "import a SwiftNLC Dataset JSON file"
    let inputPath = Parameter()
    
    func execute() throws {
        print("Importing \(inputPath.value) to encoding.bin, corpus.bin and entity.bin")

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: inputPath.value))
            let dataset =  try JSONDecoder().decode(Dataset.self, from: data)



            let options = NSLinguisticTagger.Options.omitWhitespace.rawValue | NSLinguisticTagger.Options.joinNames.rawValue
            let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: Int(options))

            let inputString = "This is a very long test for you to try"
            tagger.string = inputString

            let range = NSRange(location: 0, length: inputString.utf16.count)
            tagger.enumerateTags(in: range, scheme: .nameTypeOrLexicalClass, options: NSLinguisticTagger.Options(rawValue: options)) { tag, tokenRange, sentenceRange, stop in
                guard let range = Range(tokenRange, in: inputString) else { return }
                let token = inputString[range]
                print("\(tag): \(token)")
            }






            print("done!")
        }
        catch let error {
            print("inputPath not valid - \(error.localizedDescription)")
        }   
    }
}

let importer = CLI(name: "Embedder", version: "1.0.0", description: "SwiftNLC - Dataset JSON importer")
importer.commands = [ImportCommand()]
let _ = importer.go()




