%% Image of the point spread on the cone mosaic

% sceneCreate('pointArray',sz,spacing,spectralType);
scene = sceneCreate('point array',256,96);
scene = sceneSet(scene,'h fov',0.3);
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
cm.plot('excitations',allE);
fname = fullfile(fiseRootPath,'chapters','images','human','02-encoding','conePSF-550.png');
exportgraphics(gcf,fname);
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
oiWindow(oi);

%%
cm = cMosaic;
allE = cm.compute(oi);

% Looking for another plotting method.  Asked NC.
cm.plot('excitations',allE);
fname = fullfile(fiseRootPath,'chapters','images','human','02-encoding','conePSF-480.png');
exportgraphics(gcf,fname);
%% Maybe Nicolas had a nice way to do this?

%{
wavelength = 550;
psfRangeArcMin = 30;

% The cmosaic needs to be hex type?
visualizePSF(oi,wavelength,psfRangeArcMin,'withSuperimposedMosaic',cm)
%}
