Fs = 250; 
filterOrder = 4; 

n = size(resampledEEG250HZ, 3);
EEG_butter4order1Hz45Hz = zeros(88, 19, 45, n);
for sub = 1:88
    for chan = 1:19
        EEGData = double(squeeze(resampledEEG250HZ(sub, chan, :)));
        for freq = 1:45
            if freq == 1
                fc_low = freq-0.5; 
                fc_high = freq; 
            elseif freq > 1
                fc_low = freq-1; 
                fc_high = freq; 
            end
        [b, a] = butter(filterOrder, [fc_low/(Fs/2), fc_high/(Fs/2)], 'bandpass');
        EEG_butter4order1Hz45Hz(sub, chan, freq, :) = filter(b, a, EEGData);
        end
    end
end