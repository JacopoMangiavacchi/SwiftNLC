import Foundation
import SwiftCLI

class ImportCommand: Command {
    let name = "import"
    let shortDescription = "import a SwiftNLC Dataset JSON file"
    let inputPath = Parameter()
    
    func execute() throws {
        print("Importing \(inputPath.value) to bagOfWords.json, lemmatizedDataset.json and intents.json")

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

            let bagOfWords = BagOfWords(setOfWords: setOfWords)

            let lemmatizedDataset = TrainingDataset(embeddingSize: bagOfWords.sortedArrayOfWords.count, 
                                                    intents: tempLemmatizedIntentsDictionary.map { key, value in 
                                                       TrainingIntent(intent: key, embeddedUtterances: value.map {
                                                           bagOfWords.embed(arrayOfWords: $0)
                                                       }) 
                                                    })

            let bagOfWordsData = try JSONEncoder().encode(bagOfWords)
            try bagOfWordsData.write(to: URL(fileURLWithPath: "bagOfWords.json"))

            let lemmatizedDatasetData = try JSONEncoder().encode(lemmatizedDataset)
            try lemmatizedDatasetData.write(to: URL(fileURLWithPath: "lemmatizedDataset.json"))

            let intentsArray = lemmatizedDataset.intents.map { $0.intent }
            let intentsData = try JSONEncoder().encode(intentsArray)
            try intentsData.write(to: URL(fileURLWithPath: "intents.json"))

            print("done!")
        }
        catch let error {
            print("inputPath not valid - \(error.localizedDescription)")
        }   
    }
}

let importer = CLI(name: "oneHot-NSLinguisticTagger", version: "1.0.0", description: "SwiftNLC - Dataset JSON importer")
importer.commands = [ImportCommand()]
let _ = importer.go()




