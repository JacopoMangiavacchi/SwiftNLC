//
//  CFastTextWrapper.hpp
//  CFastTextWrapper C Wrapper
//
//  Created by Jacopo Mangiavacchi on 3/15/18.
//  Copyright © 2018 Jacopo Mangiavacchi. All rights reserved.
//

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

    const void * initializeFastTextObject();
    void fasttextLoadModel(const void *object, const char* path);
    int fasttextgetDimension(const void *object);
    void fasttextgetSentenceVector(const void *object, const char* sentence, float* sentenceVector);

#ifdef __cplusplus
}
#endif
