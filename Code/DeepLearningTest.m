load("Model 1 network.mat","trainedNetwork_1")
%Initialize----------
TruePositive=0; 
FalseNegative=0;
TrueNegative =0;
FalsePositive=0;
%-----------CONFUSION MATRIX-------------
%% WITH FEED %%
for n = 1:63
img =sprintf("F:\\!Computer Vision\\Project\\code\\Sample images\\TestImages\\Finished Binary\\%d.jpg",n);
img = imread(img);
img = imresize(img,[224,224],'Method','bilinear');
results = predict(trainedNetwork_1,img); 
if results(2)>.95 
    TruePositive = TruePositive+1;
elseif results(2)<.95
    FalseNegative= FalseNegative+1;
end 
end 

%% WITHout FEED %%
for m = 1:9
img =sprintf("F:\\!Computer Vision\\Project\\code\\Sample images\\TestImages\\No Feed\\%d.jpg",m);    
img = imread(img);
img = imresize(img,[224,224],'Method','bilinear');
results2 = predict(trainedNetwork_1,img); 
if results2(2)<.95 
    TrueNegative = TrueNegative+1;
elseif results2(2)>.95
    FalsePositive= FalsePositive+1;
end 
end 
%-----------------CALCULATIONS--------------------------------
TruePositiveRate = TruePositive/(FalseNegative+TruePositive);
TrueNegativeRate = TrueNegative/(FalsePositive+TrueNegative);
FalsePositiveRate = FalsePositive / (TrueNegative + FalsePositive);
Accuracy= (TruePositive+TrueNegative)/(m+n);
Precision=TruePositive/(TruePositive+FalsePositive);
Recall = TruePositive/(TruePositive+FalseNegative);
F1score= 2 * ((1/Precision)+(1/Recall))^-1;
numsam=(TruePositive+FalseNegative+TrueNegative+FalsePositive);
%--------RESULTS IN NICE FORMAT-------------------------------
sprintf("#sample = %d  |   Accuracy =%.3f , Precision=%.3f , Recall=%.3f , F1score=%.3f ",numsam,Accuracy,Precision,Recall,F1score)