function decipheredMessage = LSB_message_decode(stegoAudioIn)

%Header = 1:40, Length = 41:43, Data = 44:end
fid = fopen(stegoAudioIn,'r');
header = fread(fid,40,'uint8=>char');
dsize  = fread(fid,1,'uint32');
stego  = fread(fid,inf,'uint16');
fclose(fid);

    %Length of message is read (9:48)
    m = bitget(stego(9:48),1);
    len = b2d(m')*8;
%Hidden message is read and decrypted (49:len)
    dat = bitget(stego(49:48+len),1);
    bin = reshape(dat,len/8,8);
    decipheredMessage = char(b2d(bin))';
    
    
function d = b2d(b)
%B2D Minimal implentation of bi2de function
  if isempty(b)
    d = [];
  else
    d = b * (2 .^ (0:length(b(1,:)) - 1)');
  end
end

end