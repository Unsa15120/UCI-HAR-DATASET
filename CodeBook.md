## CODEBOOK 

The **run_analysis.R** script perform the data preparation and then followed by the **5 steps** required as described in the course assignment definition.

## 1. Downloading and extracting the dataset
* Through url dataset is downloaded and then extracted under the folder called **UCI HAR DATASET**.

## 2. Assigning variables to each data
* **features** <- **features.txt** : File has *561 rows and 2 columns :* The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
* **activities** <- **activity_labels.txt** : File has *6 rows and 2 columns :* List of activities performed when the corresponding measurements were taken and its codes (labels).
* **xTest** <- **test/X_test.txt** : File has *2947 rows and 561 columns :* Contains recorded features test data.
* **yTest** <- **test/y_test.txt** : File has *2947 rows and 1 columns :* Contains test data of activities code labels.
* **subjectTest** <- **test/subject_test.txt** : File has *2947 rows and 1 column :* Contains test data of 9/30 volunteer test subjects being observed.
* **subjectTrain** <- **test/subject_train.txt** : File has *7352 rows and 1 column :* Contains train data of 21/30 volunteer subjects being observed.
* **xTrain** <- **test/X_train.txt** : File has *7352 rows and 561 columns :* Contains recorded features train data.
* **yTrain** <- **test/y_train.txt** : File has *7352 rows and 1 columns :* Contains train data of activities code labels.

## 3.Merging the training and test sets to create 1 dataset
* **xData** contain *10299 rows and 561 columns* Is created by merging **xTrain** and **xTest** using **rbind()** function.
* **yData** contain *10299 rows and 1 columns* Is created by merging **yTrain** and **yTest** using **rbind()** function.
* **subjectData** contain *10299 rows and 1 columns* Is created by merging **subjectTrain** and **subjectTest** using **rbind()** function.
* **mergingData** contain *10299 rows and 563 columns* Is created by merging **subjectData ,** **yData** and **xData** using **cbind()** function.
  
## 4.Extracts only the measurements on the mean and standard deviation for each measurement
* **tidyDataSet** *10299 rows and 88 columns* Is created by subsetting **mergingData,** selecting only columns **subject,code** and the measurements on the **mean** and **standard deviation(std)** for each measurement.

## 5.Uses descriptive activity names to name the activities in the data set
* Entire numbers in **code** column of the **tidyDataSet**
replaced with corresponding activity taken from second column of the  
**activities** variable.

## 6.Appropriately labels the data set with descriptive variable names

* **code** column in **tidyDataSet** renamed into **activities**.
* All **Acc** in column’s name replaced by **Accelerometer**.
* All **Gyro** in column’s name replaced by **Gyroscope**.
* All **BodyBody** in column’s name replaced by **Body**.
* All **Mag** in column’s name replaced by **Magnitude**.
* All start with character **f** in column’s name replaced by **Frequency**.
* All start with character **t** in column’s name replaced by **Time**.

## 7.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
* **finalDataSet** contains *180 rows and 88 columns* is created by sumarizing **tidyDataSet** taking the means of 
each variable for each activity and each subject, 
after groupped by subject and activity.
* Export **finalDataSet** into **FinalData.txt** file.
  