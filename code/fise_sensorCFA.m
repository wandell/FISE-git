%% fise_sensorCFA
%
%
% Make a plot of a spectral channel 

sensor = sensorCreate('imX363');

sensorPlot(sensor,'ir filter');

sensorPlot(sensor,'color channels');

sensorPlot(sensor,'cfa image');

% sensorPlot(sensor,'cfa full');

sensorPlot(sensor,'pixel spectral qe');


