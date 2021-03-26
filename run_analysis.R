#run_analysis:
#run_analysis takes the zipped dataset's URL as its sole argument and tidies
#the necessary data. The function will create a directory to tidy the data.
run_analysis <- function(fileURL){
     
     #########################################################################
     # 0 - Loading necessary libraries
     #########################################################################
     library(tidyr)
     library(readr)
     library(dplyr)
     library(purrr)
     #########################################################################
     # 1 - Creating new R objects to anticipate large memory usage. 
     #########################################################################
     fileName <- data.frame()
     test <- tibble()
     train <- tibble()
     data <- tibble()
     final <- tibble()
     #########################################################################
     # 2 - Start of the code. 
     #########################################################################
     #Here, we are downloading the zip file, and extracting the necessary
     #data without unzipping its contents. We are also combining the subject 
     #identification with their respective measurements.The col_names function
     #is used to assign feature names to each variable of the training and test 
     #dataset. 
     download.file(fileURL, paste0(getwd(), "/quiz.zip"))
     fileName <- unzip("quiz.zip", list=TRUE)$Name
     features <- read.table(unz("quiz.zip", fileName[[2]])) %>%
                 select(V2)
     actlabels <- read.table(unz("quiz.zip", fileName[[1]]))
     testy <- read_table(unz("quiz.zip", fileName[[18]]), col_names= "activity")
     trainy <- read_table(unz("quiz.zip", fileName[[32]]), col_names= "activity")
     testdata <- read_table(unz("quiz.zip", fileName[[17]]), col_names= features[[1:length(features)]])
     traindata <- read_table(unz("quiz.zip", fileName[[31]]), col_names= features[[1:length(features)]])
     test <- read_table(unz("quiz.zip", fileName[[16]]), col_names="subject") %>%
             bind_cols(testdata,testy)
     train <- read_table(unz("quiz.zip", fileName[[30]]), col_names="subject") %>%
             bind_cols(traindata,trainy)
     data <- bind_rows(test,train)
     #Removing unnecessary objects to prevent memory clog
     rm(list = c("features","testy","trainy","testdata","traindata", "test", "train"))
     #Merging of both the test and train data to make it easier for downstream
     #data tidying. Also arranging data through the subject column. 
     data <- select(data, contains(c("subject", "mean","std","activity")) & !matches("angle")) %>%
             arrange(subject) %>%
             gather("feature_stat_axis","value",-c("subject","activity")) %>%
             separate("feature_stat_axis",c("feature","statmethod", "axis"), sep = "-") %>%
             separate_rows(axis, sep=",") %>%
             mutate(activity = recode(
                     activity,
                     `1` = actlabels[[2]][[1]],
                     `2` = actlabels[[2]][[2]],
                     `3` = actlabels[[2]][[3]],
                     `4` = actlabels[[2]][[4]],
                     `5` = actlabels[[2]][[5]],
                     `6` = actlabels[[2]][[6]]
             ))
     rm(actlabels)
     #Creation of second dataset that has the average for each variable and each
     #subject. Each subject has its own row.
     final <-filter(data, statmethod == "mean()") %>%
             select(-(statmethod:axis)) %>%
             group_by(subject,activity,feature) %>%
             summarize(average = mean(value))
     #Cleaning up global environment and returning the final tidy, dataset.
     rm(data)
     return(final)
}