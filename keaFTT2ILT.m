clear
clc
close all

% USER-DEFINED PARAMETERS
filedir = 'Z:\Data\MRB\CPMG\17_July_2017_100%PEGDA_2%HCPK_1%PPh3\100%_30s_Slide4\3\';
filetitle = '30 s, 100 pwr, 1PPh3';

filename = 'data.2d';
omitEchoes = 0; %front-end echoes to omit
G = 23.87; %T/m
zf = 2; %levels of zero-filling
alpha = 1e8;
T2lims = [1e-4 1e1];
ILTpoints = 25;
poslims = [-35 35];
% END USER-DEFINED PARAMETERS


fileloc = strcat(filedir,filename);
parloc  = strcat(filedir,'acqu.par');

[ap,spec] = readKea4d(fileloc);
tE = readpar_Kea(parloc,'echoTime')*1e-6;
tD = readpar_Kea(parloc,'dwellTime')*1e-6;
nrEchoes = ap.yDim;
nrPts = ap.xDim;

nILTpts = min((nrEchoes-omitEchoes),ILTpoints);
echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
spec2d = reshape(spec,nrPts,nrEchoes);
spec2d = spec2d(:,omitEchoes+1:end);

gamma = 42.576;                     % MHz T-1
gammaRad = gamma*2*pi*1e6;          % rad s-1 T-1

T = tD;                             % Sample time
Fs = 1/T;                           % Sampling frequency 
L = (nrPts)*(2^zf);          % Length of signal
NFFT = 2^nextpow2(L);               % Next power of 2 from length of y

t = (-(L-1)/2:L/2)*T;               % Time vector
f = linspace(-Fs/2,Fs/2,NFFT);      % Hz
z = f/(gamma*G);                    % um, 280.47 Hz/um (for PM25)


FTdat = padarray(spec2d, size(spec2d(:,1),1)/2*((2^zf)-1),0); % Pad with 0's

FTT2 = (fftshift(fft(FTdat,NFFT)/L, 1)); % Performs FFT algorithm
ILTspec = zeros(nILTpts,L);

for jj = 1:L
    [ILTspec(:,jj), tau, ~] = upnnlsmooth1D(abs(FTT2(jj,:)'), echoVec', T2lims(1), T2lims(2), alpha, -1, nILTpts, 'exp(-h/T)');
end


%%
% Plot CHIRP results
hh = figure(1);
set(gcf,'Position',[680 580 940 400])
subplot(1,2,2)
surf(z,tau,ILTspec)
shading interp
set(gca,'YScale','log')
view([90 -90])
xlabel('position [um]')
ylabel('T2 [s]')
yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
xlim(poslims)
title(filetitle)
ylim([min(tau) max(tau)])
subplot(1,2,1)
surf(z,1000*echoVec,abs(FTT2)')
shading interp
ylim([0 1000*max(echoVec)])
view([90 -90])
xlabel('position [um]')
xlim(poslims)
ylabel('time domain [ms]')

pubgraph(hh,14,1,'w','Arial')

print(strcat(filedir,filetitle,'.png'),'-dpng')