%Analyse the statisical information within the encoded file


[FileName_st,PathName_st] = uigetfile({'*.wav'},'Select cover audio to analyse:', 'Darude_Sandstorm_stego.wav');
fileStego = [PathName_st FileName_st]

%Read the actual file information in for bitwise checking
fid_stego = fopen(fileStego,'r');
header = fread(fid_stego,40,'uint8=>char');
dsize  = fread(fid_stego,1,'uint32');
stego  = fread(fid_stego,inf,'uint16');
fclose(fid_stego);

%Read the audio waveform in
[y_stego, Fs] = audioread(fileStego);

%Plot time domain
figure;
subplot(2,1,1)
plot(y_stego)
title('Cover input audio waveform')

%Plot spectrogram
subplot(2,1,2)
y_steg_len = length(y_stego);
spectrogram(y_stego(1:y_steg_len),[],[],[],Fs,'yaxis');
title('Spectrogram of cover input audio waveform')





%Read in original audio
[FileName_og,PathName_og] = uigetfile({'*.wav'},'Select original audio to analyse:', 'Darude_Sandstorm.wav');
fileOrig = [PathName_og FileName_og]

%Read the actual file information in for bitwise checking
fid_orig = fopen(fileStego,'r');
header = fread(fid_orig,40,'uint8=>char');
dsize  = fread(fid_orig,1,'uint32');
orig  = fread(fid_orig,inf,'uint16');
fclose(fid_orig);

%Read the audio waveform in
[y_orig, Fs] = audioread(fileOrig);

%Plot time domain
figure;
subplot(2,1,1)
plot(y_orig)
title('Original input audio waveform')

%Plot spectrogram
subplot(2,1,2)
y_orig_len = length(y_orig);
spectrogram(y_orig(1:y_orig_len),[],[],[],Fs,'yaxis');
title('Spectrogram of original input audio waveform')

%Compute the difference
mean_stego = mean(y_stego);
mean_orig = mean(y_orig);

[stegsize , channelssteg] = size(y_stego)
[ysize, channels]= size(y_orig)

%y_orig = imresize(y_orig,size(y_stego)) ;

%plot difference of waveforms
figure;
subplot(2,1,1)
dif_waveform = y_orig - y_stego;
plot(dif_waveform)
title('Difference between waveforms');
subplot(2,1,2)
plot(dif_waveform(1:5500))
title('Difference between waveforms zoomed on difference');

%plot correlation of waveforms
figure;
corr_waveform = xcorr(y_orig,y_stego);
corr_waveform = corr_waveform./max(abs(corr_waveform(:)));
plot(corr_waveform)
title('correlation between waveforms');


%plot correlation of spectrograms
%figure;
%corr_spec = xcorr(specorig,specsteg);
%corr_spec = corr_spec./max(abs(corr_spec(:)));
%plot(corr_spec)
%title('correlation between spectrums');

