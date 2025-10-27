%% Image of the point spread on the cone mosaic
%
% Not sure what I should set coneslinewidth parameter
%

%% 
ieInit;

%% Field height section
%
% Not fully implemented.  Try 0, 2 deg and 6 deg for fun
% I have noticed that in the periphery the spot sometimes ends up on a
% s cone and very little response is visible.  A panel-tabset flipping
% through the eccentricities is pretty compelling.

% I need to figure out how to load a wvf for different eccentricities.

scene = sceneCreate('point array',256,96);
scene = sceneSet(scene,'h fov',0.3);

% I need to figure out how to load a wvf for different eccentricities.
oi = oiCreate('human wvf');
oi = oiCompute(oi,scene,'crop',false);
% oiWindow(oi);

cm = cMosaic('eccentricityDegs',[0 6],'sizeDegs',[0.5 0.5]);

allE = cm.compute(oi);
cm.plot('excitations', allE, 'label cones',true,'plot title','Activation map','cones line width',1);


%% Chromatic aberration section
% 
% Make point array scene

% sceneCreate('pointArray',sz,spacing,spectralType);
scene = sceneCreate('point array',256,96);
scene = sceneSet(scene,'h fov',0.2);
wave = sceneGet(scene,'wave');
monoWave = 550;
illEnergy = zeros(numel(wave),1); 
illEnergy(wave==monoWave) = 1; 
scene = sceneAdjustIlluminant(scene,illEnergy);

% sceneWindow(scene);

oi = oiCreate('human wvf');
oi = oiCompute(oi,scene);
% oiWindow(oi);

%% Default cone mosaic
cm = cMosaic;
allE = cm.compute(oi);

% Looking for another plotting method.  Asked NC.
cm.plot('excitations', allE, 'label cones',true,'plot title','Activation map','cones line width',1);

fname = fullfile(fiseRootPath,'chapters','images','human','02-encoding','conePSF-550.svg');
% exportgraphics(gcf,fname);
% exportgraphics(gcf, fname, 'ContentType', 'vector');
print(gcf,fname,'-dsvg');

%% How about changing the point SPD?

scene = sceneCreate('point array',256,96);
scene = sceneSet(scene,'h fov',0.3);
wave = sceneGet(scene,'wave');
monoWave = 480;
illEnergy = zeros(numel(wave),1); 
illEnergy(wave==monoWave) = 1; 
scene = sceneAdjustIlluminant(scene,illEnergy);
% sceneWindow(scene);

oi = oiCreate('human wvf');
oi = oiCompute(oi,scene);
% oiWindow(oi);

%%
cm = cMosaic;
allE = cm.compute(oi);

% Looking for another plotting method.  Asked NC.
cm.plot('excitations', allE, 'label cones',true,'plot title','Activation map','cones line width',1);

fname = fullfile(fiseRootPath,'chapters','images','human','02-encoding','conePSF-480.svg');
%exportgraphics(gcf,fname);
% exportgraphics(gcf, fname, 'ContentType', 'vector');
print(gcf,fname,'-dsvg');

%% Maybe Nicolas had a nice way to do this?

%{
wavelength = 550;
psfRangeArcMin = 30;

% The cmosaic needs to be hex type?
visualizePSF(oi,wavelength,psfRangeArcMin,'withSuperimposedMosaic',cm)
%}

%{
cm.visualize(... 
    'activation', allE, ...
    'labelConesInActivationMap', true, ...
     'conesLineWidth', 2.0);
%}