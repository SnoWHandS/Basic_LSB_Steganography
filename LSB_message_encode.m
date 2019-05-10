function LSB_message_encode(audioIn, audioOut, message)

%Input a message

disp(message);

%Convert message to binary
binMessage = dec2bin(todecimal(message));
disp(binMessage);

%Decode binary to message
decodedMessage = strcat(char(bin2dec(binMessage)))
disp(decodedMessage);


fid = fopen(audioIn,'r');
header = fread(fid,40,'uint8=>char');
dsize  = fread(fid,1,'uint32');
[cover,len_cover] = fread(fid,inf,'uint16');
fclose(fid);


%Convert noise to binary
binBrownNoise = de2bi(cover);

%Convert binary to noise signal
newBrownNoise = bi2de(binBrownNoise);

disp(len_cover)
disp(length(newBrownNoise))

%disp(cover(1:8));

bin   = d2b(double(message),8);
[numchar, bits] = size(bin)



len_msg = numchar*bits;
M = d2b(numchar,40)
M = M' %transpose that boi
size(cover(9:48))
size(M(1:40))

if (len_cover >= len_msg+48)
    %Length of message is encoded (9:48)
    cover(9:48) = bitset(cover(9:48),1,M(1:40));
    %Message is encoded (49:48+len)
    cover(49:48+len_msg)=bitset(cover(49:48+len_msg),1,bin(1:len_msg)');
    %Stego file is saved
    out = fopen(audioOut,'w');
    fwrite(out,header,'uint8');
    fwrite(out,dsize,'uint32');
    fwrite(out,cover,'uint16');
    fclose(out);
else
    error('Message is too long!');
end


%check diff

%corrbnoise = corr(cover, newBrownNoise);

%figure()
%subplot(3,1,1)
%plot(newBrownNoise)
%subplot(3,1,2)
%plot(cover)
%subplot(3,1,3)
%plot(corrbnoise);

function b = d2b( d, n )
%D2B Minimal implentation of de2bi function
%if nargin<2
 %   n = floor ( log (max (max (d), 1)) ./ log (p) ) + 1;
%end
d = d(:);
power = ones (length (d), 1) * (2 .^ (0 : n-1) );
d = d * ones (1, n);
b = floor (rem(d, 2*power) ./ power);
end
end
