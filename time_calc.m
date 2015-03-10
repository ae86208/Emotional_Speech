function [ idx, speechl ] = time_calc( stream )
% time_calc return the time occurance index and last length
%   occurance with shift from 0 to 1 and end with shift from 1 to 0

idx = zeros(10);
speechl = zeros(10);
cnt = 0;

for i = 1 : length(stream) - 1
    
    if stream(i) == 0 && stream(i+1) == 1
        indexTemp = i+1;
        cnt = cnt + 1;
        idx(cnt) = indexTemp;
    end
    
    if stream(i) == 1 && stream(i+1) == 0
        lengthTemp = i - indexTemp + 1;
        speechl(cnt) = lengthTemp;
    end
    
    
end

idx = idx( idx ~= 0);
speechl = speechl(speechl ~= 0);

% idx = idx(idx ~= 0);
% speechl = speechl(speechl ~= 0);

end

