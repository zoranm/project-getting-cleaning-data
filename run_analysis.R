
#part 1
# working directory containing UCI Har dataset
setwd("/Users/zoki/datasciencecoursera/datacleaining/Project/Sandbox")

# read in features and activity type - apply to training and test datasets 
features = read.table("../UCI Har Dataset/features.txt",header=FALSE) 
features [,2]
activityType = read.table("../UCI Har Dataset/activity_labels.txt",header=FALSE)

# read in train datasets
xTrainSet <- read.table("../UCI Har Dataset/train/X_train.txt", header = FALSE)
yTrainSet <- read.table("../UCI Har Dataset/train/y_train.txt", header = FALSE)
subjectTrainSet <- read.table("../UCI Har Dataset/train/subject_train.txt", header = FALSE)

# Add column names to the data read in
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrainSet)  = "subjectId";
colnames(xTrainSet)        = features[,2]; 
colnames(yTrainSet)        = "activityId";

# combine training datasets 
trainingData = cbind(yTrainSet,subjectTrainSet,xTrainSet);

# read in test datasets
xTestSet <- read.table("../UCI Har Dataset/test/X_test.txt", header = FALSE)
yTestSet <- read.table("../UCI Har Dataset/test/y_test.txt", header = FALSE)
subjectTestSet <- read.table("../UCI Har Dataset/test/subject_test.txt", header = FALSE)

# Assign column names to the test data imported above
colnames(subjectTestSet) = "subjectId";
colnames(xTestSet)       = features[,2]; 
colnames(yTestSet)       = "activityId";

# combine test datasets
testData = cbind(yTestSet,subjectTestSet,xTestSet);
 
# Merge training and test data to create merged data set
mergedData = rbind(trainingData,testData);

# create a column name vecror

colNames = colnames(mergedData); 

#part 2
#Define a logical vector of required variables using grepl functionb
requiredVariables = 
    (grepl("activity..",colNames) | 
         grepl("subject..",colNames) | 
         grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | 
         grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset of the merged table including only requiredVariables as requested
requiredData = mergedData[requiredVariables==TRUE];

#part 3

# Merge the requiredData set with the acitivityType table to include descriptive activity names
requiredDataDescriptiveNames = merge(requiredData,activityType,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(requiredDataDescriptiveNames); 

#part 4

# Appropriately label the data set with descriptive activity names. 

# Gradually replace abbreviated names with descriptive variable names

for (i in 1:length(colNames)) 
{
    colNames[i] = gsub("\\()","",colNames[i])
    colNames[i] = gsub("-std$","StdDev",colNames[i])
    colNames[i] = gsub("-mean","Mean",colNames[i])
    colNames[i] = gsub("^(t)","time",colNames[i])
    colNames[i] = gsub("^(f)","freq",colNames[i])
    colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
    colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
    colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
    colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# renaming column names with descriptive names
colnames(requiredDataDescriptiveNames) <- colNames

#part 5

#create the second data set less the activityType column which was added earlier  
secondDataSet = requiredDataDescriptiveNames[,names(requiredDataDescriptiveNames) != 'activityType'];

#create tidyData set as required with the average of each variable for each activity and each subject.
tidyDataSet = aggregate(secondDataSet[,names(secondDataSet) != c('activityId','subjectId')],
     by=list(activityId=secondDataSet$activityId,subjectId = secondDataSet$subjectId),mean);

# Merge the tidyDataSet with activityType to include descriptive activity names
tidyDataSet  = merge(tidyDataSet,activityType,by='activityId',all.x=TRUE);
tidyDataSet

# Finally, create a new file
write.table(tidyDataSet, './tidyDataSet.txt',row.names=TRUE,sep='\t');

