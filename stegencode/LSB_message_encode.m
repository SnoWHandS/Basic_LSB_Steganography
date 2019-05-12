function LSB_message_encode(audioIn, audioOut, message)

%Input a message

disp(message);

%Convert message to binary
binMessage = dec2bin(todecimal(message));
disp(binMessage);

%Decode binary to message
decodedMessage = strcat(char(bin2dec(binMessage)))'
disp(decodedMessage);

%Open the file
fid = fopen(audioIn,'r');
header = fread(fid,40,'uint8=>char');
dsize  = fread(fid,1,'uint32');
[cover_original,len_cover] = fread(fid,inf,'uint16');
fclose(fid);

%Put message into binary, 8 bits
bin = de2bi(double(message),8);

%Get the size of the binary representation of the message
[numchar, bits] = size(bin)

%Get message length to be written to file
len_msg = numchar*bits;
%Change message length to binary
numchar_bin = de2bi(numchar,32);
%transpose that boi
numchar_bin = numchar_bin';

%Make sure the message length plus header fits
if (len_cover >= len_msg+32)
    %Length of message is encoded
    cover_original(44:75) = bitset(cover_original(44:75),1,numchar_bin(1:32));
    %Message is encoded
    cover_original(76:75+len_msg)=bitset(cover_original(76:75+len_msg),1,bin(1:len_msg)');
    %Stego file is saved
    out = fopen(audioOut,'w');
    fwrite(out,header,'uint8');
    fwrite(out,dsize,'uint32');
    fwrite(out,cover_original,'uint16');
    fclose(out);
else
    error('Message is too long');
end
end
