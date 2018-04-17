# SwiftNLC
Swift Natural Language Classifier with CoreML / TensorFlow

A Natural Language Classifier (NLC) capable to run offline on iOS/watchOS/tvOS devices for understanding Intents from text utterances

For complete documention please follow the tutorial on https://medium.com/@JMangia/coreml-nlc-with-keras-tensorflow-and-apple-nslinguistictagger-cd971cda64c9


# Folders / Projects

- Importer: Swift macOS console app to import Intents and Utterances from different formats
- SampleDatasets: json files containing Intents definitions and sample Utterances
- WordEmbedding: Swift console app to prepare word embedding vectors for training
- ModelNotebooks: Jupyter Notebook for Keras/TensorFlow Classifier and CoreML export
- Wrapper: Swift iOS code to simplify access to CoreML Classifier model
- SwiftNLCTestClient: Test iOS application to play with Wrapper and CoreML model


# Importer

This subproject contains Swift code to be executed on Linux or macOS environments to import a file containing the Dataset to be used for training the NLC model.

The idea is to provide different importer for different file format being able to import Datasets from existing NLU/NLC/Conversation platforms such as IBM Watson, AWS Alexa/Lex, Google DialogFlow etc.

First Importer implemented is for the IBM Watson Conversation service.  Watson use a JSON "workspace" file containing Intents, with several sample utterances, and also Entities (Slots), also with sample utterances, as well as a Tree for complex Dialog management of long running conversation.  This project is just about NLC and it only import Intents and sample utterances from this file.

Usage example:
    Watson import ../../SampleIntents/Watson/WatsonConversationCarWorkspace.json dataset.json


Generated dataset.json example:
    {
        "intents" : [
            {
                "intent" : "hello",
                "utterances" : [
                    "hello",
                    "good morning"
                ]
            }
        ]
    }
    


# SampleDatasets

This folder contains sample datasets with Intents and sample Utterances from different sources:
- Watson/WatsonConversationCarWorkspace.json in the Watson subfolder is an export of the standard sample Workspace for demoing IBM Watson Conversation service on IBM Cloud.
- PharmacyDataset.json (no need to import)


# WordEmbedding

This folder contains Swift subprojects to import a JSON file containing the Dataset to be used for training the NLC model and produce a word vector based new corpus to be used for training the Deep Neural Network classifier.

## oneHot-NSLinguisticTagger

This oneHot-NSLinguisticTagger WordEmbedding project use Apple Foundation NSLinguisticTagger APIs to analyze and tokenize the text in the sample utterances creating a flat word embeddeing vector. In particular it output a One-Hot Encoding for Stem words and a Corpus of documents and a Class of entities to be used for both training the data and prepare the model as well as for inferencing the model.

This project contains Swift code to be executed on a macOS or iOS environment (NSLinguisticTagger APIs are not based on Linux/cross platorm version of Apple Foundation) to import a JSON file containing the Dataset to be used for training the NLC model. 

Usage example:

    oneHot-NSLinguisticTagger import ../../SampleDatasets/PharmacyDataset.json 
    

This command produce the following files on the current folder: bagOfWords.json, lemmatizedDataset.json and intents.json


## fastText

This fastText WordEmbedding project use Facebook open source fastText Library to analyze and tokenize the text using Word2Vec skipgram word embedding vectors. In particular it use a Swift wrapper to the fastText C++ Library  (https://github.com/JacopoMangiavacchi/SwiftFastText) to generate sentence vectors for each utterances from the input dataset.

In order to learn word vectors a fast text model must be trained using the following fasttext command line:

    $ fastText skipgram -input data.txt -output model

I used the Wikipedia pre-trained word vectors that can be downloaded below:
    
    https://s3-us-west-1.amazonaws.com/fasttext-vectors/wiki-news-300d-1M.vec.zip : 1 million word vectors trained on Wikipedia 2017, UMBC webbase corpus and statmt.org news dataset (16B tokens)


If you are new to fastText please refer to the tutoria at https://fasttext.cc for how to install and use fastText command line to generate a model.

For simplicity you can find the generated fastText model I'm using in my test in the fastText-Models main subfolder (../../fastText-Models/wikimodel.bin)


The fastText project contains Swift code to be executed on Linux or macOS environments to import a JSON file containing the fastText vectorized Dataset to be used for training the NLC model. 

Build with C++11 extension support:

    swift build -Xcxx -std=c++11


Usage example:
    
    fastText import ../../SampleDatasets/PharmacyDataset.json ../../fastText-Models/wikimodel.bin


This command produce the following files on the current folder: vectorizedDataset.json and intents.json


## GloVe

This GloVe WordEmbedding project use Stanford open source GloVe Library to analyze and tokenize the text using Word2Vec skipgram word embedding vectors. 

WORK IN PROGRESS (directly in the iPython notebook)




# ModelNotebooks

This folder contains the Python Jupyter Notebooks to create using Keras API and TensorFlow as backend the Deep Neural Network Classifiers for intent recognitions.  The Keras/TensorFlow models are exported to CoreML using the Apple CoreMLTools python library.

- createModelWithNLTKEmbedding: a sample fully connected deep network classifier using a NLTK based one-hot encoding
- createModelWithNSLinguisticTaggerEmbedding: a fully connected network classifier using a NSLinguisticTagger one-hot encoding
- createModelWithFastTextEmbedding: a bidirectional RNN with Attetion classifier using a FastText for word2vec vector encoding

Step by step instruction to create the ML model using Keras/TensorFlow and export it on CoreML using CoreMLConversionTool 

## Download and Install Anaconda Python:
    https://www.continuum.io/downloads


## Create the Keras, TensorFlow, Python, CoreML environment:
    conda env create

This environment is created based on the environment.yml file for iinstalling Python 2.7, TensorFlow 1.6, Keras 2.1.5, CoreMLTools 0.8, Pandas and other Python usefull packages:


    name: SwiftNLC
    channels:
    - !!python/unicode
        'defaults'
    dependencies:
    - python=2.7
    - pip==9.0.1
    - numpy==1.12.0
    - jupyter==1.0
    - matplotlib==2.0.0
    - scikit-learn==0.18.1
    - scipy==0.19.0
    - pandas==0.19.2
    - pillow==4.0.0
    - seaborn==0.7.1
    - h5py==2.7.0
    - pip:
        - tensorflow==1.6.0
        - keras==2.1.5
        - coremltools==0.8
        - nltk==3.2.5




## Activate the environment (Mac/Linux):
    source activate SwiftNLC

## Check that your prompt changed to:
    (SwiftNLC) $

## Launch Jupyter Notebook:
    jupyter notebook

## Open your browser to:
    http://localhost:8888


To create a basic Model with Keras/TensorFlow and export it with CoreMLTools just open createModelWithNSLinguisticTaggerEmbedding.ipynb in your Jupyter browsing session and execute any cells in order to create, save and export the Keras Model using CoreML Exporting Tools

The Basic CoreML Model will be saved in the current folder.


## NSLinguisticTagger one-hot embedding Fully Connected Network Model creation abstract

    from keras.models import Sequential
    from keras.layers import Dense
    from keras.optimizers import Adam

    model = Sequential()
    model.add(Dense(50, input_dim=len(train_x[0]), activation='relu'))
    model.add(Dense(8, activation='relu'))
    model.add(Dense(len(train_y[0]), activation='softmax'))
    

## fastText word2vec vector embedding RNN Model creation abstract

    from keras.models import Sequential, Model
    from keras.layers import Dense, Input, Bidirectional, LSTM, GRU, TimeDistributed, Activation, Flatten, Embedding
    from keras.optimizers import Adam

    model = Sequential([
                    GRU(len(train_x[0]), batch_size=1, input_shape=(None, len(train_x[0])), return_sequences=True),
                    TimeDistributed(Dense(64)),
                    Activation('relu'),
                    TimeDistributed(Dense(32)),
                    Activation('relu'),
                    TimeDistributed(Dense(len(train_y[0]))),
                    Activation('softmax'),
                   ])



## GloVe word2vec vector embedding CNN Model creation abstract



# Wrapper




# SwiftNLCTestClient



