function decipheredMessage = LSB_message_decode(stegoAudioIn)

fid = fopen(stegoAudioIn,'r');
header = fread(fid,40,'uint8=>char');
dsize  = fread(fid,1,'uint32');
stego  = fread(fid,inf,'uint16');
fclose(fid);

%Length of message is read
numchar_bin = bitget(stego(44:75),1);
%Detranspose that boi and convert to decimal
length_msg = bi2de(numchar_bin')*8;
%Hidden message is read and decrypted
data = bitget(stego(76:75+length_msg),1);
bin = reshape(data,length_msg/8,8);
decipheredMessage = char(bi2de(bin))';

end