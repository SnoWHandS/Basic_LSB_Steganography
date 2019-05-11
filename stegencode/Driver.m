
%Pop up to ask for cover audio file
[FileName,PathName] = uigetfile({'*.mp3';'*.wav'}, 'Select cover audio:', 'Darude_Sandstorm.mp3');
[file.path,file.name,file.ext] = fileparts([PathName FileName]);

%Assign audio in and audio out
audioIn = [PathName FileName];
audioOut = [file.path '/' file.name '_stego' file.ext];

%Pop up to ask for message file
[MessageFileName,PathName] = uigetfile({'.txt'}, 'Select message file:', 'message_to_encode.txt');
message = fileread(MessageFileName);

%Run message encoder with LSB
LSB_message_encode(audioIn, audioOut, message);

%Pop up to ask for stego audio file
[FileNameStego,PathNameStego] = uigetfile({'*.mp3';'*.wav'}, 'Select audio to analyse:', 'Darude_Sandstorm_stego.mp3');
audioStegoIn = [PathNameStego FileNameStego];

%Decode message
decipheredMessage = LSB_message_decode(audioStegoIn);
%display decoded message
disp(decipheredMessage)