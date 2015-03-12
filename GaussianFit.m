function [fitresult, gof, xData, yData] = GaussianFit(ctrs, cnts)


[xData, yData] = prepareCurveData( ctrs, cnts );

% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
% opts.StartPoint = [116 155.85 100.345513954628];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% % Plot fit with data.
% figure( 'Name', 'happyTime' );
% h = plot( fitresult, xData, yData );
% legend( h, 'cnts vs. ctrs', 'happyTime', 'Location', 'NorthEast' );
% % Label axes
% xlabel ctrs
% ylabel cnts
% grid on


