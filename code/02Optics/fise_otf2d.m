%% fise_otf2d

%%
ieInit;

%%
params = harmonicP;
params.freq = 8;
params.row = 33; params.col = 33;
scene = sceneCreate('harmonic',params);
scene = sceneSet(scene,'fov',1);
sceneWindow(scene);

%%
fx = sceneGet(scene,'f support x');
fullFx = [-1*fliplr(fx), fx];

fy = sceneGet(scene,'f support y');
fullFy = [-1*fliplr(fy), fy];

x = sceneGet(scene,'spatial support x','deg');
y = sceneGet(scene,'spatial support y','deg');

%%
img = sceneGet(scene,'luminance');
imgF = fft2(img);

ieFigure;
tiledlayout(2,2)

nexttile
imagesc(x,y,img); axis image
xlabel('Position (deg)'); ylabel('Position (deg)');
nexttile;
imagesc(fullFx,fullFy,abs(fftshift(imgF))); 
axis equal; axis image; colormap(gray);
set(gca, 'Color', 'k'); % Set background color to black
grid on; % Turn on the grid
ax = gca; % Get current axes
ax.GridColor = [0.7 0.7 0.7]; % Set grid color to dark gray
ax.GridLineStyle = '-'; % Set grid line style
ax.LineWidth = 3; % Set grid line thickness
xlabel('Frequency (cyc/deg');
ylabel('Frequency (cyc/deg');

%%
params.ang = 45;
[scene,parms] = sceneCreate('harmonic',params);
scene = sceneSet(scene,'fov',1);
img = sceneGet(scene,'luminance');
imgF = fft2(img);

nexttile
imagesc(x,y,img); axis image; 
xlabel('Position (deg)'); ylabel('Position (deg)');
nexttile;
imagesc(fullFx,fullFy,abs(fftshift(imgF))); 
axis equal; axis image; colormap(gray);
set(gca, 'Color', 'k'); % Set background color to black
grid on; % Turn on the grid
ax = gca; % Get current axes
ax.GridColor = [0.7 0.7 0.7]; % Set grid color to dark gray
ax.GridLineStyle = '-'; % Set grid line style
ax.LineWidth = 3; % Set grid line thickness
xlabel('Frequency (cyc/deg');
ylabel('Frequency (cyc/deg');

%%