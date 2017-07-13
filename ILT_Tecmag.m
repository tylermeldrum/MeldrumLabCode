clear
clc
close all

%%
filename = 'Glycerol_CPMG_middle_12JUL2017_result.tnt'; %Input experiment file name
filedir = 'C:\CommonData\ADF\Summer 17\Gly Test\Gly CPMG\'; %Copy file path

alpha = 1e7;
lowLim = 1e-3; %s
hiLim = 1e0;  %s

tEcho = 700; %Echotime (us)
nEchoes = 128; %Number of echoes
omitpoints = 0;
nPts = 304; % Number of acquisition points
nPtsBlank = 0; %Don't touch
tD = 2e-6; %dwell time, (s)

%%%%%% DON'T CHANGE STUFF BELOW HERE%%%%%
fileloc = strcat(filedir,filename);
[ap,spec,spec2,spec3,spec4] = readTecmag4d(fileloc);

echoVector = (tEcho:tEcho:nEchoes*tEcho)*1e-6;

nrILTSteps = min(128,length(echoVector));

data = reshape(spec,nPts,nEchoes);
data = data((nPtsBlank+1):(nPts-nPtsBlank),:);
dataInt = sum(data,1);
dataIntRe = real(dataInt)./max(real(dataInt));
dataIntIm = imag(dataInt)./max(real(dataInt));

% scatter(echoVector,dataIntRe)

kernel1 = 'exp(-h/T)';

[spectrum,tau] = upnnlsmooth1D(dataIntRe',echoVector',  lowLim, hiLim, alpha ,  -1,  nrILTSteps,kernel1);

spectrum = spectrum./sum(spectrum);

figure(1)
hold on
% yyaxis left
plot(tau,spectrum)
set(gca,'Xscale','log')
xlabel('T_2 time [s]')
ylabel('intensity [arb]')

% yyaxis right
% plot(tau,cumsum(spectrum))
% ylim([0 1.05])
% ylabel('integrated intensity')
% set(gca,'XScale','log')


ILTout = [tau',spectrum'];

% save('ILTout.dat','ILTout','-ascii');