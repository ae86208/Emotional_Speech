%% File path set and initialization
% designate the destination of the path of training set
clear;clc;

filePath = 'F:\Working_stuff\毕设\情感语音\情感语音';

angryFilePath = strcat(filePath, '\生气\');
happyFilePath = strcat(filePath, '\高兴\');
neutralFilePath = strcat(filePath, '\中性\');
sadFilePath = strcat(filePath, '\悲伤\');

addpath(angryFilePath, happyFilePath, neutralFilePath, sadFilePath);

%parameter settings for feature extration
defaultparams;
f0floor = 50;
f0ceil = 500;


%% Training
% F0 time and power calculation
% raw, still remain to be processed
infoAngry = cell(50,1);
infoHappy = cell(50,1);
infoNeutral = cell(50,1);
infoSad = cell(50,1);

for i = 201:250
    
    % Angry information
    fileAngryTemp = strcat(angryFilePath, int2str(i), '.wav');
    [audioAngry, fs] = audioread(fileAngryTemp);
    [f0raw, vuv, auxouts] = MulticueF0v14(audioAngry, fs, f0floor, f0ceil);
    infoAngry{i-200}.f0raw = f0raw;
    infoAngry{i-200}.vuv = vuv;
    infoAngry{i-200}.pow = auxouts.InstantaneousPower;
    
    % Happy information
    fileHappyTemp = strcat(happyFilePath, int2str(i), '.wav');
    [audioHappy, fs] = audioread(fileHappyTemp);
    [f0raw, vuv, auxouts] = MulticueF0v14(audioHappy, fs, f0floor, f0ceil);
    infoHappy{i-200}.f0raw = f0raw;
    infoHappy{i-200}.vuv = vuv;
    infoHappy{i-200}.pow = auxouts.InstantaneousPower;
    
    % Neutral information
    fileNeutralTemp = strcat(neutralFilePath, int2str(i), '.wav');
    [audioNeutral, fs] = audioread(fileNeutralTemp);
    [f0raw, vuv, auxouts] = MulticueF0v14(audioNeutral, fs, f0floor, f0ceil);
    infoNeutral{i-200}.f0raw = f0raw;
    infoNeutral{i-200}.vuv = vuv;
    infoNeutral{i-200}.pow = auxouts.InstantaneousPower;
    
    % Sad information
    fileSadTemp = strcat(sadFilePath, int2str(i), '.wav');
    [audioSad, fs] = audioread(fileSadTemp);
    [f0raw, vuv, auxouts] = MulticueF0v14(audioSad, fs, f0floor, f0ceil);
    infoSad{i-200}.f0raw = f0raw;
    infoSad{i-200}.vuv = vuv;
    infoSad{i-200}.pow = auxouts.InstantaneousPower;
    
end

% save workspace for other use
save infoAngry.mat infoAngry;
save infoHappy.mat infoHappy;
save infoNeutral.mat infoNeutral;
save infoSad.mat infoSad;


%% data purifying
% process data into desired ones

% restore workspace
clear;clc;
load('infoAngry.mat');
load('infoHappy.mat');
load('infoNeutral.mat');
load('infoSad.mat');


% %% Unit Test
% % DESCRIPTIVE TEXT
% [idx, speechl] = time_calc(infoHappy{5}.vuv);

% Angry
purifiedAngry.F0 = 0;
purifiedAngry.Time = 0;
purifiedAngry.Pow = 0;

for i= 1:50
    
    purifiedF0 = infoAngry{i}.f0raw .* infoAngry{i}.vuv;
    purifiedF0 = purifiedF0(purifiedF0 ~= 0);
    purifiedAngry.F0 =  [ purifiedAngry.F0; purifiedF0 ];
    
    [idx, purifiedTime] = time_calc(infoAngry{i}.vuv);
    purifiedAngry.Time = [purifiedAngry.Time; purifiedTime];
    
    for j = 1:length(idx)
        purifiedPow = sum(infoAngry{i}.pow(idx(j) : idx(j) + purifiedTime(j) - 1) ) / purifiedTime(j);
        purifiedAngry.Pow = [purifiedAngry.Pow; purifiedPow];
    end
end

purifiedAngry.F0 = purifiedAngry.F0(purifiedAngry.F0 ~= 0);
purifiedAngry.Time = purifiedAngry.Time(purifiedAngry.Time ~= 0);
purifiedAngry.Pow = purifiedAngry.Pow(purifiedAngry.Pow ~= 0);


% Happy
purifiedHappy.F0 = 0;
purifiedHappy.Time = 0;
purifiedHappy.Pow = 0;
for i= 1:50
    
    purifiedF0 = infoHappy{i}.f0raw .* infoHappy{i}.vuv;
    purifiedF0 = purifiedF0(purifiedF0 ~= 0);
    purifiedHappy.F0 =  [ purifiedHappy.F0; purifiedF0 ];
    
    [idx, purifiedTime] = time_calc(infoHappy{i}.vuv);
    purifiedHappy.Time = [purifiedHappy.Time; purifiedTime];
    
    for j = 1:length(idx)
        purifiedPow = sum(infoHappy{i}.pow(idx(j) : idx(j) + purifiedTime(j) - 1) ) / purifiedTime(j);
        purifiedHappy.Pow = [purifiedHappy.Pow; purifiedPow];
    end
end

purifiedHappy.F0 = purifiedHappy.F0(purifiedHappy.F0 ~= 0);
purifiedHappy.Time = purifiedHappy.Time(purifiedHappy.Time ~= 0);
purifiedHappy.Pow = purifiedHappy.Pow(purifiedHappy.Pow ~= 0);


% Neutral
purifiedNeutral.F0 = 0;
purifiedNeutral.Time = 0;
purifiedNeutral.Pow = 0;

for i= 1:50
    
    purifiedF0 = infoNeutral{i}.f0raw .* infoNeutral{i}.vuv;
    purifiedF0 = purifiedF0(purifiedF0 ~= 0);
    purifiedNeutral.F0 =  [ purifiedNeutral.F0; purifiedF0 ];
    
    [idx, purifiedTime] = time_calc(infoNeutral{i}.vuv);
    purifiedNeutral.Time = [purifiedNeutral.Time; purifiedTime];
    
    for j = 1:length(idx)
        purifiedPow = sum(infoNeutral{i}.pow(idx(j) : idx(j) + purifiedTime(j) - 1) ) / purifiedTime(j);
        purifiedNeutral.Pow = [purifiedNeutral.Pow; purifiedPow];
    end
end

purifiedNeutral.F0 = purifiedNeutral.F0(purifiedNeutral.F0 ~= 0);
purifiedNeutral.Time = purifiedNeutral.Time(purifiedNeutral.Time ~= 0);
purifiedNeutral.Pow = purifiedNeutral.Pow(purifiedNeutral.Pow ~= 0);


% Sad
purifiedSad.F0 = 0;
purifiedSad.Time = 0;
purifiedSad.Pow = 0;

for i= 1:50
    
    purifiedF0 = infoSad{i}.f0raw .* infoSad{i}.vuv;
    purifiedF0 = purifiedF0(purifiedF0 ~= 0);
    purifiedSad.F0 =  [ purifiedSad.F0; purifiedF0 ];
    
    [idx, purifiedTime] = time_calc(infoSad{i}.vuv);
    purifiedSad.Time = [purifiedSad.Time; purifiedTime];
    
    for j = 1:length(idx)
        purifiedPow = sum(infoSad{i}.pow(idx(j) : idx(j) + purifiedTime(j) - 1) ) / purifiedTime(j);
        purifiedSad.Pow = [purifiedSad.Pow; purifiedPow];
    end
end

purifiedSad.F0 = purifiedSad.F0(purifiedSad.F0 ~= 0);
purifiedSad.Time = purifiedSad.Time(purifiedSad.Time ~= 0);
purifiedSad.Pow = purifiedSad.Pow(purifiedSad.Pow ~= 0);


save purifiedAngry.mat purifiedAngry
save purifiedSad.mat purifiedSad
save purifiedNeutral.mat purifiedNeutral
save purifiedHappy.mat purifiedHappy

%% Plot
% draw the distributions of each state

figure;
subplot(2,2,1);
hist(purifiedAngry.F0);
title('distribution of F0 of state Angry');
subplot(2,2,2);
hist(purifiedHappy.F0);
title('distribution of F0 of state Happy');
subplot(2,2,3);
hist(purifiedNeutral.F0);
title('distribution of F0 of state Neutral');
subplot(2,2,4);
hist(purifiedSad.F0);
title('distribution of F0 of state Sad');