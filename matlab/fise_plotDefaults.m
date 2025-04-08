%% FISE Defaults

% Maybe I should try 'Helvetica'

% Set default Axes properties on the graphics root (groot)
set(groot, 'DefaultAxesFontName', 'Georgia');
set(groot, 'DefaultAxesFontSize', 16);
set(groot, 'DefaultAxesBox', 'off');
set(groot, 'DefaultAxesTickDir', 'out');
set(groot, 'DefaultAxesLineWidth', 1.2);
set(groot, 'DefaultAxesXColor', [0.3 0.3 0.3]);
set(groot, 'DefaultAxesYColor', [0.3 0.3 0.3]);

% --- Optional: Set related font defaults for consistency ---
% Axes title, labels, legends, and text objects often use Text properties
set(groot, 'DefaultTextFontName', 'Georgia');
set(groot, 'DefaultTextFontSize', 12); % Match axes font size or adjust
set(groot, 'DefaultTextColor', [0.3 0.3 0.3]); % Match axis color

% Legend properties (can also inherit from Text, but can be set explicitly)
set(groot, 'DefaultLegendFontName', 'Georgia');
set(groot, 'DefaultLegendFontSize', 11); % Slightly smaller is common
set(groot, 'DefaultLegendTextColor', [0.2 0.2 0.2]);
set(groot, 'DefaultLegendBox', 'off'); % Default legend box off

%% This test is failing.  Will try rebooting.

%{
% Ensure the default is set (or reset it)
set(groot, 'DefaultAxesTickDir', 'out');
disp(['Default TickDir is: ', get(groot, 'DefaultAxesTickDir')]); % Verify again

% Create a completely new figure and simple plot
figure;
plot(1:10);
title('Minimal Test Plot');

% Get the handle of the *current* axes and check its actual property
ax_test = gca;
actual_tickdir = get(ax_test, 'TickDir') % Or use ax_test.TickDir
%}