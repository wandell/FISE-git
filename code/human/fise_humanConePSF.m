%% Image of the point spread on the cone mosaic

% sceneCreate('pointArray',sz,spacing,spectralType);
scene = sceneCreate('point array',128,32);
scene = sceneSet(scene,'h fov',0.3);
% sceneWindow(scene);

oi = oiCreate('human wvf');
oi = oiCompute(oi,scene);
% oiWindow(oi);

%% Default cone mosaic
cm = cMosaic;
allE = cm.compute(oi);

% Looking for another plotting method.  Asked NC.
cm.plot('excitations',allE);

%% How about changing the point SPD?

scene = sceneCreate('point array',256,64);
scene = sceneSet(scene,'h fov',0.3);
wave = sceneGet(scene,'wave');
monoWave = 450;
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

%% Maybe Nicolas had a nice way to do this?

%{
wavelength = 550;
psfRangeArcMin = 30;

% The cmosaic needs to be hex type?
visualizePSF(oi,wavelength,psfRangeArcMin,'withSuperimposedMosaic',cm)
%}
