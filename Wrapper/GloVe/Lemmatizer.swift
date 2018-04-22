import Foundation

// Use NSLinguisticTagger to lemmatize utterances
class Lemmatizer {
    typealias TaggedToken = (String, String?)

    func tag(text: String, scheme: String) -> [TaggedToken] {
        let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .omitOther, .joinNames]
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: Int(options.rawValue))

        tagger.string = text
        
        var tokens: [TaggedToken] = []
        
        tagger.enumerateTags(in: NSMakeRange(0, text.count), scheme:NSLinguisticTagScheme(rawValue: scheme), options: options) { tag, tokenRange, _, _ in
            
            let token = (text as NSString).substring(with: tokenRange)
            tokens.append((token, tag?.rawValue))
        }
        
        return tokens
    }

    func lemmatize(text: String) -> [TaggedToken] {
        return tag(text: text.lowercased(), scheme: NSLinguisticTagScheme.lemma.rawValue)
    }
}
