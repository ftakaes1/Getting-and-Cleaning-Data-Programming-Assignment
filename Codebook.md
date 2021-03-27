Codebook

# run_analysis.R Codebook

## `actlabels`

The `actlabel` variable contains all the activity labels that are paired with their respective number. 

## `data`

The `data` variable is the final variable that houses the tidy dataset containing the mean and standard deviation measurements. 

## `features`

The `features` variable has all the features labeled in the `features.txt` file. It is used as a reference to organize the columns of the `train` and `test` variables. 

## `fileName`

The `fileName` variable contains all the file names in the zipped dataset. This variable is used as a reference point to extract only the necessary files without unzipping the file.

## `final`

The `final` variable contains the last, tidy dataset that neatly organizes the mean of each subject's activity measurements.

## `test`

The `test` variable contains the correctly labeled but untidy dataset of the test group subjects.

## `testdata`

The `testdata` variable contains the column-labeled data from the `testx.txt` file.

## `testy`

The `testy` variable contains the subjects of the test group.

## `train`

The `train` variable contains the correctly labeled but untidy dataset of the train group subjects.

## `traindata`

The `traindata` variable contains the column-labeled data from the `trainx.txt` file.

## `trainy`

The `trainy` variable contains the subjects of the train group.