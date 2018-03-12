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

