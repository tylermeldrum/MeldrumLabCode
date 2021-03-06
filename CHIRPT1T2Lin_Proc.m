clear
clc
close all

%%
% CHIRP params
% ===================================
% ===== User-defined paramaters =====
% ===================================

spectrometer = 'Tecmag'; %'Tecmag'

datadir = 'C:\CommonData\TKM\P250\';
datafile = 'P250_CHIRP_6_T1IR_10Mar2017_result';
noCHIRPfile = 'P250_noCHIRP_2_T1IR_8Mar2017_result';
filenameExt = '.tnt';


Pchirp = 0.100; % CHIRP Pulse Length (s)


sliceheight = 0.150; %mm
sliceoffset = 0.00; %mm
PreCPMGdelay = 40e-6; %s


nPts = 82; % # of acqu points
nEchoes = 32; % Echoes
tD = 2e-6; % dwell time (Tecmag shows correct dwell time for a complex point, no need to multiply by 2)
tE = 250; % Echotime (us)

omitEchoes = 0; %the number of echoes to skip
noisePoints = 5; %number of points at beginning and end of each acqu period for noise
omitPts = 0; %blank spectrometer points to skip

zf = 2;                             % levels of zero filling
apodize = 0;                        % Gaussian apodization on (1) or off (0)?
apofac = 5;                         % Amount of Apodization

% ===================================
% === END User-defined paramaters ===
% ===================================

if strcmp(spectrometer,'Tecmag')==1;
    G = 6.59;                           % T m-1, B0 field gradient
elseif strcmp(spectrometer,'Kea')==1;    
    G = 23.87;
end
    
gamma = 42.576;                     % MHz T-1
BWchirp = sliceheight*G*gamma*1000; % CHIRP bandwidth (Hz)
BWoffset = sliceoffset*G*gamma*1000; %CHIRP bandwidth offset (Hz)

T = tD;                             % Sample time
Fs = 1/T;                           % Sampling frequency 
L = (nPts-omitPts)*(2^zf);      % Length of signal
NFFT = 2^nextpow2(L);               % Next power of 2 from length of y

echoVec = (omitEchoes+1)*tE:tE:(nEchoes*tE);
t = (-(L-1)/2:L/2)*T;               % Time vector
f = -linspace(-Fs/2,Fs/2,NFFT);      % Hz

%/ I added a minus sign to the expression for f above, TKM, 14 March 2017.
%I'm still not sure what should happen with his with regards to making sure
%indices increase in parallel with real space (up is +z) because the
%gradient points down on the single-sided magnets. I think this correction
%makes things more consistent, but I need to think about it. /%

z = f/(gamma*G);                       % um, 280.47 Hz/um (for PM25)

ChirpTRange = (range(z)/(1000*sliceheight)*Pchirp);
ChirpTOverZ = ChirpTRange/range(z);
ChirpT = (z+sliceheight*500-sliceoffset*1000)*ChirpTOverZ;


%%
% Import CHIRP data

if strcmp(spectrometer,'Tecmag')==1;
    [ap , spec] = readTecmag4d(strcat(datadir,datafile,'.tnt'));
elseif strcmp(spectrometer,'Kea')==1;
    [ap , spec] = readKea4d(strcat(datadir,datafile,'.2d'));
end

% CHIRPdat = spec(1,:);
% spec = spec2(nnn, :);
CHIRPdat = reshape(spec, nPts, nEchoes);
CHIRPdat = CHIRPdat(1:(end-omitPts),omitEchoes+1:end);

%% SNR calc 
n1 = CHIRPdat(1:noisePoints,:);
n2 = CHIRPdat(nPts-noisePoints-omitPts:end,:);
n = cat(1,n1,n2);
n = reshape(n,1,(2*noisePoints+1)*(nEchoes-omitEchoes));
s = reshape(CHIRPdat,1,(nPts-omitPts)*(nEchoes-omitEchoes));

figure
hold on
plot(abs(n))
plot(abs(s))

S = max(abs(s));
N = rms(n);

SNR = S/N
SNR_perRtScans = SNR/sqrt(2*ap.ns)
%% Filter, apodize, zero-fill, and FT
pVec = 1:1:(nPts-omitEchoes);
filt = exp(-(pVec-(nPts-omitEchoes)/2).^2/((nPts-omitEchoes)/apofac)^2);
filt = repmat(filt',1,nEchoes);

if apodize == 1
    CHIRPdat = CHIRPdat .* filt;
end

CHIRPdat = padarray(CHIRPdat, size(CHIRPdat(:,1),1)/2*((2^zf)-1),0); % Pad with 0's

T1T2profiles = fftshift(fft(CHIRPdat,NFFT)/L, 1); % Performs FFT algorithm

%% Plot CHIRP-encoded data
figure(1)
subplot(1,2,1)
hold on
plot(t*1e6,real(CHIRPdat(:,1)));
xlabel('time [us]')

subplot(1,2,2)
hold on
plot(z,2*abs(T1T2profiles(:,1)),'LineWidth',1.5);
xlabel('real space [um]')
title('Plot of first T1T2 FFT Profile and Echo')

hold off
figure(2)
hold on
surf(abs(T1T2profiles));
shading flat;
title('Surface plot of T1T2 FFT Profiles')
hold off

%% No CHIRP load section
close all

if strcmp(spectrometer,'Tecmag')==1;
    [~ , spec] = readTecmag4d(strcat(datadir,noCHIRPfile,'.tnt'));
elseif strcmp(spectrometer,'Kea')==1;
    [~ , spec] = readKea4d(strcat(datadir,noCHIRPfile,'.2d'));
end

% [~,spec] = readTecmag4d(strcat(datadir,noCHIRPfile,'.tnt'));
data = reshape(spec,nPts,nEchoes);

% No CHIRP raw data and fft profiles
% data = spec2(2,:);
noCHIRPdat = reshape(data, nPts, nEchoes);
noCHIRPdat = noCHIRPdat(1:(end-omitPts),omitEchoes+1:end);
if apodize == 1
    noCHIRPdat = noCHIRPdat .* filt;
end

noCHIRPdat = padarray(noCHIRPdat, size(noCHIRPdat(:,1),1)/2*((2^zf)-1),0); % Pad with 0's

CPprofiles = fftshift(fft(noCHIRPdat,NFFT)/L,1);

%% Plot first T1-T2 profile and coil profile

figure(3)
subplot(1,2,1)
hold on
plot(t*1e6,real(noCHIRPdat(:,1)));
xlabel('time [us]')
subplot(1,2,2)
hold on
plot(z,2*abs(CPprofiles(:,1)),'LineWidth',1.5);
xlabel('real space [um]')
title('Plot of first T1T2 FFT Profile and Echo')
hold off

figure(4)
hold on
surf(abs(CPprofiles));
shading flat;
title('Surface plot of T1T2 FFT Profiles')
hold off


%% Coil sensitivity correction and plot first T1T2 profile and coil profile
ylims = [0 4];
echoIndex = 1; 

for k = 1:nEchoes-omitEchoes
    pcorr(:,k) = abs(CPprofiles(:,1));
end

T1T2profcorr = T1T2profiles./pcorr;

close all

figure(5)
hold on
plot(z,abs(CPprofiles(:,1))/max(abs(CPprofiles(:,1))),'linewidth',1,'color','k')
plot(z,abs(T1T2profiles(:,1))/max(abs(CPprofiles(:,1))),'linewidth',1,'color','r')
plot(z,abs(T1T2profcorr(:,echoIndex)),'linewidth',1.3,'color','b')
xlim([min(z), max(z)]);
ylim(ylims)
hold off

xlabel('{\it z} (um)','fontsize',12)
title('T1-T2 & coil profiles')
set(gca,'Fontsize',12,'linewidth',2)

%% Find Optimal data range with these figures

figure(8)
plot(abs(T1T2profiles(:,echoIndex)))
t1_fig7=Pchirp*((BWchirp+BWoffset)/2-f)/(BWchirp+BWoffset);

figure(7)
subplot(3,1,1)
plot(abs(T1T2profcorr(:,echoIndex)))
line([find(ChirpT==0) 0],ylims,'Color','k')
line([Pchirp Pchirp],ylims,'Color','k')
xlim([0 NFFT])
ylim(ylims)
xlabel('index')
set(gca,'XDir','reverse')
subplot(3,1,2)
hold on
plot(z,abs(T1T2profcorr(:,echoIndex)))
plot(z,abs(CPprofiles(:,1))/max(abs(CPprofiles(:,1))),'linewidth',0.5,'color','k')
plot(z,abs(T1T2profiles(:,1))/max(abs(CPprofiles(:,1))),'linewidth',0.5,'color','r')
line([-sliceheight*500+sliceoffset*1000 -sliceheight*500+sliceoffset*1000],ylims,'Color','k')
line([ sliceheight*500+sliceoffset*1000  sliceheight*500+sliceoffset*1000],ylims,'Color','k')
xlim([min(z), max(z)]);
ylim(ylims)
% set(gca,'XDir','reverse')
xlabel('position (\mum)')
subplot(3,1,3)
plot(ChirpT,abs(T1T2profcorr(:,echoIndex)))
line([0 0],ylims,'Color','k')
line([Pchirp Pchirp],ylims,'Color','k')
xlim([min(ChirpT), max(ChirpT)]);
ylim(ylims)
% set(gca,'XDir','reverse')
xlabel('effective recovery time [s])')

%% Data Range and Inversion

% manually select indices for data range and inversion (zero point)
minind= 229;
firstinvertedind = 277;
maxind = 305;

T1T2profiles2=zeros((maxind-minind+1),nEchoes-omitEchoes);

for ii = 1:nEchoes-omitEchoes;
%     [~,firstinvertedind] = min(abs(T1T2profcorr(minind:maxind,ii)));
%     firstinvertedind = firstinvertedind+minind-1;
    T1T2profiles2(1:firstinvertedind-minind+1,ii) = (abs(T1T2profcorr(minind:firstinvertedind,ii)));
    T1T2profiles2(firstinvertedind-minind+2:end,ii) = -(abs(T1T2profcorr(firstinvertedind+1:maxind,ii)));
end

% T1T2data=T1T2profiles2;
T1T2data=T1T2profiles2/max(max(abs(T1T2profiles2)));
t1 = 1000*(linspace(ChirpT(minind),ChirpT(maxind),maxind-minind+1));
%plot first T1 column
figure
scatter(t1,T1T2data(:,1),'linewidth',2)
xlabel('{\it t}_1 (ms)','fontsize',30)
title('T1-T2, first T1 column')
set(gca,'Fontsize',30,'linewidth',2)
% xlim([0 1000*Pchirp])
ylim([-1.1 1.1])

% cftool(t1,T1T2data(:,1))

%% surf of all T1-T2 Profiles
figure
surf(echoVec(:,1:end)*1000,t1,T1T2data(:,1:end)); 
shading flat;
colormap('jet');
% shading interp;
colorbar 
ylabel('{\it t}_1 (ms)'); 
xlabel('{\it t}_2 (ms)');
title('T1-T2 data')

%% Save data, display ILT Data params
close all

%Prepare 2D data
T1T2data2 = T1T2data(:,1:end);
% T1T2data2 = flipud(T1T2data2);

% Prepare T1 and T2 axes
vaxis = t1*1e-3; %s
% vaxis = rot90(vaxis,2);
T2axis = echoVec'/1e6;   %s

save(strcat(datadir,datafile, '.dat'), 'T1T2data2', '-ascii');
save(strcat(datadir,datafile,'_T2axis.dat'),'T2axis','-ascii')
save(strcat(datadir,datafile,'_vaxis.dat'),'vaxis','-ascii')


%UF Points [Min, Max, Inv; min(echoVec), max(echoVec), InvTime(min) [us], InvTime(max) [us], #echoes, #T1 points]
% sprintf('%f; %d %d %d; %.0f %.0f %.0f %.0f; %d %d',SNR, minind, maxind, firstinvertedind,  min(echoVec), max(echoVec), 1e6*min(t1), 1e6*max(t1), size(T1T2data,2), size(T1T2data,1))

fileID = fopen(strcat(datadir,'DataNotesAuto.txt'),'a');
fprintf(fileID,'%s: %f; %d %d %d; %.0f %.0f %.2f %.2f; %d %d\n',datafile, SNR, minind, maxind, firstinvertedind,  min(echoVec), max(echoVec), ChirpT(maxind)*1e3, ChirpT(minind)*1e3, size(T1T2data,2), size(T1T2data,1));
fclose(fileID);