# fastText

Import dataset.json and generate three json files on the current folder: vectorizedDataset.json and intents.json

Build with C++11 extension support:

    swift build -Xcxx -std=c++11


Usage: 

    ./.build/x86_64-apple-macosx10.10/debug/fastText import ../../SampleDatasets/PharmacyDataset.json ../../fastText-Models/wikimodel.bin


