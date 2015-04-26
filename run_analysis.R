# This script assumes the UCI HAR Dataset folder is in the working directory

# read the activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# read the features but only the relevant column
features <- read.table("UCI HAR Dataset/features.txt")
all_features <- features$V2

# find features with mean() and std() because we only care about those
mean_features <- grep("mean()", all_features, fixed = TRUE)
std_features <- grep("std()", all_features, fixed = TRUE)
columns <- sort(append(mean_features,std_features))

# read test files and merge into one data frame
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = all_features)
variables_test <- X_test[,columns]
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activity"))
test_df <- cbind(subject_test, y_test, variables_test)

# read train files and merge into one data frame
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = all_features)
variables_train <- X_train[,columns]
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activity"))
train_df <- cbind(subject_train, y_train, variables_train)

# put the train and test data frames together
all_df <- rbind(test_df,train_df)

# factorize the activity and subject columns
all_df$subject <- factor(all_df$subject)
all_df$activity <- factor(all_df$activity)

# replace activity numbers with descriptions
levels(all_df$activity) <- activity_labels$V2

# melt data
melted <- melt(all_df, id = c("subject", "activity"), measure.vars = names(all_df[,3:68]))

# dcast the shit out of it to create the "tidy data"
tidy <- dcast(melted, subject + activity ~ variable, mean)
write.table(tidy, file = "tidy.txt", row.name=FALSE)