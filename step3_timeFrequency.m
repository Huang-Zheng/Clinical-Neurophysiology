%%
clc
tic
Fs=250;
f=0.5;
f=[0.5,1:45]
omega=1;sigma=1;
TFmorletLogPower=zeros(88,19,46,75000);
for sub=1:88
    for chan=1:19
        x=squeeze(resampledEEG250HZ(sub,chan,:));
        tmp=subfunc_mwt(x, f, Fs, omega, sigma);
        TFmorletLogPower(sub,chan,:,1:length(x))=10*log10(tmp);
    end
end
toc