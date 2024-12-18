clc
load EEGdata_500Hz
fs_original = 500; % Hz
fs_target = 250; % Hz
downsample_factor = fs_original / fs_target;
eegData_250Hz = zeros(88,19,75000);
for sub = 1:88
    for chan = 1:19
        eegDataTmp = squeeze(EEGdata_500Hz(sub,chan,:));
        eegData_250Hz(sub,chan,:) = downsample(eegDataTmp, downsample_factor);
    end
end