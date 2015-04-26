library("plyr")
library("dplyr")

#Load files to R
subjecttest<- read.table("UCI HAR Dataset/test/subject_test.txt")
Xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
Ytest<-read.table("UCI HAR Dataset/test/Y_test.txt")
subjecttrain<- read.table("UCI HAR Dataset/train/subject_train.txt")
Xtrain<- read.table("UCI HAR Dataset/train/X_train.txt")
Ytrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
features<- read.table("UCI HAR Dataset/features.txt")
activitieslabel <-read.table("UCI HAR Dataset/activity_labels.txt")

#String manipulations to rename columns names different from R functions
features[,2]<-as.character(features[,2])
features[,2]<-gsub("mean\\()","mn",features[,2])
features[,2]<-gsub("std\\()","Standard deviation",features[,2])
features[,2]<-gsub("-","",features[,2])

#Name columns of datasets
colnames(Xtrain)<-features[,2]
colnames(Xtest)<-features[,2]
colnames(activitieslabel)<-c("Rw#","Activity")

#String manipulation to make activities readable
activitieslabel[,2]<-as.character(activitieslabel[,2])
activitieslabel[,2]<-gsub("_"," ",activitieslabel[,2])

#Assign descriptive activity names to the activities in the data set
for (i in 1:7352){
  if (Ytrain[i,1] == "1"){
    Ytrain[i,1] <- activitieslabel[1,2]
      }
  if (Ytrain[i,1] == "2"){
    Ytrain[i,1] <- activitieslabel[2,2]
  }
  if (Ytrain[i,1] == "3"){
    Ytrain[i,1] <- activitieslabel[3,2]
  }
  if (Ytrain[i,1] == "4"){
    Ytrain[i,1] <- activitieslabel[4,2]
  }
  if (Ytrain[i,1] == "5"){
    Ytrain[i,1] <- activitieslabel[5,2]
  }
  if (Ytrain[i,1] == "6"){
    Ytrain[i,1] <- activitieslabel[6,2]
  }
}

for (i in 1:2947){
  if (Ytest[i,1] == "1"){
    Ytest[i,1] <- activitieslabel[1,2]
  }
  if (Ytest[i,1] == "2"){
    Ytest[i,1] <- activitieslabel[2,2]
  }
  if (Ytest[i,1] == "3"){
    Ytest[i,1] <- activitieslabel[3,2]
  }
  if (Ytest[i,1] == "4"){
    Ytest[i,1] <- activitieslabel[4,2]
  }
  if (Ytest[i,1] == "5"){
    Ytest[i,1] <- activitieslabel[5,2]
  }
  if (Ytest[i,1] == "6"){
    Ytest[i,1] <- activitieslabel[6,2]
  }
}

#Assign column names
colnames(subjecttest)<-"Subject"
colnames(subjecttrain)<-"Subject"

#Add column for Activites. Add column for subjects. Complete requirement #3
subjecttrain4<-cbind(Xtrain,Ytrain,subjecttrain)
subjecttest4<-cbind(Xtest,Ytest,subjecttest)

#Merge together all datasets, complete requirement #1
total<-rbind(subjecttrain4,subjecttest4)

#Create unique column names in order to later use select function
for (i in 1:561){
  features[i,2] <-paste0(features[i,2],"_",i)
}
colnames(total)<-features[,2]
colnames(total)[562]<-"Activity"
colnames(total)[563]<-"Subject"

#Retain only the measurements fn the mean and standard deviation
#Complete requirement 2
total2<-select(total,Subject, Activity, contains("mn"), contains("Standard deviation"))

#Appropriately labels the data set with descriptive variable names
#Complete requirement 4
#Apologizes, used brute force
temp<-colnames(total2)
temp<-gsub("_","",substr(temp,1,gregexpr(pattern ='_',temp)))
temp[1]<-"Subject"
temp[2]<-"Activity"
temp<-gsub("tB","t.B",temp)
temp<-gsub("tG","t.G",temp)
temp<-gsub("fB","f.B",temp)
temp<-gsub("BodyAcc","Body    .Acc",temp)
temp<-gsub("BodyAcc","Body    .Acc",temp)
temp<-gsub("BodyGyro","Body    .Gyro",temp)
temp<-gsub("GravityAcc","Gravity .Acc",temp)
temp<-gsub("AccJerk","Acc .Jerk",temp)
temp<-gsub("AccStandard","Acc ..Standard",temp)
temp<-gsub("AccMag","Acc .Mag",temp)
temp<-gsub("Accmn","Acc .       .Mn",temp)
temp<-gsub("GyroMag","Gyro.Mag",temp)
temp<-gsub("GyroStandard","Gyro.    .Standard",temp)
temp<-gsub("GyroJerk","Gyro.Jerk",temp)
temp<-gsub("Gyromn","Gyro.       .Mn",temp)
temp<-gsub("JerkStand","Jerk   .Stand",temp)
temp<-gsub("Jerkmn","Jerk   .Mn",temp)
temp<-gsub("JerkMagmn","JerkMag.Mn",temp)
temp<-gsub("Standard deviation","Standev",temp)
temp<-gsub("Magmn","Mag    .Mn. ",temp)
temp<-gsub("MagStandev","Mag    .Standev. ",temp)
temp<-gsub("MnX","Mn     .X",temp)
temp<-gsub("MnY","Mn     .Y",temp)
temp<-gsub("MnZ","Mn     .Z",temp)
temp<-gsub("StandevX","Standev.X",temp)
temp<-gsub("StandevY","Standev.Y",temp)
temp<-gsub("StandevZ","Standev.Z",temp)
colnames(total2)<-temp

#A second, independent tidy data set with the average 
# of each variable for each activity and each subject
tidy<-ddply(total2,.(Subject, Activity),numcolwise(mean))

#Creating a row for each observation, another set of column names
#and transformations
finish<-data.frame(matrix(ncol=9,nrow=0))
colnames(finish)<-c("Subject", "Activity", "Domain.Signal", "Body/Gravity", "Signal.Source", "Jerk/Mag", "Direction", "Mean.of.Mean.Value", "Mean.of.Standard.Deviation")

k<-1
t<-1

for (i in 1:180){

  for (r in (3:35)){
    if (r<33){
    finish[k,t]<- tidy[i,1]
    t <- t + 1
    finish[k,t]<- tidy[i,2]
    t<-t + 1
    temp<-colnames(tidy[r])
    finish[k,t]<-substr(temp,1,1)
    t <- t + 1
    finish[k,t]<-substr(temp,3,10)
    t <- t + 1
    finish[k,t]<-substr(temp,12,15)
    t<- t +1
    finish[k,t]<-substr(temp,17,23)
    t<- t +1
    finish[k,t]<-substr(temp,33,34)
    t <-t+1
    finish[k,t]<-tidy[i,r]
    t <-t+1
    finish[k,t]<-tidy[i,r+33]
    t <-t+1
    }
    if (r > 32){
      finish[k,t]<- tidy[i,1]
      t <- t + 1
      finish[k,t]<- tidy[i,2]
      t<-t + 1
      temp<-colnames(tidy[r])
      finish[k,t]<-substr(temp,1,1)
      t <- t + 1
      finish[k,t]<-substr(temp,3,10)
      t <- t + 1
      finish[k,t]<-substr(temp,16,19)
      t<- t +1
      finish[k,t]<-substr(temp,21,27)
      t<- t +1
      finish[k,t]<-substr(temp,33,34)
      t <-t+1
      finish[k,t]<-tidy[i,r]
      t <- t+1
      finish[k,t]<-tidy[i,r+33]
      }
     t <- 1
    k <- k+1  
  }
}

#complete requirement #5
write.table(finish, file = "tidy.txt",row.names=FALSE, na="",col.names=TRUE, sep=",")
