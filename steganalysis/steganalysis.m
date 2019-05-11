%Analyse the statisical information within the encoded file

[FileName,PathName] = uigetfile({'*.mp3';'*.wav'},'Select audio to analyse:', 'Darude_Sandstorm_stego.mp3');
file = [PathName FileName]

%Read the actual file information in for bitwise checking
fid = fopen(file,'r');
header = fread(fid,40,'uint8=>char');
dsize  = fread(fid,1,'uint32');
stego  = fread(fid,inf,'uint16');
fclose(fid);

%Read the audio waveform in
[y, Fs] = audioread(file);

%Plot time domain
figure;
subplot(2,1,1)
plot(y)
title('Input audio waveform')

%Plot spectrogram
subplot(2,1,2)
y_len = length(y)
spectrogram(y(1:y_len),[],[],[],Fs,'yaxis');
title('Spectrogram of input audio waveform')
