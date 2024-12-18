%% Pearson's R
segLen=250*5;
FC_Pearson05Hz45Hz=zeros(88,15,19,19);
for sub=1:88
    for freq=1:15
        seg=0;
        fcTMP=zeros(19,19);
        for win=1:segLen:75001-segLen
            seg=seg+1;
                data1 = squeeze(EEG_bandPass05Hz45Hz_fir4order05Hz15Hz(sub,:,freq,win:win+segLen-1));
                data1Seq = data1([1,2,3,4,11,12,17,5,6,18,13,14,15,16,7,8,19,9,10],:);%Fp1 Fp2 F3 F4 F7 F8 Fz C3 C4 Cz T3 T4 T5 T6 P3 P4 Pz O1 O2
                fcTMP = fcTMP + corr(data1Seq',data1Seq');
        end
        FC_Pearson05Hz45Hz(sub,freq,:,:)=fcTMP./60;
    end
end

%%  Mutual Information
segLen=250*5;
% FC_MI05Hz13Hz=zeros(88,14,19,19);
for sub=1:88
    for freq=1:14
        seg=0;fcTMP=zeros(19,19);
        for win=1:segLen:75001-segLen
        seg=seg+1;

        data1=squeeze(EEG_bandPass05Hz13Hz(sub,:,freq,win:win+segLen-1));
        EEG = data1([1,2,3,4,11,12,17,5,6,18,13,14,15,16,7,8,19,9,10],:);
        MI_matrix = zeros(19, 19);

            for i = 1:18
                for j = i+1:19  % 我们只需要计算上三角形，因为 PLI 是对称的
                    EEG1 = EEG(i, :)';
                    EEG2 = EEG(j, :)';
                    MI = mutual_information(EEG1, EEG2, 50);
                    MI_matrix(i, j) = MI;
                    MI_matrix(j, i) = MI;  % 因为 PLI 是对称的
                end
            end
            fcTMP = fcTMP + MI_matrix;
        end
        FC_MI05Hz13Hz(sub,freq,:,:)=MI_matrix./19;
    end
end
%%  PLI
segLen=250*5;
FC=zeros(88,30,60,19,19);
for sub=1:88
    for freq=1:30
        seg=0;
        fcTMP=zeros(19,19);
        for win=1:segLen:75001-segLen
            seg=seg+1;
            data1=squeeze(EEG_bandPass05Hz13Hz(sub,:,freq,win:win+segLen-1));
            EEG = data1([1,2,3,4,11,12,17,5,6,18,13,14,15,16,7,8,19,9,10],:);
            PLI_matrix = zeros(19, 19);
            for i = 1:18
                for j = i+1:19
                    EEG1 = EEG(i, :); 
                    EEG2 = EEG(j, :);

                    phase1 = angle(hilbert(EEG1));
                    phase2 = angle(hilbert(EEG2));
                    phase_diff = phase1 - phase2;
                    PLIdata = abs(mean(sign(sin(phase_diff))));

                    PLI_matrix(i, j) = PLIdata;
                    PLI_matrix(j, i) = PLIdata;  % 因为 PLI 是对称的
                end
            end
            FC(sub,freq,seg,:,:)=PLI_matrix;
        end
    end
end