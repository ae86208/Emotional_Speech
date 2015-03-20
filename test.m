%% File path set and initialization
% designate the destination of the path of training set
clear;clc;

filePath = 'F:\Working_stuff\毕设\情感语音\情感语音';

filePathAngry = strcat(filePath, '\生气\');
filePathHappy = strcat(filePath, '\高兴\');
filePathNeutral = strcat(filePath, '\中性\');
filePathSad = strcat(filePath, '\悲伤\');

addpath(filePathAngry, filePathHappy, filePathNeutral, filePathSad);

% parameter settings for feature extration
defaultparams;
f0floor = 50;
f0ceil = 500;

%% 
base_freq = 0;
for k = 201:205
    fileSadTemp = strcat(filePathSad, num2str(k), '.wav');
    [stream, fs] = audioread(fileSadTemp);
    base_freq = [base_freq W_AMDF1(stream, fs)];
end
base_freq = base_freq(base_freq ~= 0);
% figure;
% hist(base_freq);

%% 

% F0 of Sad whth AMDF
% subplot(2,2,3);
figure;

subplot(2,2,2);
title('distribution of F0 of state Sad with AMDF');
hold on;
LegHandles = []; LegText = {};

% --- Plot data originally in dataset "purifiedSad.F0"
[CdfF,CdfX] = ecdf(base_freq,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 3;
BinInfo.nbins = 10;
[~,BinEdge] = internal.stats.histbins(base_freq,[],[],BinInfo,CdfF,CdfX);
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

pd1 = fitdist(base_freq', 'normal');
histSad.F0.average = pd1.mean;
histSad.F0.deviation = pd1.sigma;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitSadF0';

str1 = strcat('\mu : ', num2str(histSad.F0.average));
text(50, 0.013, str1);
str2 = strcat('\sigma : ', num2str(histSad.F0.deviation));
text(50, 0.011, str2);
% axis([0, 600, 0, 8e-3]);
% axis tight;
axis([0, 600, 0, 0.014]);


% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;



% F0 of Sad with STRAIGHT
subplot(2,2,1);
title('distribution of F0 of state Sad with STRAIGHT');
hold on;
LegHandles = []; LegText = {};

load purifiedSad.mat;

% --- Plot data originally in dataset "purifiedSad.F0"
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

% --- Create fit "fitSadF0"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:

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
axis([0, 600, 0, 8e-3]);

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;
