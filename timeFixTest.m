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
purifiedAngry.F0 = [];
purifiedAngry.Time = [];
purifiedAngry.Pow = [];

% Happy
purifiedHappy.F0 = [];
purifiedHappy.Time = [];
purifiedHappy.Pow = [];

% Neutral
purifiedNeutral.F0 = [];
purifiedNeutral.Time = [];
purifiedNeutral.Pow = [];

% Sad
purifiedSad.F0 = [];
purifiedSad.Time = [];
purifiedSad.Pow = [];

for i= 1:50
    
    [idxAngry, purifiedTimeAngry, cntAngry] = time_calc(infoAngry{i}.vuv);
    [idxHappy, purifiedTimeHappy, cntHappy] = time_calc(infoHappy{i}.vuv);
    [idxNeutral, purifiedTimeNeutral, cntNeutral] = time_calc(infoNeutral{i}.vuv);
    [idxSad, purifiedTimeSad, cntSad] = time_calc(infoSad{i}.vuv);
    
    if cntAngry == cntHappy && cntHappy == cntNeutral && cntNeutral == cntSad
        purifiedAngry.Time = [purifiedAngry.Time; purifiedTimeAngry];
        purifiedHappy.Time = [purifiedHappy.Time; purifiedTimeHappy];
        purifiedNeutral.Time = [purifiedNeutral.Time; purifiedTimeNeutral];
        purifiedSad.Time = [purifiedSad.Time; purifiedTimeSad];
    end

end

avgAngTime = sum(purifiedAngry.Time)/length(purifiedAngry.Time);
avgNeuTime = sum(purifiedNeutral.Time)/length(purifiedNeutral.Time);
avgHapTime = sum(purifiedHappy.Time)/length(purifiedHappy.Time);
avgSadTime = sum(purifiedSad.Time)/length(purifiedSad.Time);

fprintf('The average time of Neutral is %.2f\n',avgNeuTime);
fprintf('The average time of Sad is %.2f\n',avgSadTime);
fprintf('The average time of Angry is %.2f\n',avgAngTime);
fprintf('The average time of Happy is %.2f\n',avgHapTime);

% figure;
% subplot(2,2,1);
% hist(purifiedNeutral.Time);
% title('The distribution of time of state Neutral');
% 
% subplot(2,2,3);
% hist(purifiedSad.Time);
% title('The distribution of time of state Sad');
% 
% subplot(2,2,2);
% hist(purifiedAngry.Time);
% title('The distribution of time of state Angry');
% 
% subplot(2,2,4);
% hist(purifiedHappy.Time);
% title('The distribution of time of state Happy');


%============================================================================================================================%
%============================================================================================================================%
% distribution of Time
figure;

% Time of Neutral
subplot(2,2,1);
title('distribution of time of state Neutral Fixed');
hold on;
LegHandles = []; LegText = {};

% --- Plot data originally in dataset "purifiedNeutral.Time"
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

text(600, 4e-3, str1);
text(600, 3.5e-3, num2str(histNeutral.Time.Shape * histNeutral.Time.Scale));
text(600, 3e-3, str2);
text(600, 2.5e-3, num2str(histNeutral.Time.Shape * histNeutral.Time.Scale .^ 2));
axis([0, 800, 0, 6e-3]);
% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
% legend off;



% Time of Sad
subplot(2,2,3);
title('distribution of time of state Sad Fixed');
hold on;
LegHandles = []; LegText = {};

% --- Plot data originally in dataset "purifiedSad.Time"
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

% --- Create fit "fitSadTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:

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

text(600, 4e-3, str1);
text(600, 3.5e-3, num2str(histSad.Time.Shape * histSad.Time.Scale));
text(600, 3e-3, str2);
text(600, 2.5e-3, num2str(histSad.Time.Shape * histSad.Time.Scale .^ 2));
axis([0, 800, 0, 6e-3]);
% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');



% Time of Angry
subplot(2,2,2);
title('distribution of time of state Angry Fixed');
hold on;
LegHandles = []; LegText = {};

% --- Plot data originally in dataset "purifiedAngry.Time"
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

% --- Create fit "fitAngryTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:

pd1 = fitdist(purifiedAngry.Time, 'gamma');
histAngry.Time.Shape = pd1.a;
histAngry.Time.Scale = pd1.b;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitAngryTime';

text(600, 4e-3, str1);
text(600, 3.5e-3, num2str(histAngry.Time.Shape * histAngry.Time.Scale));
text(600, 3e-3, str2);
text(600, 2.5e-3, num2str(histAngry.Time.Shape * histAngry.Time.Scale .^ 2));
axis([0, 800, 0, 6e-3]);
% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');



% Time of Happy
subplot(2,2,4);
title('distribution of time of state Happy Fixed');
hold on;
LegHandles = []; LegText = {};

% --- Plot data originally in dataset "purifiedHappy.Time"
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

% --- Create fit "fitHappyTime"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:

pd1 = fitdist(purifiedHappy.Time, 'gamma');
histHappy.Time.Shape = pd1.a;
histHappy.Time.Scale = pd1.b;
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fitHappyTime';

text(600, 4e-3, str1);
text(600, 3.5e-3, num2str(histHappy.Time.Shape * histHappy.Time.Scale));
text(600, 3e-3, str2);
text(600, 2.5e-3, num2str(histHappy.Time.Shape * histHappy.Time.Scale .^ 2));
axis([0, 800, 0, 6e-3]);
% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
