clear
clc
close all
%%
% USER-DEFINED PARAMETERS
filename = 'data.2d';
filedir = 'Z:\Data\JYU\CPMG (summer 2017)\20July\IvoryBlack_slide1\';

nMeas = 60;
G = 23.87; %T/m
zf = 1; %levels of zero-filling

omitEchoes = 0; %front-end echoes to omit
guess = [0 0.003 0.08]; %[y-offset, amplitude, T2 in s]

t0 = datetime('20-Jul-2017 16:55:00');
tEnd = datetime('21-Jul-2017 5:31:00');
% END USER-DEFINED PARAMETERS

tElapsed = tEnd - t0;

measT = linspace(t0,tEnd,nMeas);

gamma = 42.576;                     % MHz T-1
gammaRad = gamma*2*pi*1e6;          % rad s-1 T-1
M=0;



%%
for nn = 1:nMeas
    fileloc = strcat(filedir,num2str(nn-1),'/',filename);
    parloc  = strcat(filedir,num2str(nn-1),'/','acqu.par');
    
    [ap,spec] = readKea4d(fileloc);
    tE = readpar_Kea(parloc,'echoTime')*1e-6;
    tD = readpar_Kea(parloc,'dwellTime')*1e-6;
    nrEchoes = ap.yDim;
    nrPts = ap.xDim;
    
    T = tD;                             % Sample time
    Fs = 1/T;                           % Sampling frequency
    L = (nrPts)*(2^zf);          % Length of signal
    NFFT = 2^nextpow2(L);               % Next power of 2 from length of y
    
    t = (-(L-1)/2:L/2)*T;               % Time vector
    f = linspace(-Fs/2,Fs/2,NFFT);      % Hz
    z = f/(gamma*G);                    % um, 280.47 Hz/um (for PM25)

    echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
    spec2d = reshape(spec,nrPts,nrEchoes);
    spec2d = spec2d(:,omitEchoes+1:end);
    
    FTdat = padarray(spec2d, size(spec2d(:,1),1)/2*((2^zf)-1),0); % Pad with 0's

    FTT2 = (fftshift(fft(FTdat,NFFT)/L, 1)); % Performs FFT algorithm
    
    signalSum(:,nn) = abs(sum(FTT2,2));
    
  
    
    for ll = 1:L
         figure(1)
         subplot(ceil(sqrt(L)),ceil(sqrt(L)),ll)
         plot(echoVec,abs(FTT2(ll,:)))
         %M = abs(FTT2(ll,:));
         
        
         %[beta,R,J,~] = nlinfit(echoVec,abs(FTT2(ll,:)), @t2monofit, guess);
         %ci = nlparci(beta,R,'jacobian',J);
         %guess = beta;
         %coeffs(ll,:) = beta;
    end
    
    

end
%%
close all

hh = figure(2);
hold on
surf(measT,z,signalSum)
set(gca,'YDir','reverse')
shading interp
ylim([-400 400])
xlabel('time')
ylabel('z [um] (<0 topspace)')
title(strcat('FT time series, time interval = ',datestr(measT(2)-measT(1),'MM'),':',datestr(measT(2)-measT(1),'SS')))
pubgraph(hh,14,1,'w','Arial')