KDD Cup 2013 - Author Paper Identification Challenge
====================================================
Copyright 2013 Naokazu Mizuta

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


This repo contains scripts in R to reproduce n_m's results which came 4th prize in KDD Cup 2013.

To run scripts, you first need to deploy the following raw data set properly in "raw" directory.

    from dataRev2.zip
        Author.csv
        Conference.csv
        Journal.csv
        Paper.csv
        PaperAuthor.csv
        Train.csv
        Valid.csv

    ValidSolution.csv
    Test.csv

You need to run the scripts in the following order. Also you need about 10 GByte of memory.

1. make_valid_mod.R
    creates Valid_mod.csv file from Valid.csv and ValidSolution.csv. The resulting file has the same format as Train.csv.
2. read.R
    read all of raw data including Valid_mod.csv and save RData.
3. preprocess.R
    standardizes Name (and Affiliation).
4. make_train_data.R, make_valid_data.R, make_test_data.R
    These three files make features for train, valid, test respectively and can be run simultaneously. Only make_test_data.R reads raw data (Test.csv) as input data and the other two files load RData.
5. train.R
    run gbm and save the model.
6. submitter.R
    make prediction for test set and create submission file.

util.R
    includes functions and character convert dictionaries to be used. This file is called in init.R.

You can run all scripts by calling run_all.R after you specified "RootDir" in the script.