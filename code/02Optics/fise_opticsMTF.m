%[text] # FISE\_MTF
%[text] Illustrate how to measure the MTF from some experimental measuresments.
ieInit;
%%

imSize = [128, 1024]; % row,col
maxF = 50;     % cyc/image
wave = 550;    % nm

scene = sceneCreate('sweep frequency',imSize,maxF,wave);
scene = sceneSet(scene,'fov',1);

sceneWindow(scene);
%%
oi = oiCreate("default");
oi = oiCompute(oi,scene);
oiWindow(oi);

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
