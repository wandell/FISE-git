%%
fname = fullfile(isetRootPath,'data','lights','solar','solarSpectrum.mat');

[solarSPD,solarWave,comment] = ieReadSpectra(fname);
fraunhoferLines = comment{4};

%% Plot the spectrum and a blackbody radiator

ieNewGraphWin;
plot(solarWave,solarSPD,'-k');
bb = blackbody(solarWave,5775);
bb = ieScale(bb,1);
hold on;
skip = 20;
plot(solarWave(1:skip:end,1),bb(1:skip:end),'or');

xlabel('Wave (nm)')
ylabel('Relative energy');
grid on;
%{
% I hunted for the closest blackbody radiator
for cTemp = 4500:250:6500
    bb = blackbody(solarSPD(:,1),cTemp);
    bb = ieScale(bb,1);
    hold on;
    plot(solarSPD(:,1),bb,':r');
end
%}

%% Compare with measurements out our window in California by Jeff DiCarlo

[dayPsych,pWave] = ieReadSpectra('DaylightPsychBldg');
dayPsychMean = ieScale(mean(dayPsych,2),1);

ieNewGraphWin;
plot(pWave,dayPsychMean,'sb-');
hold on;
plot(solarWave,solarSPD,'-k');
xlabel('Wave (nm)')
ylabel('Relative energy');
grid on;
%% Add Fraunhofer lines

fWave = cell2mat(fraunhoferLines(:,3));
dayPsychInterp = interp1(pWave,dayPsychMean,fWave);
solarSPDInterp = interp1(solarWave,solarSPD,fWave);
for ii=fSelect
    line([fWave(ii),fWave(ii)],[solarSPDInterp(ii) - 0.1,solarSPDInterp(ii) + 0.1],'Color',[0.3 0.3 0.2]);
    hold on;
end

% Set limit to visible range
set(gca,'xlim',[380 750]);

%%  Does the spectrum we measured fall close to the CIE daylight model?

% Load the CIE standard
cieDaylightBasis = ieReadSpectra('cieDaylightBasis',pWave);

% Show the daylight bases.  These are not orthonormal.
ieNewGraphWin;
plot(pWave,cieDaylightBasis);
grid on; xlabel('Wave (nm)'); ylabel('Relative energy');
xaxisLine;

%% Find the best fit to our data from the cieDaylightBasis
%
% dayPsychMean = cieDaylightBasis*wgts
wgts = pinv(cieDaylightBasis)*dayPsychMean;

% It seems like the wave might be off by about 2 nm between our
% measurements and the standard. So, I shifted the plot.
ieNewGraphWin;
plot(pWave,dayPsychMean,'k--');
hold on;
plot(pWave+2,cieDaylightBasis*wgts,'ro');

% The error in percent.  Without shifting.
str = sprintf('RMSE: %0.1f percent\n',rmse(dayPsychMean,cieDaylightBasis*wgts)*100);
text(650,1,str,'FontSize',16);
grid on;
xlabel('Wave (nm)')
ylabel('Relative energy');
%%