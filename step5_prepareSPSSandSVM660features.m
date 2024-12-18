% Freq={1:4;5:8;9:12;13:25;25:45}; %indexes for each band in bandpass filtering FC data
Freq={1:5;6:9;10:13;14:26;27:46}; %indexes for each band in time frequency FC data
resultALL=[];
for FreqBand = 1:5
FC=squeeze(mean(TFFC_Pearson_05Hz60Hz(:,Freq{FreqBand},:,:),2));
result(:,1:4)=squeeze(FC(:,1,[2,3,5,7]));
result(:,5:7)=squeeze(FC(:,2,[4,6,7]));
result(:,8:9)=squeeze(FC(:,3,[5,7]));
result(:,10:11)=squeeze(FC(:,4,[6,7]));
spss(:,1)=mean(result(:,1:11),2);
% Pearson corr,central
result(:,12:19)=squeeze(FC(:,10,[7,8,9,3,4,15,16,17]));
result(:,20:21)=squeeze(FC(:,7,[8,9]));
result(:,22:23)=squeeze(FC(:,17,[8,9]));
result(:,24:26)=squeeze(FC(:,8,[3,11,15]));
result(:,27:29)=squeeze(FC(:,9,[4,12,16]));
result(:,30:31)=squeeze(FC(:,11,[3,15]));
result(:,32:33)=squeeze(FC(:,12,[4,16]));
spss(:,2)=mean(result(:,12:33),2);
% Pearson corr,Occipital
result(:,34:36)=squeeze(FC(:,15,[13,17,18]));
result(:,37:39)=squeeze(FC(:,16,[14,17,19]));
result(:,40:41)=squeeze(FC(:,17,[18,19]));
result(:,42:43)=squeeze(FC(:,18,[13,19]));
result(:,44)=squeeze(FC(:,19,[14]));
spss(:,3)=mean(result(:,34:44),2);
%


FC=squeeze(mean(TFFC_MI_05Hz60Hz(:,Freq{FreqBand},:,:),2));
resultMI(:,1:4)=squeeze(mean(FC(:,1,[2,3,5,7]),2));
resultMI(:,5:7)=squeeze(FC(:,2,[4,6,7]));
resultMI(:,8:9)=squeeze(FC(:,3,[5,7]));
resultMI(:,10:11)=squeeze(FC(:,4,[6,7]));
spss(:,4)=mean(resultMI(:,1:11),2);
% Pearson corr,central
resultMI(:,12:19)=squeeze(FC(:,10,[7,8,9,3,4,15,16,17]));
resultMI(:,20:21)=squeeze(FC(:,7,[8,9]));
resultMI(:,22:23)=squeeze(FC(:,17,[8,9]));
resultMI(:,24:26)=squeeze(FC(:,8,[3,11,15]));
resultMI(:,27:29)=squeeze(FC(:,9,[4,12,16]));
resultMI(:,30:31)=squeeze(FC(:,11,[3,15]));
resultMI(:,32:33)=squeeze(FC(:,12,[4,16]));
spss(:,5)=mean(resultMI(:,12:33),2);
% Pearson corr,Occipital
resultMI(:,34:36)=squeeze(FC(:,15,[13,17,18]));
resultMI(:,37:39)=squeeze(FC(:,16,[14,17,19]));
resultMI(:,40:41)=squeeze(FC(:,17,[18,19]));
resultMI(:,42:43)=squeeze(FC(:,18,[13,19]));
resultMI(:,44)=squeeze(FC(:,19,[14]));
spss(:,6)=mean(resultMI(:,34:44),2);

%

clc
FC=squeeze(mean(TFFC_PLI_05Hz60Hz(:,Freq{FreqBand},:,:),2));
resultPLI(:,1:4)=squeeze(FC(:,1,[2,3,5,7]));
resultPLI(:,5:7)=squeeze(FC(:,2,[4,6,7]));
resultPLI(:,8:9)=squeeze(FC(:,3,[5,7]));
resultPLI(:,10:11)=squeeze(FC(:,4,[6,7]));
spss(:,7)=mean(resultPLI(:,1:11),2);
% Pearson corr,central
resultPLI(:,12:19)=squeeze(FC(:,10,[7,8,9,3,4,15,16,17]));
resultPLI(:,20:21)=squeeze(FC(:,7,[8,9]));
resultPLI(:,22:23)=squeeze(FC(:,17,[8,9]));
resultPLI(:,24:26)=squeeze(FC(:,8,[3,11,15]));
resultPLI(:,27:29)=squeeze(FC(:,9,[4,12,16]));
resultPLI(:,30:31)=squeeze(FC(:,11,[3,15]));
resultPLI(:,32:33)=squeeze(FC(:,12,[4,16]));
spss(:,8)=mean(resultPLI(:,12:33),2);
% Pearson corr,Occipital
resultPLI(:,34:36)=squeeze(FC(:,15,[13,17,18]));
resultPLI(:,37:39)=squeeze(FC(:,16,[14,17,19]));
resultPLI(:,40:41)=squeeze(FC(:,17,[18,19]));
resultPLI(:,42:43)=squeeze(FC(:,18,[13,19]));
resultPLI(:,44)=squeeze(FC(:,19,[14]));
spss(:,9)=mean(resultPLI(:,34:44),2);


% spssN(:,2:10)=spss;
% spssN(:,1)=[ones(36,1);2*ones(29,1);3*ones(23,1)];
% % spssALL=[spss,spssMI,spssPLI];
resultALL=[resultALL,result,resultMI,resultPLI];
end