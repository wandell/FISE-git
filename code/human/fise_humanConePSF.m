%%

scene = sceneCreate('point array');
scene = sceneSet(scene,'h fov',0.3);
% sceneWindow(scene);

oi = oiCreate('human wvf');
oi = oiCompute(oi,scene);
oiWindow(oi);

%%
cm = cMosaic;
allE = cm.compute(oi);
cm.plot('excitations',allE);

%%
wavelength = 550;
psfRangeArcMin = 30;
visualizePSF(oi,wavelength,psfRangeArcMin,'withSuperimposedMosaic',cm)

