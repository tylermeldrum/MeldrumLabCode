% Fourier-and-Laplace transform of sequential profile data.
% TKM, 21 Aug 2017

% Indicate user-defined parameters here, including directory, number of
% positions, step size for lift motion, ILT parameters and a file title for the figure.
% This section loads each position's CPMG data and Fourier transforms each
% echo to produce a spatially-resolved decay signal. If normOn = 1, the data will be normalized to a
% second reference file to account for spatially-variant coil sensitivity.
clear
clc
close all

% USER-DEFINED PARAMETERS
filedir = '/Volumes/ISC1026/Data/TKM/P250_Glass/FTProfile/';
numFiles = 6;
stepSize = -100;
filetitle = 'P250 glass [2014], CPMG FT profile';
poslims = [250 500];

filename = 'data.2d';
omitEchoes = 0; %front-end echoes to omit
G = 23.87; %T/m
zf = 2; %levels of zero-filling
alpha = 5e6;
T2lims = [2e-5 2e-3];
ILTpoints = 60;

normOn = 1;
normFile = '/Users/tyler/Google Drive/Data/NGA_Aug2017/Raw Data/Eraser/FTRefStandard/FT_eraserRef.mat';
% END USER-DEFINED PARAMETERS

for ll = 1:numFiles

fileloc = strcat(filedir,num2str(ll),'/',filename);
parloc  = strcat(filedir,num2str(ll),'/','acqu.par');

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
zchange = round((stepSize/(z(2)-z(1)))/2);

FTdat = padarray(spec2d, size(spec2d(:,1),1)/2*((2^zf)-1),0); % Pad with 0's

FTT2 = (fftshift(fft(FTdat,NFFT)/L, 1)); % Performs FFT algorithm

if normOn == 1
    load(normFile);
    FTT2 = FTT2./ref(:,2);
end

depthFTT2(ll,:,:) = FTT2;
end

%% ILT
%Following FT above, this section will stack together the FT data from each
%slice into one large dataset (position vs. decay time) across the entire
%sample thickness. Then each position is subject to ILT and a figure is
%produced.

for ll = 1:numFiles
    FTT2plot = abs(depthFTT2(ll,:,:));
    FTT2plot = reshape(FTT2plot,L,nrEchoes);
    FTT2plot = FTT2plot';
    FTT2use = FTT2plot(:,L/2+zchange-1:L/2-zchange);
    FTT2comb(ll,:,:) = FTT2use;
end
    FTT2comb = permute(FTT2comb,[2 3 1]);
    FTT2map = reshape(FTT2comb,nrEchoes,[]);

    depthAxis = linspace(0,numFiles*-stepSize,size(FTT2map,2));
    
ILTspec = zeros(nILTpts,size(FTT2map,2));

parfor jj = 1:size(FTT2map,2)
    [ILTspec(:,jj), ~, ~] = upnnlsmooth1D(FTT2map(:,jj), echoVec', T2lims(1), T2lims(2), alpha, -1, nILTpts, 'exp(-h/T)');
end


tau = logspace(log10(T2lims(1)), log10(T2lims(2)), ILTpoints);
hhh = figure(5);
surf(depthAxis,tau,ILTspec)
shading interp
set(gca,'YScale','log')
view([90 90])
xlabel('position [um]')
xlim(poslims);
ylabel('T2 [s]')
yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))

title(filetitle)
ylim([min(tau) max(tau)])
caxis([0 0.06])
pubgraph(hhh,14,1,'w','Arial')
print(strcat(filedir,filetitle,'.png'),'-dpng')

%%

[C,I] = max(ILTspec(1:end-10,:));
    
mm = figure(3);
hold on
surf(depthAxis,tau,ILTspec)
shading interp
view([90 90])
xlabel('position [um]')
xlim(poslims);
ylabel('T2 [s]')
yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
title(filetitle)
ylim([min(tau) max(tau)])
caxis([0 0.05])
plot3(depthAxis,tau(I),0.5*ones(1,length(C)),'-r')
set(gca,'YScale','log')
pubgraph(mm,14,1,'w','Arial')
print(strcat(filedir,filetitle,'_zoom.png'),'-dpng')

%%
nn = figure(2);
plot(depthAxis,ILTspec(round(nILTpts/2),:))
xlabel('position [um]')
xlim(poslims)
ylabel('intensity');
title(filetitle)
pubgraph(nn,14,1,'w','Arial')
% print(strcat(filedir,filetitle,'_slice.png'),'-dpng')


%%
% 
% hh = figure(1);
% % set(gcf,'Position',[680 580 940 400])
% 
% for ll = 1:numFiles
%     hold on
%     ILTplot = depthILT(ll,:,:);
%     ILTplot = reshape(ILTplot,nILTpts,L);
% %     subplot(ceil(numFiles/ceil(sqrt(numFiles))),ceil(sqrt(numFiles)),ll)
% if ll == numFiles
%     surf(depthz(ll,1:L/2-zchange+1),tau,ILTplot(:,1:L/2-zchange+1))
% elseif ll == 1
%     surf(depthz(ll,L/2+zchange:end),tau,ILTplot(:,L/2+zchange:end))
% elseif ll ~= 1 && ll ~= numFiles
%     surf(depthz(ll,L/2+zchange:L/2-zchange+1),tau,ILTplot(:,L/2+zchange:L/2-zchange+1))
% end
%     shading interp
%     set(gca,'YScale','log')
%     view([90 90])
%     xlabel('position [um]')
%     ylabel('T2 [s]')
%     yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
%     xlim(poslims)
%     title(filetitle)
%     ylim([min(tau) max(tau)])
%     caxis([0 0.3])
%     zlim([0 0.5])
% %     set(gca,'XDir','reverse')
%     % subplot(1,2,1)
%     % surf(z,1000*echoVec,abs(FTT2)')
%     % shading interp
%     % ylim([0 1000*max(echoVec)])
%     % view([90 -90])
%     % xlabel('position [um]')
%     % xlim(poslims)
%     % ylabel('time domain [ms]')
% end
% pubgraph(hh,14,1,'w','Arial')
% 
% % print(strcat(filedir,filetitle,'_noParafilm.png'),'-dpng')
% 
% %%
% % Plot CHIRP results
% gg = figure(2);
% % set(gcf,'Position',[680 580 940 400])
% 
% for ll = 1:numFiles
%     hold on
%     ILTplot = depthILT(ll,:,:);
%     ILTplot = reshape(ILTplot,nILTpts,L);
%     subplot(ceil(numFiles/ceil(sqrt(numFiles))),ceil(sqrt(numFiles)),ll)
%     surf(depthz(ll,:),tau,ILTplot)
% % if ll == numFiles
% %     surf(depthz(ll,1:L/2-zchange+1),tau,ILTplot(:,1:L/2-zchange+1))
% % elseif ll == 1
% %     surf(depthz(ll,L/2+zchange:end),tau,ILTplot(:,L/2+zchange:end))
% % elseif ll ~= 1 && ll ~= numFiles
% %     surf(depthz(ll,L/2+zchange:L/2-zchange+1),tau,ILTplot(:,L/2+zchange:L/2-zchange+1))
% % end
%     shading interp
%     set(gca,'YScale','log')
%     view([90 90])
%     xlabel('position [um]')
%     ylabel('T2 [s]')
%     yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
% %     xlim(poslims)
% %     set(gca,'XDir','reverse')
% %     title(filetitle)
%     ylim([min(tau) max(tau)])
%     caxis([0 0.5])
%     % subplot(1,2,1)
%     % surf(z,1000*echoVec,abs(FTT2)')
%     % shading interp
%     % ylim([0 1000*max(echoVec)])
%     % view([90 -90])
%     % xlabel('position [um]')
%     % xlim(poslims)
%     % ylabel('time domain [ms]')
% end
% pubgraph(gg,14,1,'w','Arial')
% 
% % print(strcat(filedir,filetitle,'2.png'),'-dpng')
% 
% %%
% nn = figure(4);
% 
% 
% % hh = figure(1);
% % set(gcf,'Position',[680 580 940 400])
% 
% for ll = 1:numFiles
%     hold on
%     FTT2plot = abs(depthFTT2(ll,:,:));
%     FTT2plot = reshape(FTT2plot,L,nrEchoes);
%     FTT2plot = FTT2plot';
% %     subplot(ceil(numFiles/ceil(sqrt(numFiles))),ceil(sqrt(numFiles)),ll)
% if ll == numFiles
%     surf(depthz(ll,1:L/2-zchange+1),echoVec,FTT2plot(:,1:L/2-zchange+1))
% elseif ll == 1
%     surf(depthz(ll,L/2+zchange:end),echoVec,FTT2plot(:,L/2+zchange:end))
% elseif ll ~= 1 && ll ~= numFiles
%     surf(depthz(ll,L/2+zchange:L/2-zchange+1),echoVec,FTT2plot(:,L/2+zchange:L/2-zchange+1))
% end
%     shading interp
% %     set(gca,'YScale','log')
%     view([90 90])
%     xlabel('position [um]')
%     ylabel('T2 [s]')
% %     yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
%     xlim(poslims)
%     title(filetitle)
% %     xlim([0 max(echoVec)])
% %     caxis([0 0.3])
% %     zlim([0 0.5])
% %     set(gca,'XDir','reverse')
%     % subplot(1,2,1)
%     % surf(z,1000*echoVec,abs(FTT2)')
%     % shading interp
%     % ylim([0 1000*max(echoVec)])
%     % view([90 -90])
%     % xlabel('position [um]')
%     % xlim(poslims)
%     % ylabel('time domain [ms]')
% end
% pubgraph(nn,14,1,'w','Arial')
% 
% % print(strcat(filedir,filetitle,'_noParafilm.png'),'-dpng')
% 
% %%
% % Plot CHIRP results
% oo = figure(4);
% % set(gcf,'Position',[680 580 940 400])
% 
% for ll = 1:numFiles
%     hold on
%     FTT2plot = abs(depthFTT2(ll,:,:));
%     FTT2plot = reshape(FTT2plot,L,nrEchoes);
%     FTT2plot= FTT2plot';
%     subplot(ceil(numFiles/ceil(sqrt(numFiles))),ceil(sqrt(numFiles)),ll)
%     surf(depthz(ll,:),echoVec,FTT2plot)
% % if ll == numFiles
% %     surf(depthz(ll,1:L/2-zchange+1),tau,ILTplot(:,1:L/2-zchange+1))
% % elseif ll == 1
% %     surf(depthz(ll,L/2+zchange:end),tau,ILTplot(:,L/2+zchange:end))
% % elseif ll ~= 1 && ll ~= numFiles
% %     surf(depthz(ll,L/2+zchange:L/2-zchange+1),tau,ILTplot(:,L/2+zchange:L/2-zchange+1))
% % end
%     shading interp
% %     set(gca,'YScale','log')
%     view([90 90])
%     xlabel('position [um]')
%     ylabel('T2 [s]')
% %     yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
% %     xlim(poslims)
%     xlim([400 2000])
% %     set(gca,'XDir','reverse')
% %     title(filetitle)
%     ylim([0 max(echoVec)])
% %     caxis([0 0.5])
%     % subplot(1,2,1)
%     % surf(z,1000*echoVec,abs(FTT2)')
%     % shading interp
%     % ylim([0 1000*max(echoVec)])
%     % view([90 -90])
%     % xlabel('position [um]')
%     % xlim(poslims)
%     % ylabel('time domain [ms]')
% end
% pubgraph(oo,14,1,'w','Arial')
% 
% % print(strcat(filedir,filetitle,'2.png'),'-dpng')
% 

    
    