---
title: "README.md"
output: html_document
---

## Dataset
Human Activity Recognition dataset made available by UCI 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#### Source
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws 

## Transformation
By running the script, 

```{r}
source("run_analysis.R")
```

the 66-feature vector (acceleromete and gyroscope 3-axial) of 30 subjects in the train group and the test group will be aggregated. The average of each value in the 66-feature vector will be taken for each subject over 6 different activities: walking, walking upstairs, walking downstairs, sitting, standing, and laying.

The code aggregates the test subjects' observations into one data frame and combines it with an aggregate of the train subjects' observations. From these data frames, only the mean and standard deviation vectors are kept (66 of 561). After creating a merged data frame of both the train and test subjects, the data frame is melted to create a long data set. The `dcast` function is used on this melted dataset to calculate the mean of each of the 66 features.

## Output data
The script outputs a text file called tidy.txt which displays 68 columns:

* The subject [range 1-30]
* The activity [walking, walking upstairs, walking downstairs, sitting, standing, laying]
* mean of each of the 66-feature vector