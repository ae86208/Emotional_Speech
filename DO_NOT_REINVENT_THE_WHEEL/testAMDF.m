%% File path set and initialization
% designate the destination of the path of training set
clear;clc;

filePath = 'F:\Working_stuff\毕设\情感语音\情感语音';

filePathAngry = strcat(filePath, '\生气\');
filePathHappy = strcat(filePath, '\高兴\');
filePathNeutral = strcat(filePath, '\中性\');
filePathSad = strcat(filePath, '\悲伤\');

addpath(filePathAngry, filePathHappy, filePathNeutral, filePathSad);


%% 
amdfSadBase_freq = [];
amdfNeutralBase_freq = [];
amdfAngryBase_freq = [];
amdfHappyBase_freq = [];

for k = 201:250
    % Sad
    fileSadTemp = strcat(filePathSad, num2str(k), '.wav');
    [stream, fs] = audioread(fileSadTemp);
    amdfSadBase_freq = [amdfSadBase_freq W_AMDF1(stream, fs)];
    
    % Neutral
    fileNeutralTemp = strcat(filePathNeutral, num2str(k), '.wav');
    [stream, fs] = audioread(fileNeutralTemp);
    amdfNeutralBase_freq = [amdfNeutralBase_freq W_AMDF1(stream, fs)];
    
    % Angry
    fileAngryTemp = strcat(filePathAngry, num2str(k), '.wav');
    [stream, fs] = audioread(fileAngryTemp);
    amdfAngryBase_freq = [amdfAngryBase_freq W_AMDF1(stream, fs)];
    
    % Happy
    fileHappyTemp = strcat(filePathHappy, num2str(k), '.wav');
    [stream, fs] = audioread(fileHappyTemp);
    amdfHappyBase_freq = [amdfHappyBase_freq W_AMDF1(stream, fs)];
end

save amdfSadBase_freq.mat amdfSadBase_freq;
save amdfNeutralBase_freq.mat amdfNeutralBase_freq;
save amdfHappyBase_freq.mat amdfHappyBase_freq;
save amdfAngryBase_freq.mat amdfAngryBase_freq;
% figure;
% hist(base_freq);

%% 
clear;
clc;

load amdfAngryBase_freq.mat;
load amdfHappyBase_freq.mat;
load amdfSadBase_freq.mat;
load amdfNeutralBase_freq.mat;

figure;

subplot(2,2,3);
title('distribution of F0 of state Sad with AMDF');
hold on;
LegHandles = []; LegText = {};

% --- Plot data originally in dataset "purifiedSad.F0"
[CdfF,CdfX] = ecdf(amdfSadBase_freq,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(amdfSadBase_freq,[],[],BinInfo,CdfF,CdfX);
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

% --- Create fit "fitSadF0"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:

pd1 = fitdist(amdfSadBase_freq', 'normal');
histSad.F0.average = pd1.mean;
histSad.F0.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitSadF0';

str1 = strcat('\mu : ', num2str(histSad.F0.average));
text(50, 0.007, str1);
str2 = strcat('\sigma : ', num2str(histSad.F0.deviation));
text(50, 0.005, str2);
% axis([0, 600, 0, 8e-3]);
% axis tight;
axis([0, 600, 0, 0.008]);


% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;



% F0 of Neutral with AMDF
subplot(2,2,1);
title('distribution of F0 of state Neutral with AMDF');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "purifiedSad.F0"
[CdfF,CdfX] = ecdf(amdfNeutralBase_freq,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(amdfNeutralBase_freq,[],[],BinInfo,CdfF,CdfX);
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

% --- Create fit "fitSadF0"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:

pd1 = fitdist(amdfNeutralBase_freq', 'normal');
histNeutral.F0.average = pd1.mean;
histNeutral.F0.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitNeutralF0';

str1 = strcat('\mu : ', num2str(histNeutral.F0.average));
text(50, 7e-3, str1);
str2 = strcat('\sigma : ', num2str(histNeutral.F0.deviation));
text(50, 5e-3, str2);
axis([0, 600, 0, 8e-3]);

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;



subplot(2,2,2);
title('distribution of F0 of state Angry with AMDF');
hold on;
LegHandles = []; LegText = {};

% --- Plot data originally in dataset "purifiedSad.F0"
[CdfF,CdfX] = ecdf(amdfAngryBase_freq,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(amdfAngryBase_freq,[],[],BinInfo,CdfF,CdfX);
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

% --- Create fit "fitSadF0"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:

pd1 = fitdist(amdfAngryBase_freq', 'normal');
histAngry.F0.average = pd1.mean;
histAngry.F0.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitAngryF0';

str1 = strcat('\mu : ', num2str(histAngry.F0.average));
text(50, 7e-3, str1);
str2 = strcat('\sigma : ', num2str(histAngry.F0.deviation));
text(50, 5e-3, str2);
% axis([0, 600, 0, 8e-3]);
% axis tight;
axis([0, 600, 0, 0.008]);


% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;



% F0 of Neutral with AMDF
subplot(2,2,4);
title('distribution of F0 of state Happy with AMDF');
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "purifiedSad.F0"
[CdfF,CdfX] = ecdf(amdfHappyBase_freq,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(amdfHappyBase_freq,[],[],BinInfo,CdfF,CdfX);
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

% --- Create fit "fitSadF0"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:

pd1 = fitdist(amdfHappyBase_freq', 'normal');
histHappy.F0.average = pd1.mean;
histHappy.F0.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitHappyF0';

str1 = strcat('\mu : ', num2str(histHappy.F0.average));
text(50, 7e-3, str1);
str2 = strcat('\sigma : ', num2str(histHappy.F0.deviation));
text(50, 5e-3, str2);
axis([0, 600, 0, 8e-3]);

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;