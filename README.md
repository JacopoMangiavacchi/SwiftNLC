# SwiftNLC
Swift Natural Language Classifier with CoreML / TensorFlow

A Natural Language Classifier (NLC) capable to run offline on iOS/watchOS/tvOS devices for understanding Intents from text utterances


# Folders / Projects

- Importer: Swift macOS console app to import Intents and Utterances from different formats
- SampleDatasets: json files containing Intents definitions and sample Utterances
- Embedder: Swift macOS console app to prepare word embedding using NSLinguisticTagger
- ModelNotebook: Jupyter Notebook for Keras/TensorFlow Classifier and CoreML export
- Storyboard: XCode Storyboard iOS project to play with model
- Wrapper: Swift iOS Library to simplify access to CoreML Classifier model
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


# Embedder

This subproject contains Swift code to be executed on a macOS or iOS environments to import a JSON file containing the Dataset to be used for training the NLC model.  This importer use Apple Foundation NSLinguisticTagger APIs to analyze and tokenize the text in the sample utterances creating a word embedder. In particular it output a One-Hot Encoding for Stem words and a Corpus of documents and a Class of entities to be used for both training the data and prepare the model as well as for inferencing the model.

Usage example:
    Embedder import ../SampleDatasets/PharmacyDataset.json 

This command produce the following files on the current folder: bagOfWords.json, lemmatizedDataset.json and intents.json


# ModelNotebook

Python Jupyter Notebook using Keras API and TensorFlow as backend to create a simple fully connected Deep Network Classifier and CoreMLTools to export the TensorFlow model to CoreML

Step by step instruction to create the ML model using Keras/TensorFlow and export it on CoreML using CoreMLConversionTool 

## Download and Install Anaconda Python:
    https://www.continuum.io/downloads


## Create the Keras, TensorFlow, Python, CoreML environment:
    conda env create

This environment is created based on the environment.yml file for iinstalling Python 2.7, TensorFlow 1.1, Keras 2.0.4, CoreMLTools 0.6.3, Pandas and other Python usefull packages:


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


NB NLTK is only needed for the createModelWithNLTKEmbedding initial test Notebook


## Activate the environment (Mac/Linux):
    source activate SwiftNLC

## Check that your prompt changed to:
    (SwiftNLC) $

## Launch Jupyter Notebook:
    jupyter notebook

## Open your browser to:
    http://localhost:8888


To create a basic Model with Keras/TensorFlow and export it with CoreMLTools just open createModelWithNLTKEmbedding.ipynb in your Jupyter browsing session and execute any cells in order to create, save and export the Keras Model using CoreML Exporting Tools


The Basic CoreML Model will be saved in the current folder 





# Storyboard


# Wrapper


# SwiftNLCTestClient



