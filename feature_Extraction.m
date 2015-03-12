%% File path set and initialization
% designate the destination of the path of training set
clear;clc;

filePath = 'F:\Working_stuff\毕设\情感语音\情感语音';

filePathAngry = strcat(filePath, '\生气\');
filePathHappy = strcat(filePath, '\高兴\');
filePathNeutral = strcat(filePath, '\中性\');
filePathSad = strcat(filePath, '\悲伤\');

addpath(filePathAngry, filePathHappy, filePathNeutral, filePathSad);

%parameter settings for feature extration
defaultparams;
f0floor = 50;
f0ceil = 500;


% %% Training Serial Version
% % F0 time and power calculation
% % raw, still remain to be processed
% infoAngry = cell(50,1);
% infoHappy = cell(50,1);
% infoNeutral = cell(50,1);
% infoSad = cell(50,1);
% 
% for i = 201:250
%     
%     % Angry information
%     fileAngryTemp = strcat(filePathAngry, int2str(i), '.wav');
%     [audioAngry, fs] = audioread(fileAngryTemp);
%     [f0raw, vuv, auxouts] = MulticueF0v14(audioAngry, fs, f0floor, f0ceil);
%     infoAngry{i-200}.f0raw = f0raw;
%     infoAngry{i-200}.vuv = vuv;
%     infoAngry{i-200}.pow = auxouts.InstantaneousPower;
%     
%     % Happy information
%     fileHappyTemp = strcat(filePathHappy, int2str(i), '.wav');
%     [audioHappy, fs] = audioread(fileHappyTemp);
%     [f0raw, vuv, auxouts] = MulticueF0v14(audioHappy, fs, f0floor, f0ceil);
%     infoHappy{i-200}.f0raw = f0raw;
%     infoHappy{i-200}.vuv = vuv;
%     infoHappy{i-200}.pow = auxouts.InstantaneousPower;
%     
%     % Neutral information
%     fileNeutralTemp = strcat(filePathNeutral, int2str(i), '.wav');
%     [audioNeutral, fs] = audioread(fileNeutralTemp);
%     [f0raw, vuv, auxouts] = MulticueF0v14(audioNeutral, fs, f0floor, f0ceil);
%     infoNeutral{i-200}.f0raw = f0raw;
%     infoNeutral{i-200}.vuv = vuv;
%     infoNeutral{i-200}.pow = auxouts.InstantaneousPower;
%     
%     % Sad information
%     fileSadTemp = strcat(filePathSad, int2str(i), '.wav');
%     [audioSad, fs] = audioread(fileSadTemp);
%     [f0raw, vuv, auxouts] = MulticueF0v14(audioSad, fs, f0floor, f0ceil);
%     infoSad{i-200}.f0raw = f0raw;
%     infoSad{i-200}.vuv = vuv;
%     infoSad{i-200}.pow = auxouts.InstantaneousPower;
%     
% end
% 
% % save workspace for other use
% save infoAngry.mat infoAngry;
% save infoHappy.mat infoHappy;
% save infoNeutral.mat infoNeutral;
% save infoSad.mat infoSad;
% 
% 
% %% Training parallel version
% % F0 time and power calculation
% % raw, still remain to be processed
% infoAngry = cell(50,1);
% infoHappy = cell(50,1);
% infoNeutral = cell(50,1);
% infoSad = cell(50,1);
% 
% parfor i = 201:250
%     
%     % Angry information
%     fileAngryTemp = strcat(filePathAngry, int2str(i), '.wav');
%     [audioAngry, fs] = audioread(fileAngryTemp);
%     [f0rawA, vuvA, auxoutsA] = MulticueF0v14(audioAngry, fs, f0floor, f0ceil);
%     infoAngry{i-200}.f0raw = f0rawA;
%     infoAngry{i-200}.vuv = vuvA;
%     infoAngry{i-200}.pow = auxoutsA.InstantaneousPower;
%     
%     % Happy information
%     fileHappyTemp = strcat(filePathHappy, int2str(i), '.wav');
%     [audioHappy, fs] = audioread(fileHappyTemp);
%     [f0rawH, vuvH, auxoutsH] = MulticueF0v14(audioHappy, fs, f0floor, f0ceil);
%     infoHappy{i-200}.f0raw = f0rawH;
%     infoHappy{i-200}.vuv = vuvH;
%     infoHappy{i-200}.pow = auxoutsH.InstantaneousPower;
%     
%     % Neutral information
%     fileNeutralTemp = strcat(filePathNeutral, int2str(i), '.wav');
%     [audioNeutral, fs] = audioread(fileNeutralTemp);
%     [f0rawN, vuvN, auxoutsN] = MulticueF0v14(audioNeutral, fs, f0floor, f0ceil);
%     infoNeutral{i-200}.f0raw = f0rawN;
%     infoNeutral{i-200}.vuv = vuvN;
%     infoNeutral{i-200}.pow = auxoutsN.InstantaneousPower;
%     
%     % Sad information
%     fileSadTemp = strcat(filePathSad, int2str(i), '.wav');
%     [audioSad, fs] = audioread(fileSadTemp);
%     [f0rawS, vuvS, auxoutsS] = MulticueF0v14(audioSad, fs, f0floor, f0ceil);
%     infoSad{i-200}.f0raw = f0rawS;
%     infoSad{i-200}.vuv = vuvS;
%     infoSad{i-200}.pow = auxoutsS.InstantaneousPower;
%     
% end
% 
% % save workspace for other use
% save infoAngry_parallel.mat infoAngry;
% save infoHappy_parallel.mat infoHappy;
% save infoNeutral_parallel.mat infoNeutral;
% save infoSad_parallel.mat infoSad;
% 
% 
% 
% %% data purifying
% % process data into desired ones
% 
% % restore workspace
% clear;clc;
% load('infoAngry.mat');
% load('infoHappy.mat');
% load('infoNeutral.mat');
% load('infoSad.mat');
% 
% 
% % %% Unit Test
% % % DESCRIPTIVE TEXT
% % [idx, speechl] = time_calc(infoHappy{5}.vuv);
% 
% % Angry
% purifiedAngry.F0 = 0;
% purifiedAngry.Time = 0;
% purifiedAngry.Pow = 0;
% 
% for i= 1:50
%     
%     purifiedF0 = infoAngry{i}.f0raw .* infoAngry{i}.vuv;
%     purifiedF0 = purifiedF0(purifiedF0 ~= 0);
%     purifiedAngry.F0 =  [ purifiedAngry.F0; purifiedF0 ];
%     
%     [idx, purifiedTime] = time_calc(infoAngry{i}.vuv);
%     purifiedAngry.Time = [purifiedAngry.Time; purifiedTime];
%     
%     for j = 1:length(idx)
%         purifiedPow = sum(infoAngry{i}.pow(idx(j) : idx(j) + purifiedTime(j) - 1) ) / purifiedTime(j);
%         purifiedAngry.Pow = [purifiedAngry.Pow; purifiedPow];
%     end
% end
% 
% purifiedAngry.F0 = purifiedAngry.F0(purifiedAngry.F0 ~= 0);
% purifiedAngry.Time = purifiedAngry.Time(purifiedAngry.Time ~= 0);
% purifiedAngry.Pow = purifiedAngry.Pow(purifiedAngry.Pow ~= 0);
% 
% 
% % Happy
% purifiedHappy.F0 = 0;
% purifiedHappy.Time = 0;
% purifiedHappy.Pow = 0;
% for i= 1:50
%     
%     purifiedF0 = infoHappy{i}.f0raw .* infoHappy{i}.vuv;
%     purifiedF0 = purifiedF0(purifiedF0 ~= 0);
%     purifiedHappy.F0 =  [ purifiedHappy.F0; purifiedF0 ];
%     
%     [idx, purifiedTime] = time_calc(infoHappy{i}.vuv);
%     purifiedHappy.Time = [purifiedHappy.Time; purifiedTime];
%     
%     for j = 1:length(idx)
%         purifiedPow = sum(infoHappy{i}.pow(idx(j) : idx(j) + purifiedTime(j) - 1) ) / purifiedTime(j);
%         purifiedHappy.Pow = [purifiedHappy.Pow; purifiedPow];
%     end
% end
% 
% purifiedHappy.F0 = purifiedHappy.F0(purifiedHappy.F0 ~= 0);
% purifiedHappy.Time = purifiedHappy.Time(purifiedHappy.Time ~= 0);
% purifiedHappy.Pow = purifiedHappy.Pow(purifiedHappy.Pow ~= 0);
% 
% 
% % Neutral
% purifiedNeutral.F0 = 0;
% purifiedNeutral.Time = 0;
% purifiedNeutral.Pow = 0;
% 
% for i= 1:50
%     
%     purifiedF0 = infoNeutral{i}.f0raw .* infoNeutral{i}.vuv;
%     purifiedF0 = purifiedF0(purifiedF0 ~= 0);
%     purifiedNeutral.F0 =  [ purifiedNeutral.F0; purifiedF0 ];
%     
%     [idx, purifiedTime] = time_calc(infoNeutral{i}.vuv);
%     purifiedNeutral.Time = [purifiedNeutral.Time; purifiedTime];
%     
%     for j = 1:length(idx)
%         purifiedPow = sum(infoNeutral{i}.pow(idx(j) : idx(j) + purifiedTime(j) - 1) ) / purifiedTime(j);
%         purifiedNeutral.Pow = [purifiedNeutral.Pow; purifiedPow];
%     end
% end
% 
% purifiedNeutral.F0 = purifiedNeutral.F0(purifiedNeutral.F0 ~= 0);
% purifiedNeutral.Time = purifiedNeutral.Time(purifiedNeutral.Time ~= 0);
% purifiedNeutral.Pow = purifiedNeutral.Pow(purifiedNeutral.Pow ~= 0);
% 
% 
% % Sad
% purifiedSad.F0 = 0;
% purifiedSad.Time = 0;
% purifiedSad.Pow = 0;
% 
% for i= 1:50
%     
%     purifiedF0 = infoSad{i}.f0raw .* infoSad{i}.vuv;
%     purifiedF0 = purifiedF0(purifiedF0 ~= 0);
%     purifiedSad.F0 =  [ purifiedSad.F0; purifiedF0 ];
%     
%     [idx, purifiedTime] = time_calc(infoSad{i}.vuv);
%     purifiedSad.Time = [purifiedSad.Time; purifiedTime];
%     
%     for j = 1:length(idx)
%         purifiedPow = sum(infoSad{i}.pow(idx(j) : idx(j) + purifiedTime(j) - 1) ) / purifiedTime(j);
%         purifiedSad.Pow = [purifiedSad.Pow; purifiedPow];
%     end
% end
% 
% purifiedSad.F0 = purifiedSad.F0(purifiedSad.F0 ~= 0);
% purifiedSad.Time = purifiedSad.Time(purifiedSad.Time ~= 0);
% purifiedSad.Pow = purifiedSad.Pow(purifiedSad.Pow ~= 0);
% 
% % save workspace for other use
% save purifiedAngry.mat purifiedAngry
% save purifiedSad.mat purifiedSad
% save purifiedNeutral.mat purifiedNeutral
% save purifiedHappy.mat purifiedHappy
% 


%% Plot
% draw the distributions of each state
load purifiedAngry.mat;
load purifiedHappy.mat
load purifiedNeutral.mat
load purifiedSad.mat

figure;
subplot(2,2,1);
title('distribution of F0 of state Neutral');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedNeutral.F0,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedNeutral.F0,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('F0 (Hz)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'NeutralF0';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedNeutral.F0, 'normal');
histNeutral.F0.average = pd1.mean;
histNeutral.F0.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitNeutralF0';

str1 = strcat('\mu :  ', num2str(histNeutral.F0.average));
text(50, 5.5e-3, str1);
str2 = strcat('\sigma :  ', num2str(histNeutral.F0.deviation));
text(50, 4.5e-3, str2);
axis tight;

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;




subplot(2,2,3);
title('distribution of F0 of state Sad');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedSad.F0,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedSad.F0,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('F0 (Hz)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'SadF0';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedSad.F0, 'normal');
histSad.F0.average = pd1.mean;
histSad.F0.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitSadF0';

str1 = strcat('\mu : ', num2str(histSad.F0.average));
text(50, 7e-3, str1);
str2 = strcat('\sigma : ', num2str(histSad.F0.deviation));
text(50, 5e-3, str2);
axis tight;

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;



subplot(2,2,2);
title('distribution of F0 of state Angry');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedAngry.F0,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedAngry.F0,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('F0 (Hz)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'AngryF0';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedAngry.F0, 'normal');
histAngry.F0.average = pd1.mean;
histAngry.F0.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitAngryF0';

str1 = strcat('\mu : ', num2str(histAngry.F0.average));
text(50, 4e-3, str1);
str2 = strcat('\sigma : ', num2str(histAngry.F0.deviation));
text(50, 3e-3, str2);
axis tight;

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;


subplot(2,2,4);
title('distribution of F0 of state Happy');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedHappy.F0,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedHappy.F0,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('F0 (Hz)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'HappyF0';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedHappy.F0, 'normal');
histHappy.F0.average = pd1.mean;
histHappy.F0.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitHappyF0';

str1 = strcat('\mu : ', num2str(histHappy.F0.average));
text(50, 4e-3, str1);
str2 = strcat('\sigma : ', num2str(histHappy.F0.deviation));
text(50, 3e-3, str2);
axis tight;

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;



% % F0 distribution
% figure;
% 
% % Neutral
% subplot(2,2,1);
% [histNeutral.F0.counts, histNeutral.F0.centers] = hist(purifiedNeutral.F0);
% hist(purifiedNeutral.F0);
% title('distribution of F0 of state Neutral');
% 
% % Neutral Gaussian fit
% [fitNeutralResult.F0, ~, xTemp, yTemp] = GaussianFit(histNeutral.F0.centers, histNeutral.F0.counts);
% histNeutral.F0.average = fitNeutralResult.F0.b1;
% histNeutral.F0.deviation = sqrt(fitNeuralResult.F0.c1.^2 / 2);
% 
% hold on;
% plot(fitNeutralResult.F0, xTemp, yTemp);
% xlabel('base freqency / Hz');
% ylabel('show time');
% str = strcat('\mu : ', num2str(int64(histNeutral.F0.average)));
% text(70, max(yTemp), str);
% str = strcat('\sigma : ', num2str(int64(histNeutral.F0.deviation)));
% text(70, max(yTemp) - 1000, str);
% hold off;
% 
% 
% % Angry
% subplot(2,2,2);
% [histAngry.F0.counts, histAngry.F0.centers] = hist(purifiedAngry.F0);
% hist(purifiedAngry.F0);
% title('distribution of F0 of state Angry');
% 
% % Angry Gaussian fit
% [fitAngryResult.F0, ~, xTemp, yTemp] = GaussianFit(histAngry.F0.centers, histAngry.F0.counts);
% histAngry.F0.average = fitAngryResult.F0.b1;
% histAngry.F0.deviation = sqrt(fitAngryResult.F0.c1.^2 / 2);
% 
% hold on;
% plot(fitAngryResult.F0, xTemp, yTemp);
% xlabel('base freqency / Hz');
% ylabel('show time');
% str = strcat('\mu : ', num2str(int64(histAngry.F0.average)));
% text(20, max(yTemp) + 1000, str);
% str = strcat('\sigma : ', num2str(int64(histAngry.F0.deviation)));
% text(20, max(yTemp), str);
% hold off;
% 
% 
% % Sad
% subplot(2,2,3);
% [histSad.F0.counts, histSad.F0.centers] = hist(purifiedSad.F0);
% hist(purifiedSad.F0);
% title('distribution of F0 of state Sad');
% 
% % Sad Gaussian fit
% [fitSadResult.F0, ~, xTemp, yTemp] = GaussianFit(histSad.F0.centers, histSad.F0.counts);
% histSad.F0.average = fitSadResult.F0.b1;
% histSad.F0.deviation = sqrt(fitSadResult.F0.c1.^2 / 2);
% 
% hold on;
% plot(fitSadResult.F0, xTemp, yTemp);
% xlabel('base freqency / Hz');
% ylabel('show time');
% str = strcat('\mu : ', num2str(int64(histSad.F0.average)));
% text(70, max(yTemp), str);
% str = strcat('\sigma : ', num2str(int64(histSad.F0.deviation)));
% text(70, max(yTemp) - 2000, str);
% hold off;
% 
% 
% % Happy
% subplot(2,2,4);
% [histHappy.F0.counts, histHappy.F0.centers] = hist(purifiedHappy.F0);
% hist(purifiedHappy.F0);
% title('distribution of F0 of state Happy');
% 
% % Happy Gaussian fit
% [fitHappyResult.F0, ~, xTemp, yTemp] = GaussianFit(histHappy.F0.centers, histHappy.F0.counts);
% histHappy.F0.average = fitHappyResult.F0.b1;
% histHappy.F0.deviation = sqrt(fitHappyResult.F0.c1.^2 / 2);
% 
% hold on;
% plot(fitHappyResult.F0, xTemp, yTemp);
% xlabel('base freqency / Hz');
% ylabel('show time');
% str = strcat('\mu : ', num2str(int64(histHappy.F0.average)));
% text(20, max(yTemp), str);
% str = strcat('\sigma : ', num2str(int64(histHappy.F0.deviation)));
% text(20, max(yTemp) - 1000, str);
% hold off;





%% 



% Time distribution
figure;
subplot(2,2,1);
title('distribution of time of state Neutral');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedNeutral.Time,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedNeutral.Time,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('Time Duration (ms)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'NeutralTime';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedNeutral.Time, 'gamma');
histNeutral.Time.Shape = pd1.a;
histNeutral.Time.Scale = pd1.b;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitNeutralTime';

str1 = 'E(X): ';
str2 = 'Var(X): '; 

text(500, 4e-3, str1);
text(500, 3.5e-3, num2str(histNeutral.Time.Shape * histNeutral.Time.Scale));
text(500, 3e-3, str2);
text(500, 2.5e-3, num2str(histNeutral.Time.Shape * histNeutral.Time.Scale .^ 2));
axis tight;
% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;



% %% 

subplot(2,2,3);
title('distribution of time of state Sad');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedSad.Time,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedSad.Time,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('Time Duration (ms)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'SadTime';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedSad.Time, 'gamma');
histSad.Time.Shape = pd1.a;
histSad.Time.Scale = pd1.b;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
% text('Scale Factor', pd1.b);
% text('Shape Factor', pd1.a);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitSadTime';

text(1250, 2.5e-3, str1);
text(1250, 2e-3, num2str(histSad.Time.Shape * histSad.Time.Scale));
text(1250, 1.5e-3, str2);
text(1250, 1e-3, num2str(histSad.Time.Shape * histSad.Time.Scale .^ 2));
axis tight;
% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');



% %% 

subplot(2,2,2);
title('distribution of time of state Angry');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedAngry.Time,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedAngry.Time,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('Time Duration (ms)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'AngryTime';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedAngry.Time, 'gamma');
histAngry.Time.Shape = pd1.a;
histAngry.Time.Scale = pd1.b;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitAngryTime';


text(800, 3.5e-3, str1);
text(800, 3e-3, num2str(histAngry.Time.Shape * histAngry.Time.Scale));
text(800, 2.5e-3, str2);
text(800, 2e-3, num2str(histAngry.Time.Shape * histAngry.Time.Scale .^ 2));
axis tight;
% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');


% %% 
subplot(2,2,4);
title('distribution of time of state Happy');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedHappy.Time,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedHappy.Time,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('Time Duration (ms)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'HappyTime';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedHappy.Time, 'gamma');
histHappy.Time.Shape = pd1.a;
histHappy.Time.Scale = pd1.b;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitHappyTime';

text(800, 3e-3, str1);
text(800, 2.5e-3, num2str(histHappy.Time.Shape * histHappy.Time.Scale));
text(800, 2e-3, str2);
text(800, 1.5e-3, num2str(histHappy.Time.Shape * histHappy.Time.Scale .^ 2));
axis tight;
% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');

% subplot(2,2,2);
% [histAngry.Time.counts, histAngry.Time.centers] = hist(purifiedAngry.Time);
% hist(purifiedAngry.Time);
% title('distribution of time of state Angry');
% 
% phat = gamfit(histAngry.Time.counts);
% histAngry.Time.Shape = phat(1);
% histAngry.Time.Scale = phat(2);
% 
% subplot(2,2,3);
% [histSad.Time.counts, histSad.Time.centers] = hist(purifiedSad.Time);
% hist(purifiedSad.Time);
% title('distribution of time of state Sad');
% 
% phat = gamfit(histSad.Time.counts);
% histSad.Time.Shape = phat(1);
% histSad.Time.Scale = phat(2);
% 
% 
% subplot(2,2,4);
% [histHappy.Time.counts, histHappy.Time.centers] = hist(purifiedHappy.Time);
% hist(purifiedHappy.Time);
% title('distribution of time of state Happy');
% 
% phat = gamfit(histHappy.Time.counts);
% histHappy.Time.Shape = phat(1);
% histHappy.Time.Scale = phat(2);


%% 
figure;
subplot(2,2,1);
title('distribution of pow of state Neutral');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedNeutral.Pow,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedNeutral.Pow,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('Pow (dB)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'NeutralPow';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedNeutral.Pow, 'normal');
histNeutral.Pow.average = pd1.mean;
histNeutral.Pow.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitNeutralPow';

str1 = strcat('\mu : ', num2str(histNeutral.Pow.average));
text(-40, 0.1, str1);
str2 = strcat('\sigma : ', num2str(histNeutral.Pow.deviation));
text(-40, 0.08, str2);
axis tight;

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;




subplot(2,2,3);
title('distribution of pow of state Sad');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedSad.Pow,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedSad.Pow,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('Pow (dB)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'SadPow';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedSad.Pow, 'normal');
histSad.Pow.average = pd1.mean;
histSad.Pow.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitSadPow';

str1 = strcat('\mu : ', num2str(histSad.Pow.average));
text(-40, 0.1, str1);
str2 = strcat('\sigma : ', num2str(histSad.Pow.deviation));
text(-40, 0.08, str2);
axis tight;

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;



subplot(2,2,2);
title('distribution of pow of state Angry');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedAngry.Pow,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedAngry.Pow,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('Pow (dB)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'AngryPow';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedAngry.Pow, 'normal');
histAngry.Pow.average = pd1.mean;
histAngry.Pow.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitAngryPow';

str1 = strcat('\mu : ', num2str(histAngry.Pow.average));
text(-40, 0.1, str1);
str2 = strcat('\sigma : ', num2str(histAngry.Pow.deviation));
text(-40, 0.08, str2);
axis tight;

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;


subplot(2,2,4);
title('distribution of pow of state Neutral');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "NeutralTime"
[CdfF,CdfX] = ecdf(purifiedHappy.Pow,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(purifiedHappy.Pow,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','blue','EdgeColor','black',...
    'LineStyle','-', 'LineWidth',1);
xlabel('Pow (dB)');
ylabel('Density');
LegHandles(end+1) = hLine;
LegText{end+1} = 'HappyPow';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fitNeutralTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 2.677192820064, 70.10415967598])
pd1 = fitdist(purifiedHappy.Pow, 'normal');
histHappy.Pow.average = pd1.mean;
histHappy.Pow.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitHappyPow';

str1 = strcat('\mu : ', num2str(histHappy.Pow.average));
text(-40, 0.1, str1);
str2 = strcat('\sigma : ', num2str(histHappy.Pow.deviation));
text(-40, 0.08, str2);
axis tight;

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;


