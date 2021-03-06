clear
clc
close all
%%
% USER-DEFINED PARAMETERS
filename = 'data.2d';
filedir = 'Z:\Data\JYU\CPMG (summer 2017)\31July\P250_overnight_acetone\';

nMeas = 126;
G = 23.87; %T/m
zf = 0; %levels of zero-filling

alpha = 1e8;
T2lims = [1e-4 1e-1];

omitEchoes = 0; %front-end echoes to omit

t0 = datetime('31-Jul-2017 16:42:00');
tEnd = datetime('31-Jul-2017 19:33:00');
% END USER-DEFINED PARAMETERS

tElapsed = tEnd - t0;

measT = linspace(t0,tEnd,nMeas);

gamma = 42.576;                     % MHz T-1
gammaRad = gamma*2*pi*1e6;          % rad s-1 T-1


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
    
    for mm = 1:L
        [ILTspec(mm,:,nn), tau, ~] = upnnlsmooth1D(abs(FTT2(mm,:)'), echoVec', T2lims(1), T2lims(2), alpha, -1, nrEchoes-omitEchoes, 'exp(-h/T)');
    end
end
    
%%
% for nn = 1:nMeas 
%     figure(1)
%     subplot(ceil(nMeas/ceil(sqrt(nMeas))),ceil(sqrt(nMeas)),nn)
%     surf(tau,z,ILTspec(:,:,nn))
%     set(gca,'XScale','log')
%     set(gca,'YDir','reverse')
%     xlabel('T2 [s]')
%     ylabel('position [um]')
%     ylim([min(z) max(z)])
%     xlim(T2lims)
%     shading interp
%     view([0 90])
%     title(num2str(nn))
% %     axis tight manual
% %     axis off
% end

%%
figure(2)
set(gcf,'Color','w')
ax = gca;
ax.NextPlot = 'replaceChildren';


% F(nMeas) = struct('cdata',[],'colormap',[]);
for j = 1:nMeas
contour(tau,z,ILTspec(:,:,j))
    set(gca,'XScale','log')
    set(gca,'YDir','reverse')
    xlabel('T2 [s]')
    ylabel('position [um]')
    ylim([min(z) max(z)])
    xlim(T2lims)
    shading interp
    view([0 90])
%     title(num2str(j))
    drawnow
%     frame = getframe;
    F{j} = frame2im(getframe(figure(2)));
end

figure(5)
surf(zeros(2,2))
view([0 90])
G = frame2im(getframe(figure(5)));
%%
filename = strcat(filedir,'gifout.gif'); % Specify the output file name
for idx = 1:nMeas
    [A,map] = rgb2ind(F{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
    end
end

[A,map] = rgb2ind(G,256);
imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',2);
