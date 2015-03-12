function [ X, fs ] = AdaptedAudioread( stream, vr_ck )
% for backward compatibility
if vr_ck < 8.4
    [X, fs] = wavread(stream);
else
    [X, fs] = audioread(stream);

end

