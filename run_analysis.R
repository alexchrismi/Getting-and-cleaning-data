library(dplyr)

##################################################
###                                            ###
### STEP 1: Downloading and unzipping the data ###
###                                            ###
##################################################

if (!file.exists("data")) {
        dir.create("data")
}

if (!file.exists("./data/dataset.zip")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download(fileUrl, dest="./data/dataset.zip", mode="wb") 
}

unzip(zipfile="./data/dataset.zip", exdir="./data")

##################################################
###                                            ###
### STEP 2: Merging the training and test data ###
###                                            ###
##################################################

tmp <- lapply(paste("./data/UCI HAR Dataset/test/", list.files("./data/UCI HAR Dataset/test", pattern = ".txt"), sep = ""), function(x){read.table(x)})
names(tmp) <- gsub(".txt", "", list.files("./data/UCI HAR Dataset/test", pattern = ".txt"))
list2env(tmp,envir=.GlobalEnv)

tmp <- lapply(paste("./data/UCI HAR Dataset/train/", list.files("./data/UCI HAR Dataset/train", pattern = ".txt"), sep = ""), function(x){read.table(x)})
names(tmp) <- gsub(".txt", "", list.files("./data/UCI HAR Dataset/train", pattern = ".txt"))
list2env(tmp,envir=.GlobalEnv)

remove(tmp)
colnames(subject_test) <- "subject_id"; colnames(subject_train) <- "subject_id"; colnames(y_test) <- "activity"; colnames(y_train) <- "activity"

dta <- rbind(cbind(subject_test, X_test, acticity = y_test), cbind(subject_train, X_train, activity = y_train))
remove(subject_test, X_test, y_test, subject_train, X_train, y_train)

##################################################
###                                            ###
### STEP 3: Relabel activities in the data set ###
###                                            ###
##################################################

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity", "activity_label")
dta <- merge(dta, activity_labels)[-1]
remove(activity_labels)

##################################################
###                                            ###
### STEP 4: Relabel variable names in data set ###
###                                            ###
##################################################

features <- read.table("./data/UCI HAR Dataset/features.txt") # dimensions: 561 rows, 2 columns
colnames(dta) <- rbind("subject_id", cbind(as.character(features[[2]])), "activity")
remove(features)

##################################################
###                                            ###
### STEP 5: Extract only the relevant measures ###
###                                            ###
##################################################

dta <- dta[,  grep(c("subject_id|mean()|std()|activity"), names(dta))]

##################################################
###                                            ###
### STEP 6: Creating the second tidy data set  ###
###                                            ###
##################################################

dta_mean <- summarise_all(group_by(dta, subject_id, activity), mean)
write.table(dta_mean, "tidy_data.txt", row.name = FALSE)