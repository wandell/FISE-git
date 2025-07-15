%% fise_imageHarmonics
%

%%
ieInit;
fise_plotDefaults;

%%
x = linspace(-pi,pi,512);
[X,Y] = meshgrid(x,x);

%%
ieFigure;
tiledlayout(1,4);

nexttile;
fx = 2; fy = 0;
img = 1 + sin(2*fx*X + 2*fy*Y);
imagesc(x,x,img); colormap(gray);
axis off; axis image;

nexttile;
fx = 0; fy = 2;
img = 1 + sin(2*fx*X + 2*fy*Y);
imagesc(x,x,img); colormap(gray);
axis off; axis image;


nexttile;
fx = 2; fy = -2;
img = 1 + sin(2*fx*X + 2*fy*Y);
imagesc(x,x,img); colormap(gray);
axis off; axis image;

nexttile;
fx = 2; fy = 2;
img = 1 + sin(2*fx*X + 2*fy*Y);
imagesc(x,x,img); colormap(gray);
axis off; axis image;

%{
fname = fullfile(fiseRootPath,'chapters','images','optics','optics-harmonics.png');
exportgraphics(gcf,fname);
%}
%%

x = linspace(-pi,pi,64);
[X,Y] = meshgrid(x,x);
img = zeros(size(X));

ieFigure; axis off; axis image;
tiledlayout(3,4);
fy = 0;
for fx = 1:32
    img =  cos(2*fx*X + 2*fy*Y) + img;    
    imagesc(x,x,1 + img); colormap(gray);
    pause(0.5);
end

%%

x = linspace(-pi,pi,129);
[X,Y] = meshgrid(x,x);

% Initialize
fx = 0; fy = 0; imZero = cos(2*pi*(fx*X + fy*Y));

% First 10
tmp = zeros(size(imZero));
for fx = 1:10
 tmp = tmp + cos(2*pi*(fx*X + fy*Y));
end
imagesc(imZero + tmp);
plot(tmp(64,:));

% Next 20
for fx = 11:30
 tmp = tmp + cos(2*pi*(fx*X + fy*Y));
end
imagesc(imZero + tmp);
plot(tmp(64,:));

% Next until 128
for fx = 31:129
 tmp = tmp + cos(2*pi*(fx*X + fy*Y));
end
imagesc(imZero + tmp);
plot(tmp(64,:));



%{
fname = fullfile(fiseRootPath,'chapters','images','optics','optics-harmonics-1d.png');
exportgraphics(gcf,fname);
%}

%%


ieFigure;
tiledlayout(3,4);
fy = 0;
for cx = [1 0.5 0.1]
    for fx = [1 2 4 8]
        nexttile
        img = (1 + cx*sin(2*fx*X + 2*fy*Y))*128;
        image(x,x,img); colormap(gray);
        axis off; axis image;
    end
end

%{
fname = fullfile(fiseRootPath,'chapters','images','optics','optics-harmonics-1d.png');
exportgraphics(gcf,fname);
%}
