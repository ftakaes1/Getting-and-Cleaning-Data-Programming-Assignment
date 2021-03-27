Functions

# Functions:

## run_analysis.R
run_analysis.R takes a dataset's URL and returns a tidy dataset containing the average of each subject's measurements. The function assumes the dataset is in zipped file and extracts only the necessary data without unzipping the entire file into the user's directory. The functions works as follows:

**0. Loading necessary libaries.**

run_analysis.R loads three tidyverse packages: **tidyr, readr, dplyr.** If the user does not have these packages, the function will terminate and give an error. To prevent this, the user must install the tidyverse package (or each of the above packages individually)  

**1. Creating new R objects to anticipate large memory usage.**

Because the dataset given to us is large, the function prevents unnecessary memory usage by preemptively creating data.frame and tibble objects.

**2. Extracting data from the dataset**
First, the function reads all the file names inside the zipped dataset using the `unzip()` function and assigns it to the `fileName` variable. We continue to use the `unzip()` function, but this time on the `fileName` variable, to extract only the necessary data into our working environment. Each file is assigned to a variable using the template:
```
variableName <- read_table(unz("DatasetFileName.zip", fileName[[DataIndex]]))
```

**3. Tidying the dataset**
The `test` and `train` variables contain all the data for the test files and train files, respectively. run-analysis.R merges both files into the `data` variable where it then undergoes a series of tidying functions. In the end, `data` should contain only the dataset's mean and standard deviation measurements. 

**4. Creating the independent dataset**
We, then, filter the `data` object to only contain the mean measurements. Finally, we use the `group_by` and `summarize` functions to create a tidy set called `final` that houses the mean measurements of all subject's activities. 