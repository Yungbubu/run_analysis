run_anal2 <- function(x) {
        
        ## STEP 0 : Initialize Features names

        features_names <- read.table("UCI HAR Dataset/features.txt")
        
        col_names <-features_names[2]  
        
        col_names <- as.vector(t(col_names))
        
        ## STEP 1 : Merges the training and the test sets to create one data set.
        
        test_x <- read.table("UCI HAR Dataset/Test/X_Test.txt")
        colnames(test_x) <- col_names
        
        train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
        colnames(train_x) <- col_names
        
        merge_x <- rbind(test_x, train_x)
        
        ## STEP 2 : Extracts only the measurements on the mean and standard deviation for each measurement. 
        
        merge_ok <- merge_x[,unique(c(grep("mean", names(merge_x)),grep("std", names(merge_x))))]
        
        to_keep <- unique(c(grep("mean", names(merge_x)),grep("std", names(merge_x))))
        
        to_remove <- grep("meanFreq", names(merge_x))
        
        to_remove_bool <- to_keep %in% to_remove
        
        merge_clean <- merge_ok[!to_remove_bool]
        
        ## STEP 2.5 : Merge the Y and subject together and then merge it with the measurements
        
        test_y <- read.table("UCI HAR Dataset/Test/Y_Test.txt")
        colnames(test_y)[1] <- "Activity"
        
        train_y <- read.table("UCI HAR Dataset/train/Y_train.txt")
        colnames(train_y)[1] <- "Activity"
        
        merge_y <- rbind(test_y, train_y)
        
        test_subject <- read.table("UCI HAR Dataset/Test/subject_test.txt")
        colnames(test_subject)[1] <- "Subject"
        
        train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
        colnames(train_subject)[1] <- "Subject"
        
        merge_subject <- rbind(test_subject, train_subject)
        
        merge_global <- cbind(merge_clean, merge_y, merge_subject)        
     
        # STEP 3 : Uses descriptive activity names to name the activities in the data set
        
        activities_match <- read.table("UCI HAR Dataset/activity_labels.txt")
        
        names(activities_match)[names(activities_match)=="V2"] <- "activity_explicit"
        
        merge_global <- merge(merge_global,activities_match, by.x="Activity",by.y="V1", all=TRUE)        
                      
        # STEP 4 : Appropriately labels the data set with descriptive variable names. 
        
        names(merge_global) <- mapply(gsub, "[()-]","",names(merge_global))
        
        names(merge_global) <- mapply(tolower, names(merge_global))
        
        # STEP 5 : Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        
        library(plyr)
        
        data_summary <-ddply(merge_global, .(activity_explicit, subject),numcolwise(mean))
        
        write.table(data_summary, "data_summary.txt", row.name=FALSE)
        
}




