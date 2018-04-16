//
//  FastText.swift
//  FastText Swift Wrapper
//
//  Created by Jacopo Mangiavacchi on 3/15/18.
//  Copyright © 2018 Jacopo Mangiavacchi. All rights reserved.
//

import Foundation

open class SwiftFastText {
    fileprivate let fastTextObject: UnsafeMutableRawPointer

    public init() {
        self.fastTextObject = UnsafeMutableRawPointer(mutating: initializeFastTextObject())
    }
    
    public convenience init(withModelUrl: URL) {
        self.init()
        loadModel(withModelUrl)
    }

    public func loadModel(_ url: URL) {
        var cPath = url.path.cString(using: .utf8)!
        fasttextLoadModel(fastTextObject, &cPath);
    }
    
    public func getDimension() -> Int {
        return Int(fasttextgetDimension(fastTextObject))
    }

    public func getSentenceVector(sentence: String) -> [Float] {
        var cSentence = sentence.cString(using: .utf8)!
        var sentenceVector = [Float](repeating: 0.0, count: Int(fasttextgetDimension(fastTextObject)))

        fasttextgetSentenceVector(fastTextObject, &cSentence, &sentenceVector);    

        return sentenceVector
    }
}

