clear
clc
close all

%%
% This is the file from the Kea spectrometer that you need to load. It
% reads in two columns: the first has the echo times in microseconds (us),
% and the second is the signal intensity at that point. You should select
% alpha manually, uaually between 1e6 and 1e10.

%
filename = 'data.2d';
filedir = 'Z:\Data\MTR\Paint\PhthaloBlue49.54%Slide3echotime60\1\';
omitEchoes = 0;
alpha = 1e8;
lowLim = 1e-5; %s
hiLim = 1e0;  %s
%

fileloc = strcat(filedir,filename);
parloc  = strcat(filedir,'acqu.par');

[ap,spec] = readKea4d(fileloc);
tE = readpar_Kea(parloc,'echoTime')*1e-6;
tD = readpar_Kea(parloc,'dwellTime')*1e-6;
nrEchoes = ap.yDim;
nrPts = ap.xDim;

echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
spec2d = reshape(spec,nrPts,nrEchoes);
spec2d = spec2d(:,omitEchoes+1:end);

nrILTSteps = min(128,length(echoVec));
realData = sum(abs(spec2d),1);

scatter(echoVec,realData)

kernel1 = 'exp(-h/T)';
[spectrum,tau] = upnnlsmooth1D(realData',echoVec',  lowLim, hiLim, alpha ,  -1,  nrILTSteps,kernel1);

spectrum = spectrum./sum(spectrum);

figure
hold on
yyaxis left
semilogx(tau,spectrum)
xlabel('T_2 time [s]')
ylabel('intensity [arb]')

yyaxis right
plot(tau,cumsum(spectrum))
ylim([0 1.05])
ylabel('integrated intensity')
set(gca,'XScale','log')


ILTout = [tau',spectrum'];

% save('ILTout.dat','ILTout','-ascii');