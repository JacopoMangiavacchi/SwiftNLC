# Embedder

Import dataset.json and generate three file on the current folder:

    - encoding.bin: One-Hot Encoding for Stem words
    - corpus.bin: a Corpus of documents and 
    - entity.bin: a Class of entities

Build: 
    swift build


Usage: 
    ./.build/x86_64-apple-macosx10.10/debug/Embedder import ../SampleDatasets/PharmacyDataset.json 


This command produce the following files on the current folder: bagOfWords.json, lemmatizedDataset.json and intents.json