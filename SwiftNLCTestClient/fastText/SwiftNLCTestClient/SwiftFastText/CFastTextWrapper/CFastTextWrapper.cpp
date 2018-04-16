//
//  CFastTextWrapper.cpp
//  CFastTextWrapper C Wrapper
//
//  Created by Jacopo Mangiavacchi on 3/15/18.
//  Copyright © 2018 Jacopo Mangiavacchi. All rights reserved.
//

#include "include/CFastTextWrapper.hpp"
#include "FastText/fasttext.h"
#include <string>
#include <sstream>
#include <iostream>

const void * initializeFastTextObject() {
    fasttext::FastText *ft = new fasttext::FastText();
    return (void *)ft;
}


void fasttextLoadModel(const void *object, const char* path) {
    fasttext::FastText *ft = (fasttext::FastText *)object;
    ft->loadModel(path);
}


int fasttextgetDimension(const void *object) {
    fasttext::FastText *ft = (fasttext::FastText *)object;
    return ft->getDimension();
}


void fasttextgetSentenceVector(const void *object, const char* sentence, float* sentenceVector) {
    fasttext::FastText *ft = (fasttext::FastText *)object;
    fasttext::Vector svec(ft->getDimension());
    std::string mystring(sentence);
    std::istringstream is(mystring);

    ft->getSentenceVector(is, svec);

    for (int i=0; i<svec.size(); i++) {
        sentenceVector[i] = (float)svec[i];
    }
}
