
%Pop up to ask for cover audio file
[FileName,PathName] = uigetfile({'*.mp3';'*.wav'}, 'Select cover audio:');
[file.path,file.name,file.ext] = fileparts([PathName FileName]);

%Assign audio in and audio out
audioIn = [PathName FileName];
audioOut = [file.path '/' file.name '_stego' file.ext];

%Pop up to ask for message file
[MessageFileName,PathName] = uigetfile({'.txt'}, 'Select message file:');
message = fileread(MessageFileName);

%Run message encoder with LSB
LSB_message_encode(audioIn, audioOut, message);


%Pop up to ask for stego audio file
[FileNameStego,PathNameStego] = uigetfile({'*.mp3';'*.wav'}, 'Select audio to analyse:');
audioStegoIn = [PathNameStego FileNameStego];

%Decode message
decipheredMessage = LSB_message_decode(audioStegoIn);
%display decoded message
disp(decipheredMessage)


%play waveform
%load('handel.mat')
%whos y Fs

%player = audioplayer(y,Fs);

%play(player);


%LSB_message_decode
