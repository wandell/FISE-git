%% fise_imageHarmonics
%

%%
ieInit;
fise_plotDefaults;

%%
x = linspace(-pi,pi,512);
[X,Y] = meshgrid(x,x);

%% optics-harmonics-2d
ieFigure;
tiledlayout(1,4);

nexttile;
fx = 2; fy = 0;
img = 1 + sin(2*fx*X + 2*fy*Y);
imagesc(x,x,img); colormap(gray);
axis off image tight

nexttile;
fx = 0; fy = 3;
img = 1 + sin(2*fx*X + 2*fy*Y);
imagesc(x,x,img); colormap(gray);
axis off image tight


nexttile;
fx = 2; fy = -4;
img = 1 + sin(2*fx*X + 2*fy*Y);
imagesc(x,x,img); colormap(gray);
axis off image tight

nexttile;
fx = 2; fy = 1;
img = 1 + sin(2*fx*X + 2*fy*Y);
imagesc(x,x,img); colormap(gray);
axis off image tight

%{
fname = fullfile(fiseRootPath,'chapters','images','optics','optics-harmonics.png');
exportgraphics(gcf,fname);
%}

%% optics-harmonics-1d

x = linspace(-pi,pi,64);
[X,Y] = meshgrid(x,x);
img = zeros(size(X));

ieFigure;
tiledlayout(3,4);
fy = 0;
for cx = [1 0.5 0.1]
    for fx = [1 2 4 8]
        nexttile
        img = (1 + cx*sin(2*fx*X + 2*fy*Y))*128;
        image(x,x,img); colormap(gray);
        axis off image tight
    end
end

%{
fname = fullfile(fiseRootPath,'chapters','images','optics','optics-harmonics-1d.png');
exportgraphics(gcf,fname);
%}

%% Sum of harmonics to create a 1D impulse at the origin

N = 129; % Number of samples in the vector

% 1. The discrete impulse vector

%    For DFT, an impulse at index 1 (n=0) leads to all-1 DFT coefficients
% discrete_impulse = zeros(1, N);
% discrete_impulse(1) = 1; % Impulse at the first element (n=0 for DFT indexing)

% 2. Compute the DFT coefficients of this impulse
%    For a unit impulse at n=0, its DFT coefficients are all 1s (scaled by 1/N depending on fft/ifft definition)
% DFT_coefficients = fft(discrete_impulse);

% If discrete_impulse(1)=1, then DFT_coefficients will be all ones (within machine precision).

% 3. Reconstruct the impulse using the inverse DFT formula (sum of complex exponentials)
%    We will explicitly sum them to show the perfect reconstruction.
%    Formula: x[n] = (1/N) * sum_{k=0 to N-1} (X[k] * exp(j*2*pi*k*n/N))
%    Here X[k] = 1 for all k.

reconstructed_impulse = zeros(1, N);

n_indices = 0:(N-1); % 0-indexed sample positions

for fx = 0:(N-1)
    % Add the current complex exponential component
    % Note: .* for element-wise multiplication across the n_indices vector
    % reconstructed_impulse = reconstructed_impulse + DFT_coefficients(k_freq + 1) * exp(1j * 2 * pi * k_freq * n_indices / N);
    % reconstructed_impulse = reconstructed_impulse + DFT_coefficients(k_freq + 1) * cos(2 * pi * k_freq * n_indices / N);
    reconstructed_impulse = reconstructed_impulse + cos(2 * pi * fx * n_indices / N);
end

reconstructed_impulse = reconstructed_impulse / N; % Apply the 1/N scaling factor

% 4. Adjust the plot domain to match your -pi to pi range
%    Map 0-indexed 'n_indices' to the X range.
%    The center of your 'X' is 0, which corresponds to the 'n' where the impulse should be (0 for ifft, (N+1)/2 for your 1-based linspace).
%    Let's use your original 'x' domain for plotting.
x_plot = linspace(-pi, pi, N);
% We need to circularly shift the reconstructed impulse to center it
reconstructed_impulse_shifted = circshift(reconstructed_impulse, [0, (N-1)/2]); % Shifts impulse from start to center

% --- Visualization ---
ieFigure;
plot(x_plot, real(reconstructed_impulse_shifted)); % Plot the real part (imaginary part will be tiny)
title(['Perfect Reconstruction of 1D Impulse (N=' num2str(N) ' terms)']);
xlabel('Spatial X-coordinate (radians)');
ylabel('Amplitude');
grid on;
axis tight;
ylim([-0.1 1.1]); % Set y-limits to clearly show 0s and 1 peak

fprintf('Maximum value of reconstructed impulse: %f\n', max(real(reconstructed_impulse_shifted)));
fprintf('Minimum value of reconstructed impulse (excluding peak): %f\n', min(real(reconstructed_impulse_shifted(real(reconstructed_impulse_shifted) < 0.5)))); % Check non-peak values

%% Make a 2D version reconstructing a line

N = 129; % Number of samples in the vector
x_plot = linspace(-pi, pi, N);

% 1. The discrete impulse vector

%    For DFT, an impulse at index 1 (n=0) leads to all-1 DFT coefficients
discrete_impulse = zeros(N, N);
discrete_impulse(:,65) = 1; % Impulse at the first element (n=0 for DFT indexing)

% 2. Compute the DFT coefficients of this impulse
%    For a unit impulse at n=0, its DFT coefficients are all 1s (scaled by 1/N depending on fft/ifft definition)
DFT_coefficients = fft2(discrete_impulse);

% If discrete_impulse(1)=1, then DFT_coefficients will be all ones (within machine precision).

% 3. Reconstruct the impulse using the inverse DFT formula (sum of complex exponentials)
%    We will explicitly sum them to show the perfect reconstruction.
%    Formula: x[n] = (1/N) * sum_{k=0 to N-1} (X[k] * exp(j*2*pi*k*n/N))
%    Here X[k] = 1 for all k.

reconstructed_impulse = zeros(N, N);

n_indices = 0:(N-1); % 0-indexed sample positions
n_indices2 = meshgrid(n_indices,n_indices);

ieFigure([],'wide'); colormap(gray);
tiledlayout(1,5)
for fx = 0:(N-1)
    % Add the current complex exponential component
    % Note: .* for element-wise multiplication across the n_indices vector
    % reconstructed_impulse = reconstructed_impulse + DFT_coefficients(k_freq + 1) * exp(1j * 2 * pi * k_freq * n_indices / N);
    % reconstructed_impulse = reconstructed_impulse + DFT_coefficients(k_freq + 1) * cos(2 * pi * k_freq * n_indices / N);
    reconstructed_impulse = reconstructed_impulse + cos(2 * pi * fx * n_indices2 / N);
    if fx == 4 || fx == 16 || fx == 64 || fx == 96 || fx == N-1
        nexttile;
        imagesc(x_plot,x_plot,circshift(reconstructed_impulse /(fx +1), [0, (N-1)/2]));
        axis image equal tight
        pause(1);
    end
end

%{
fname = fullfile(fiseRootPath,'chapters','images','optics','optics-reconstruction.png');
exportgraphics(gcf,fname);
%}

%%
%{
reconstructed_impulse = reconstructed_impulse / N; % Apply the 1/N scaling factor

% 4. Adjust the plot domain to match your -pi to pi range
%    Map 0-indexed 'n_indices' to the X range.
%    The center of your 'X' is 0, which corresponds to the 'n' where the impulse should be (0 for ifft, (N+1)/2 for your 1-based linspace).
%    Let's use your original 'x' domain for plotting.

% We need to circularly shift the reconstructed impulse to center it
reconstructed_impulse_shifted = circshift(reconstructed_impulse, [0, (N-1)/2]); % Shifts impulse from start to center

ieFigure;
imagesc(x_plot,x_plot,reconstructed_impulse_shifted);
colormap(gray)

fprintf('Maximum value of reconstructed impulse: %f\n', max(real(reconstructed_impulse_shifted(:))));
fprintf('Minimum value of reconstructed impulse (excluding peak): %f\n', min(real(reconstructed_impulse_shifted(real(reconstructed_impulse_shifted) < 0.5)))); % Check non-peak values
%}