clear
clc
close all

% USER-DEFINED PARAMETERS
filedir = '/Users/tyler/Google Drive/Data/NGA_Aug2017/Raw Data/BigSandwich/P250_neat_TG_CPMGProfile/';
numFiles = 21;
stepSize = -100;
filetitle = 'P250 TG neat, CPMG FT profile';
poslims = [500 1800];

filename = 'data.2d';
omitEchoes = 0; %front-end echoes to omit
G = 23.87; %T/m
zf = 2; %levels of zero-filling
alpha = 1e6;
T2lims = [2e-5 2e-3];
ILTpoints = 35;

normOn = 1;
normFile = '/Users/tyler/Google Drive/Data/NGA_Aug2017/Raw Data/Eraser/FTRefStandard/FT_eraserRef.mat';
% poslims = [-35 35];
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


% % ILTspec = zeros(nILTpts,L);
% % 
% %     for jj = 1:L
% %         [ILTspec(:,jj), tau, ~] = upnnlsmooth1D(abs(FTT2(jj,:)'), echoVec', T2lims(1), T2lims(2), alpha, -1, nILTpts, 'exp(-h/T)');
% %     end
% %     
% % depthILT(ll,:,:) = ILTspec;
depthFTT2(ll,:,:) = FTT2;
% % depthz(ll,:) = z - (ll-1)*stepSize;

% mm = figure(3);
% subplot(ceil(numFiles/ceil(sqrt(numFiles))),ceil(sqrt(numFiles)),ll)
% surf(echoVec,z,abs(FTT2))
% zlim([0 0.5])
% caxis([0 0.5])
% ylim([-50 50])
% shading interp
% view([0 90])
% ylabel('position [um]')
% xlabel('time domain [ms]')

end

%%

hh = figure(1);
% set(gcf,'Position',[680 580 940 400])

for ll = 1:numFiles
    hold on
    ILTplot = depthILT(ll,:,:);
    ILTplot = reshape(ILTplot,nILTpts,L);
%     subplot(ceil(numFiles/ceil(sqrt(numFiles))),ceil(sqrt(numFiles)),ll)
if ll == numFiles
    surf(depthz(ll,1:L/2-zchange+1),tau,ILTplot(:,1:L/2-zchange+1))
elseif ll == 1
    surf(depthz(ll,L/2+zchange:end),tau,ILTplot(:,L/2+zchange:end))
elseif ll ~= 1 && ll ~= numFiles
    surf(depthz(ll,L/2+zchange:L/2-zchange+1),tau,ILTplot(:,L/2+zchange:L/2-zchange+1))
end
    shading interp
    set(gca,'YScale','log')
    view([90 90])
    xlabel('position [um]')
    ylabel('T2 [s]')
    yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
    xlim(poslims)
    title(filetitle)
    ylim([min(tau) max(tau)])
    caxis([0 0.3])
    zlim([0 0.5])
%     set(gca,'XDir','reverse')
    % subplot(1,2,1)
    % surf(z,1000*echoVec,abs(FTT2)')
    % shading interp
    % ylim([0 1000*max(echoVec)])
    % view([90 -90])
    % xlabel('position [um]')
    % xlim(poslims)
    % ylabel('time domain [ms]')
end
pubgraph(hh,14,1,'w','Arial')

% print(strcat(filedir,filetitle,'_noParafilm.png'),'-dpng')

%%
% Plot CHIRP results
gg = figure(2);
% set(gcf,'Position',[680 580 940 400])

for ll = 1:numFiles
    hold on
    ILTplot = depthILT(ll,:,:);
    ILTplot = reshape(ILTplot,nILTpts,L);
    subplot(ceil(numFiles/ceil(sqrt(numFiles))),ceil(sqrt(numFiles)),ll)
    surf(depthz(ll,:),tau,ILTplot)
% if ll == numFiles
%     surf(depthz(ll,1:L/2-zchange+1),tau,ILTplot(:,1:L/2-zchange+1))
% elseif ll == 1
%     surf(depthz(ll,L/2+zchange:end),tau,ILTplot(:,L/2+zchange:end))
% elseif ll ~= 1 && ll ~= numFiles
%     surf(depthz(ll,L/2+zchange:L/2-zchange+1),tau,ILTplot(:,L/2+zchange:L/2-zchange+1))
% end
    shading interp
    set(gca,'YScale','log')
    view([90 90])
    xlabel('position [um]')
    ylabel('T2 [s]')
    yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
%     xlim(poslims)
%     set(gca,'XDir','reverse')
%     title(filetitle)
    ylim([min(tau) max(tau)])
    caxis([0 0.5])
    % subplot(1,2,1)
    % surf(z,1000*echoVec,abs(FTT2)')
    % shading interp
    % ylim([0 1000*max(echoVec)])
    % view([90 -90])
    % xlabel('position [um]')
    % xlim(poslims)
    % ylabel('time domain [ms]')
end
pubgraph(gg,14,1,'w','Arial')

% print(strcat(filedir,filetitle,'2.png'),'-dpng')

%%
nn = figure(4);


% hh = figure(1);
% set(gcf,'Position',[680 580 940 400])

for ll = 1:numFiles
    hold on
    FTT2plot = abs(depthFTT2(ll,:,:));
    FTT2plot = reshape(FTT2plot,L,nrEchoes);
    FTT2plot = FTT2plot';
%     subplot(ceil(numFiles/ceil(sqrt(numFiles))),ceil(sqrt(numFiles)),ll)
if ll == numFiles
    surf(depthz(ll,1:L/2-zchange+1),echoVec,FTT2plot(:,1:L/2-zchange+1))
elseif ll == 1
    surf(depthz(ll,L/2+zchange:end),echoVec,FTT2plot(:,L/2+zchange:end))
elseif ll ~= 1 && ll ~= numFiles
    surf(depthz(ll,L/2+zchange:L/2-zchange+1),echoVec,FTT2plot(:,L/2+zchange:L/2-zchange+1))
end
    shading interp
%     set(gca,'YScale','log')
    view([90 90])
    xlabel('position [um]')
    ylabel('T2 [s]')
%     yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
    xlim(poslims)
    title(filetitle)
%     xlim([0 max(echoVec)])
%     caxis([0 0.3])
%     zlim([0 0.5])
%     set(gca,'XDir','reverse')
    % subplot(1,2,1)
    % surf(z,1000*echoVec,abs(FTT2)')
    % shading interp
    % ylim([0 1000*max(echoVec)])
    % view([90 -90])
    % xlabel('position [um]')
    % xlim(poslims)
    % ylabel('time domain [ms]')
end
pubgraph(nn,14,1,'w','Arial')

% print(strcat(filedir,filetitle,'_noParafilm.png'),'-dpng')

%%
% Plot CHIRP results
oo = figure(4);
% set(gcf,'Position',[680 580 940 400])

for ll = 1:numFiles
    hold on
    FTT2plot = abs(depthFTT2(ll,:,:));
    FTT2plot = reshape(FTT2plot,L,nrEchoes);
    FTT2plot= FTT2plot';
    subplot(ceil(numFiles/ceil(sqrt(numFiles))),ceil(sqrt(numFiles)),ll)
    surf(depthz(ll,:),echoVec,FTT2plot)
% if ll == numFiles
%     surf(depthz(ll,1:L/2-zchange+1),tau,ILTplot(:,1:L/2-zchange+1))
% elseif ll == 1
%     surf(depthz(ll,L/2+zchange:end),tau,ILTplot(:,L/2+zchange:end))
% elseif ll ~= 1 && ll ~= numFiles
%     surf(depthz(ll,L/2+zchange:L/2-zchange+1),tau,ILTplot(:,L/2+zchange:L/2-zchange+1))
% end
    shading interp
%     set(gca,'YScale','log')
    view([90 90])
    xlabel('position [um]')
    ylabel('T2 [s]')
%     yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))
%     xlim(poslims)
    xlim([400 2000])
%     set(gca,'XDir','reverse')
%     title(filetitle)
    ylim([0 max(echoVec)])
%     caxis([0 0.5])
    % subplot(1,2,1)
    % surf(z,1000*echoVec,abs(FTT2)')
    % shading interp
    % ylim([0 1000*max(echoVec)])
    % view([90 -90])
    % xlabel('position [um]')
    % xlim(poslims)
    % ylabel('time domain [ms]')
end
pubgraph(oo,14,1,'w','Arial')

% print(strcat(filedir,filetitle,'2.png'),'-dpng')

%%

clear FTT2use
clear FTT2comb

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
    
    %     
%     figure;
%     surf(FTT2map);
%     shading flat
ILTspec = zeros(nILTpts,size(FTT2map,2));

for jj = 1:size(FTT2map,2)
    [ILTspec(:,jj), tau, ~] = upnnlsmooth1D(FTT2map(:,jj), echoVec', T2lims(1), T2lims(2), alpha, -1, nILTpts, 'exp(-h/T)');
end

hhh = figure(5);
surf(depthAxis,tau,ILTspec)
shading interp
set(gca,'YScale','log')
view([90 90])
xlabel('position [um]')
ylabel('T2 [s]')
yticks(10.^(log10(T2lims(1)):1:log10(T2lims(2))))

title(filetitle)
ylim([min(tau) max(tau)])
xlim([0 2500])
pubgraph(hhh,14,1,'w','Arial')
print(strcat(filedir,filetitle,'_newProc.png'),'-dpng')
    
    