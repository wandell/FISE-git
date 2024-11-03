%% After Cruikshank
%
% Not quite right, but getting there.
%
%

%% Basic calculation

% Pinhole diameter (meters)
pinholeD = (10:10:1200)*1e-6;   % 100 microns to 1 mm

% wave (meters)
wave = 400e-9;   % 

%  Airy disk diameter (meters)
diffractionDeg = asind(1.22*(wave ./ pinholeD));
if pinholeD(1) == 1e-4
    assert(abs(diffractionDeg(1) - 0.28) < 0.01)
end


% Radius size on a wall, L meters away
L = 0.01;

% tand(theta) = opp/adj;
% Agrees with chatGPT calculation for 100 micron pinhole images at 1 m
% Units are meters
diffractionD = 2*L*tand(diffractionDeg);
if L==1 && pinholeD(1) == 1e-4
    assert(abs(diffractionD(1)/0.0098 - 1) < 0.01)
end


%% Plot the diffraction pattern size vs. pinhole
ieNewGraphWin;
unit = 'mm';
loglog(pinholeD*ieUnitScaleFactor(unit),diffractionD*ieUnitScaleFactor(unit),'-');
hold on;
loglog([0;pinholeD(:)]*ieUnitScaleFactor(unit),[0;pinholeD(:)]*ieUnitScaleFactor(unit),'k--');
xlabel(sprintf('Pinhole diameter (%s)',unit));
ylabel(sprintf('Diffraction diameter (%s)',unit));
grid on;


%% Cruikshank probably told us the radius, so 
%  He says they match when the pinhole diameter is about 0.5 mm
%  This calculation says they match when the pinhole diameter is 1 mm.
% All consistent.
%
% Now make the curves for different values of L and pinholeD

ieNewGraphWin;
unit = 'mm';

Lmeters = logspace(log10(0.005),log10(0.5),10);
for ii=1:numel(Lmeters)
    % Radius size on a wall, L meters away
    L = Lmeters(ii);
    diffractionD = 2*L*tand(diffractionDeg);
    p = loglog(pinholeD*ieUnitScaleFactor(unit),diffractionD*ieUnitScaleFactor(unit),'-');
    hold on;
    p.Color = [0 0 0];
end

xlabel(sprintf('Pinhole diameter (%s)',unit));
ylabel(sprintf('Diffraction diameter (%s)',unit));
loglog([0;pinholeD(:)]*ieUnitScaleFactor(unit),[0;pinholeD(:)]*ieUnitScaleFactor(unit),'k--');
grid on;
