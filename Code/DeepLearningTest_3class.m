load("Model 2 network (2).mat","trainedNetwork_1")
%----------INITIALIZE--------------------
TruePositive=0; 
FalseNegative=0;
TrueNegative =0;
FalsePositive=0;
%------------------------------CONFUSION MATRIX--------------------------------------
%% Testing for
for classtest=1:3
    for g= 1:3 
        if g==classtest
            for n = 1:29
            img =sprintf("F:\\!Computer Vision\\Project\\code\\Sample images\\TestImages\\Class %d\\%d.jpg",classtest,n);
            img = imread(img);
            img = imresize(img,[224,224],'Method','bilinear');
            results = predict(trainedNetwork_1,img);
                if results(classtest)==max(results); 
                    TruePositive = TruePositive+1;
                elseif results(classtest)~=max(results)
                    FalseNegative= FalseNegative+1;
                end 
            end
        else
        end


    %% Testing Against
      if g~=classtest
            for m = 1:29
            img =sprintf("F:\\!Computer Vision\\Project\\code\\Sample images\\TestImages\\Class %d\\%d.jpg",g,m);   
            img = imread(img);
            img = imresize(img,[224,224],'Method','bilinear');
            results2 = predict(trainedNetwork_1,img);
                if results2(classtest)~=max(results2)  
                    TrueNegative = TrueNegative+1;
                elseif results2(classtest)==max(results2) 
                    FalsePositive= FalsePositive+1;
                end  
            end
      else
        end 
    end
end 
%---------------------------CALCULATIONS-----------------------
TruePositiveRate = TruePositive/(FalseNegative+TruePositive);
TrueNegativeRate = TrueNegative/(FalsePositive+TrueNegative);
FalsePositiveRate = FalsePositive / (TrueNegative + FalsePositive);
Accuracy= (TruePositive+TrueNegative)/(TruePositive+FalseNegative+TrueNegative+FalsePositive);
Precision=TruePositive/(TruePositive+FalsePositive);
Recall = TruePositive/(TruePositive+FalseNegative);
F1score= 2 * ((1/Precision)+(1/Recall))^-1;
numsam=(TruePositive+FalseNegative+TrueNegative+FalsePositive);
%--------RESULTS IN NICE FORMAT-------------------------------
sprintf("#sample = %d  |   Accuracy =%.3f , Precision=%.3f , Recall=%.3f , F1score=%.3f ",numsam,Accuracy,Precision,Recall,F1score)