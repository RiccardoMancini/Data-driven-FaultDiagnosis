function [trainedClassifier, validationAccuracy] = fineTree(trainingData)
% [trainedClassifier, validationAccuracy] = fineTree(trainingData)
% Returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: A table containing the same predictor and response
%       columns as those imported into the app.
%
%s
%  Output:
%      trainedClassifier: A struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: A function to make predictions on new
%       data.
%
%      validationAccuracy: A double representing the validation accuracy as
%       a percentage. In the app, the Models pane displays the validation
%       accuracy for each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   [yfit,scores] = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'PDMP/ClearanceFactor', 'PDMP/CrestFactor', 'PDMP/ImpulseFactor', 'PDMP/Kurtosis', 'PDMP/Mean', 'PDMP/PeakValue', 'PDMP/RMS', 'PDMP/ShapeFactor', 'PDMP/Skewness', 'PDMP/Std', 'PDMP/BandPower', 'PDMP/PeakAmp1', 'PDMP/PeakAmp2', 'PDMP/PeakFreq2', 'PDMP/PeakFreq3', 'PDMP/PeakFreq4', 'PIN/ClearanceFactor', 'PIN/CrestFactor', 'PIN/ImpulseFactor', 'PIN/Kurtosis', 'PIN/Mean', 'PIN/PeakValue', 'PIN/RMS', 'PIN/ShapeFactor', 'PIN/Skewness', 'PIN/Std', 'PIN/BandPower', 'PIN/PeakAmp1', 'PIN/PeakAmp3', 'PIN/PeakAmp4', 'PIN/PeakFreq4', 'PO/ClearanceFactor', 'PO/CrestFactor', 'PO/ImpulseFactor', 'PO/Kurtosis', 'PO/Mean', 'PO/PeakValue', 'PO/RMS', 'PO/ShapeFactor', 'PO/Skewness', 'PO/Std', 'PO/PeakAmp2', 'PO/PeakAmp3', 'PO/PeakAmp4', 'PO/PeakAmp5'};
predictors = inputTable(:, predictorNames);
response = inputTable.Fault;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
classNames = [int32(1); int32(2); int32(3); int32(4); int32(5); int32(6); int32(7); int32(8); int32(9); int32(10); int32(11)];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationTree = fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 100, ...
    'Surrogate', 'off', ...
    'ClassNames', classNames);

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
treePredictFcn = @(x) predict(classificationTree, x);
trainedClassifier.predictFcn = @(x) treePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'PDMP/ClearanceFactor', 'PDMP/CrestFactor', 'PDMP/ImpulseFactor', 'PDMP/Kurtosis', 'PDMP/Mean', 'PDMP/PeakValue', 'PDMP/RMS', 'PDMP/ShapeFactor', 'PDMP/Skewness', 'PDMP/Std', 'PDMP/BandPower', 'PDMP/PeakAmp1', 'PDMP/PeakAmp2', 'PDMP/PeakFreq2', 'PDMP/PeakFreq3', 'PDMP/PeakFreq4', 'PIN/ClearanceFactor', 'PIN/CrestFactor', 'PIN/ImpulseFactor', 'PIN/Kurtosis', 'PIN/Mean', 'PIN/PeakValue', 'PIN/RMS', 'PIN/ShapeFactor', 'PIN/Skewness', 'PIN/Std', 'PIN/BandPower', 'PIN/PeakAmp1', 'PIN/PeakAmp3', 'PIN/PeakAmp4', 'PIN/PeakFreq4', 'PO/ClearanceFactor', 'PO/CrestFactor', 'PO/ImpulseFactor', 'PO/Kurtosis', 'PO/Mean', 'PO/PeakValue', 'PO/RMS', 'PO/ShapeFactor', 'PO/Skewness', 'PO/Std', 'PO/PeakAmp2', 'PO/PeakAmp3', 'PO/PeakAmp4', 'PO/PeakAmp5'};
trainedClassifier.ClassificationTree = classificationTree;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2024a.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  [yfit,scores] = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'PDMP/ClearanceFactor', 'PDMP/CrestFactor', 'PDMP/ImpulseFactor', 'PDMP/Kurtosis', 'PDMP/Mean', 'PDMP/PeakValue', 'PDMP/RMS', 'PDMP/ShapeFactor', 'PDMP/Skewness', 'PDMP/Std', 'PDMP/BandPower', 'PDMP/PeakAmp1', 'PDMP/PeakAmp2', 'PDMP/PeakFreq2', 'PDMP/PeakFreq3', 'PDMP/PeakFreq4', 'PIN/ClearanceFactor', 'PIN/CrestFactor', 'PIN/ImpulseFactor', 'PIN/Kurtosis', 'PIN/Mean', 'PIN/PeakValue', 'PIN/RMS', 'PIN/ShapeFactor', 'PIN/Skewness', 'PIN/Std', 'PIN/BandPower', 'PIN/PeakAmp1', 'PIN/PeakAmp3', 'PIN/PeakAmp4', 'PIN/PeakFreq4', 'PO/ClearanceFactor', 'PO/CrestFactor', 'PO/ImpulseFactor', 'PO/Kurtosis', 'PO/Mean', 'PO/PeakValue', 'PO/RMS', 'PO/ShapeFactor', 'PO/Skewness', 'PO/Std', 'PO/PeakAmp2', 'PO/PeakAmp3', 'PO/PeakAmp4', 'PO/PeakAmp5'};
predictors = inputTable(:, predictorNames);
response = inputTable.Fault;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
classNames = [int32(1); int32(2); int32(3); int32(4); int32(5); int32(6); int32(7); int32(8); int32(9); int32(10); int32(11)];

% Perform stratified cross-validation
cvp = cvpartition(response, 'KFold', 5, 'Stratify', true);  % Create stratified partition
partitionedModel = crossval(trainedClassifier.ClassificationTree, 'CVPartition', cvp); 

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
