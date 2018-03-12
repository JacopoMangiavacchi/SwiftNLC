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

            var setOfWords = Set<String>()            
            var tempLemmatizedIntentsDictionary = [String : [[String]]]() // Intents : [[Lemma]]
            let l = Lemmatizer()

            for intent in dataset.intents {
                var tempIntentLemmaUtterancesArray = [[String]]()

                for utterance in intent.utterances {
                    var tempLemmaUtteranceArray = [String]()

                    for lemmaTuple in l.lemmatize(text: utterance) {
                        if let lemma = lemmaTuple.1 {
                            let lowerLemma = lemma.lowercased()
                            setOfWords.insert(lowerLemma)
                            tempLemmaUtteranceArray.append(lowerLemma)
                        }
                    }

                    tempIntentLemmaUtterancesArray.append(tempLemmaUtteranceArray)
                }

                tempLemmatizedIntentsDictionary[intent.intent] = tempIntentLemmaUtterancesArray
            }

            print(setOfWords)

            //TODO: Create arrayOfWords from setOfWords

            var lemmatizedDataset = TrainingDataset(embeddingSize: setOfWords.count, intents: [TrainingIntent]())


            //TODO: Export arrayOfWords
            //TODO: Export lemmatizedDataset


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




