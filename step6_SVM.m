y_train = [1*ones(36,1);-1*ones(29,1)];
X_train=TFFC660Features(:,1:660);

X_trainT=X_train([1:65],:);
numFeatures = size(X_trainT, 2);
numClasses = 2;
k = 65; % 指定 fold 数量 
nf=[20];
ACCresultAD_HC=zeros(100,1);
for rt=1%:10
    % y_train = shuffle(y_train);   %for permutation test
correlationScores = zeros(numFeatures, 1);
for i = 1:numFeatures
    correlationScores(i) = abs(corr(X_trainT(:,i), y_train));
end
 
[~, featureIndices] = sort(correlationScores, 'descend'); 
selectedFeatures = featureIndices(1:nf);%%

X_train=X_trainT(:,selectedFeatures);

accuracyAll=[];
N = length(y_train); % 训练样本数
indices = zeros(N, 1);
        cI=0;gammaI=0;    
for C=[2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10,2^11,2^12,2^13,2^14,2^15,2^16,2^17,2^18,2^19,748576,948576,2^20,1148576,1348576,2^21,2^22,2^23,2^24,2^25,2^26]
     cI=cI+1;
     gammaI=0;
    for gamma=[0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.3,2,4,6,8,2^4,2^5,2^6,2^7,2^8,2^9,2^10,2^11,2^12,2^13,2^14,2^15]  
    gammaI=gammaI+1;
    cv = cvpartition(size(X_train, 1),'KFold',k);
    indices = crossvalind('Kfold', size(X_train, 1), k);
    for j = 1:k

    test = (indices == j); train = ~test;
    model = fitcsvm(X_train(train,:), y_train(train,:), ...
    'KernelFunction', 'rbf', ...
    'BoxConstraint', C, ...
    'KernelScale', gamma); 

    [predictedLabels, scores] = predict(model, X_train(test,:));

    predictedClassT(j) = predictedLabels;


    actualClass(j)=y_train(test,:);
        % Calculate recall, precision, F1 and specificity
    end
    predictedClass=predictedClassT;
        TP = sum((predictedClass == 1) & (actualClass == 1));
        FP = sum((predictedClass == 1) & (actualClass ~= 1));
        FN = sum((predictedClass ~= 1) & (actualClass == 1));
        TN = sum((predictedClass ~= 1) & (actualClass ~= 1));
        
        accuracy = (TP+TN) / (TP + TN + FP + FN);
        % recall = TP / (TP + FN + eps);
        % precision = TP / (TP + FP + eps);
        % specificity = TN / (TN + FP + eps);
            

    % ConfusionMatrix(cI,gammaI,:) = [TP',FP',FN',TN'];
    accuracyAll(cI,gammaI)=mean(accuracy);
    % precisionAll(cI,gammaI,:)=precision;
    % recallAll(cI,gammaI,:)=recall;
    % specificityAll(cI,gammaI,:)=specificity; 

    end           
end

ACCn=max(max(accuracyAll))
% [max_val, linear_idx] = max(accuracyAll(:));  % 获取线性索引
% [row, col] = ind2sub(size(accuracyAll), linear_idx);  % 将线性索引转换为行和列
ACCresultAD_HC(rt)=ACCn;
% recallAll(row, col);
% specificityAll(row, col);
% squeeze(ConfusionMatrix(row, col,:,:))
end