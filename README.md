# SwiftNLC
Swift Natural Language Classifier with CoreML / TensorFlow

A Natural Language Classifier (NLC) capable to run offline on iOS/watchOS/tvOS devices for understanding Intents from text utterances


# Folders / Projects

- Importer: Swift macOS console app to import Intents and Utterances from different formats
- SampleIntents: json files containing Intents definitions and sample Utterances
- Embedder: Swift macOS console app to prepare word embedding using NSLinguisticTagger
- ModelNotebook: Jupyter Notebook for Keras/TensorFlow Classifier and CoreML export
- Storyboard: XCode Storyboard iOS project to play with model
- Wrapper: Swift iOS Library to simplify access to CoreML Classifier model
- Client: Test iOS application to play with Wrapper and CoreML model


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


# SampleIntents

WatsonConversationCarWorkspace.json in the Watson subfolder is an export of the standard sample Workspace for demoing IBM Watson Conversation service on IBM Cloud.


# Embedder

This subproject contains Swift code to be executed on a macOS or iOS environments to import a JSON file containing the Dataset to be used for training the NLC model.  This importer use Apple Foundation NSLinguisticTagger APIs to analyze and tokenize the text in the sample utterances creating a word embedder. In particular it output a One-Hot Encoding for Stem words and a Corpus of documents and a Class of entities to be used for both training the data and prepare the model as well as for inferencing the model.



# ModelNotebook

Python Jupyter Notebook using Keras API and TensorFlow as backend to create a simple fully connected Deep Network Classifier and CoreMLTools to export the TensorFlow model to CoreML



# Storyboard


# Wrapper


# Client

