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
