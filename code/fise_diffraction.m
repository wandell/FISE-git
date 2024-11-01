%% After Cruikshank
%
% Not quite right, but getting there.
%
%

% Pinhole diameter (meters)
D = (300:50:1200)*1e-6;   % 100 microns to 1 mm


% wave (meters)
w = 400*1e-9;   % 550 nm

%  Airy disk diameter (meters)
d = 2.44 * (w ./ D);
% d = d*1e6;  % microns

% When does the size of the pinhole diameter, D, meet the size of the
% Airy disk diameter, d?
D = D*1e6;
d = d*1e6;

%%
ieNewGraphWin;
plot(D,d,'o');   % Pinhole diameter, disk diameter
hold on; 
plot(D,D,'-');
xlabel('Pinhole diameter (um)')
ylabel('Airy disk diameter (um)');
grid on;
identityLine;

%%