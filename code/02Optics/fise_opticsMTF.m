%% FISE_MTF
%
% Illustrate the MTF.
% 
% Create a sweep frequency in the scene.  The scene is constant as the
% frequency increases.
% 
% Pass the scene through the optics. The amplitude decreases as
% frequency increases. 
%
% The ratio of the scene amplitude to the optical image amplitude is
% the frequency dependent scale factor $s_f$. A good approximation is
% shown by the red curve, which is the upper envelope of the sweep
% frequency in the optical image.
%
% See also
%   

%%
ieInit;

%%
imSize = [256, 1024]; % row,col
maxF = 50;     % cyc/image
wave = 550;    % nm
yContrast = ones(1,imSize(1));

scene = sceneCreate('sweep frequency',imSize,maxF,wave,yContrast);
scene = sceneSet(scene,'fov',5);

plotScene(scene,'luminance hline rgb',[1,round(imSize(1) / 2)]);

set(gcf,'Units','normalized'); 
set(gcf,'Position',[ 0.01    0.5    0.6    0.4]);

exportgraphics(gca,'scenesweep.png');

%%
oi = oiCreate("default");
oi = oiCompute(oi,scene,'crop',true);
% oiWindow(oi);

udata = plotOI(oi,'illuminance hline rgb',[1,round(imSize(1) / 2)]);
set(gcf,'Units','normalized'); 
set(gcf,'Position',[ 0.01    0.5    0.6    0.4]);

[upperEnvelope, lowerEnvelope] = envelope(-1*udata.data,5,'peak'); 
hold on;
plot(udata.pos,-1*upperEnvelope,'r-');

exportgraphics(gca,'oisweep.png');

%% END