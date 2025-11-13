%% Image of the point spread on the cone mosaic
%
% Not sure what I should set coneslinewidth parameter
%

%%
ieInit;
figsave = false;
activationMap = colormap('hot');

%% PSF:  Field height section
%
% Try 0, 2 deg and 6 deg eccentricities.
%
% I have noticed that in the periphery the spot sometimes ends up on a
% S-cone and very little response is visible.  A panel-tabset flipping
% through the eccentricities is pretty compelling.

% I need to figure out how to load a wvf for different eccentricities.

scene = sceneCreate('point array',256,96);
scene = sceneSet(scene,'h fov',0.3);

% I need to figure out how to load a wvf for different eccentricities.
eccDegs = [12 0; 6 0; 3 0; 0 0];
for ii=1:size(eccDegs,1)
    [oi, psf, support, zCoeffs, subjID] = oiPosition('Polans2015','position',eccDegs(ii,:));
    oi = oiCompute(oi,scene,'crop',false);
    % oiWindow(oi);

    cm = cMosaic('eccentricityDegs',eccDegs(ii,:),'sizeDegs',[0.4 0.4]);

    allE = cm.compute(oi);
    cm.plot('excitations', allE, 'label cones',false,...
        'domain','degrees', ...
        'plot title','Activation map',...
        'cones line width',1, ...
        'activation color map',activationMap);

    % This should work some day.
    % exportgraphics(gcf, fname, 'ContentType', 'vector');
    fname = sprintf('conePSF-%d-deg.svg',eccDegs(ii,1));
    fname = fullfile(fiseRootPath,'chapters','images','human','02-encoding',fname);
    if figsave, print(gcf,fname,'-dsvg'); end
end

%% Chromatic aberration section
%

% Let's check just outside the fovea
eccDegs = [2 0];
hfov = 0.5;

% sceneCreate('pointArray',sz,spacing,spectralType);
scene = sceneCreate('point array',256,96);
scene = sceneSet(scene,'h fov',hfov);
wave = sceneGet(scene,'wave');

% Make the scene monochromatic
monoWave = 550;
illEnergy = zeros(numel(wave),1);
illEnergy(wave==monoWave) = 1;
scene = sceneAdjustIlluminant(scene,illEnergy);
scene = sceneSet(scene,'mean luminance',100);
% sceneWindow(scene);

% Extract the oi for that wavelength
oi = oiPosition('Polans2015','position',eccDegs,'wave',monoWave);
oi = oiCompute(oi,scene,"crop",false);
% oiWindow(oi);

%% Default cone mosaic

cm = cMosaic('eccentricityDegs',eccDegs,'sizeDegs',[hfov hfov]*1.2);
allE = cm.compute(oi);

% Looking for another plotting method.  Asked NC.
cm.plot('excitations', allE, 'label cones',true,...
    'plot title','Activation map','cones line width',0.5, ...
    'activation color map',0.7*activationMap + 0.3*ones(size(activationMap)));

fname = fullfile(fiseRootPath,'chapters','images','human','02-encoding','conePSF-550.svg');

% This should work some day.
% exportgraphics(gcf, fname, 'ContentType', 'vector');
if figsave, print(gcf,fname,'-dsvg'); end

%% How about changing the point spectral power distribution?

scene = sceneCreate('point array',256,96);
scene = sceneSet(scene,'h fov',hfov);

wave = sceneGet(scene,'wave');
monoWave = 450;
illEnergy = zeros(numel(wave),1);
illEnergy(wave==monoWave) = 1;

scene = sceneAdjustIlluminant(scene,illEnergy);
scene = sceneSet(scene,'mean luminance',100);

% sceneWindow(scene);

oi = oiPosition('Polans2015','position',eccDegs,'wave',monoWave);
oi = oiCompute(oi,scene,"crop",true);
% oiWindow(oi);

%%
% cm = cMosaic;
allE = cm.compute(oi);

cm.plot('excitations', allE, 'label cones',true,...
    'plot title','Activation map','cones line width',0.5, ...
    'activation color map',activationMap);

fname = fullfile(fiseRootPath,'chapters','images','human','02-encoding','conePSF-480.svg');

% This should work some day.
% exportgraphics(gcf, fname, 'ContentType', 'vector');
if figsave, print(gcf,fname,'-dsvg'); end

%% END