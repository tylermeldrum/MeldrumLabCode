clear
close all
clc

% 0 % Power
nrSamples = 1;
filename = 'data';
filedir = '~/Desktop/CPMG/27_July_2017_100%PEGDA_2%HCPK_2%PPh3/30s_0%/2/';
omitEchoes = 0;
alpha = 1e7;
lowLim = 1e-4; %s
hiLim = 1e0;  %s
%

for ll = 1:nrSamples
    fileloc = strcat(filedir,filename,num2str(ll),'.2d');
    [ap,aa] = readKea4d(fileloc);
    spec(:,ll) = aa./max(aa);
%     spec = spec(:,omitEchoes+1:end);

end
    parloc  = strcat(filedir,'acqu.par');
    tE = readpar_Kea(parloc,'echoTime')*1e-6;
    tD = readpar_Kea(parloc,'dwellTime')*1e-6;
    nrEchoes = ap.yDim;
    nrPts = ap.xDim;
    echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
    nrILTSteps = min(128,length(echoVec));
    
    spec = reshape(spec,nrPts*nrEchoes*ll,1);
    spec = reshape(spec,nrPts,nrEchoes*ll);
    spec = spec(:,omitEchoes+1:end);
    specsum = sum(spec,1);
    echoVec2 = repmat(echoVec,1,nrSamples);
    
    realData = real(specsum);
    
kernel1 = 'exp(-h/T)';
[spectrum,tau] = upnnlsmooth1D(realData',echoVec2',  lowLim, hiLim, alpha ,  -1,  nrILTSteps,kernel1);
specref = max(spectrum);
spectrum0 = spectrum./specref;
int0 = cumsum(spectrum0);
int0 = int0./max(int0);

 
 %%
 % 20% Power
clear('spec')
nrSamples = 1;
filename = 'data';
filedir = '~/Desktop/CPMG/27_July_2017_100%PEGDA_2%HCPK_2%PPh3/30s_20%/2/';
% omitEchoes = 0;
% alpha = 1e8;
% lowLim = 1e-5; %s
% hiLim = 1e0;  %s
%

for ll = 1:nrSamples
    fileloc = strcat(filedir,filename,num2str(ll),'.2d');
    [ap,aa] = readKea4d(fileloc);
    spec(:,ll) = aa./max(aa);

end
    parloc  = strcat(filedir,'acqu.par');
    tE = readpar_Kea(parloc,'echoTime')*1e-6;
    tD = readpar_Kea(parloc,'dwellTime')*1e-6;
    nrEchoes = ap.yDim;
    nrPts = ap.xDim;
    echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
    nrILTSteps = min(128,length(echoVec));
    
    spec = reshape(spec,nrPts*nrEchoes*ll,1);
    spec = reshape(spec,nrPts,nrEchoes*ll);
    spec = spec(:,omitEchoes+1:end);
    specsum = sum(spec,1);
    echoVec2 = repmat(echoVec,1,nrSamples);
    
    realData = real(specsum);
    
kernel1 = 'exp(-h/T)';
[spectrum,tau] = upnnlsmooth1D(realData',echoVec2',  lowLim, hiLim, alpha ,  -1,  nrILTSteps,kernel1);
spectrum20 = spectrum./specref;
int20 = cumsum(spectrum20);
int20 = int20./max(int20);



%%
%40% Power
clear('spec')
nrSamples = 1;
filename = 'data';
filedir = '~/Desktop/CPMG/27_July_2017_100%PEGDA_2%HCPK_2%PPh3/30s_40%/3/';
%  omitEchoes = 0;
%  alpha = 1e8;
%  lowLim = 1e-5; %s
%  hiLim = 1e0;  %s
%

for ll = 1:nrSamples
    fileloc = strcat(filedir,filename,num2str(ll),'.2d');
    [ap,aa] = readKea4d(fileloc);
    spec(:,ll) = aa./max(aa);

end
    parloc  = strcat(filedir,'acqu.par');
    tE = readpar_Kea(parloc,'echoTime')*1e-6;
    tD = readpar_Kea(parloc,'dwellTime')*1e-6;
    nrEchoes = ap.yDim;
    nrPts = ap.xDim;
    echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
    nrILTSteps = min(128,length(echoVec));
    
    spec = reshape(spec,nrPts*nrEchoes*ll,1);
    spec = reshape(spec,nrPts,nrEchoes*ll);
    spec = spec(:,omitEchoes+1:end);    
    specsum = sum(spec,1);
    echoVec2 = repmat(echoVec,1,nrSamples);
    
    realData = real(specsum);
    
kernel1 = 'exp(-h/T)';
[spectrum,tau] = upnnlsmooth1D(realData',echoVec2',  lowLim, hiLim, alpha ,  -1,  nrILTSteps,kernel1);
spectrum40 = spectrum./specref;
int40 = cumsum(spectrum40);
int40 = int40./max(int40);


%%
%60% Power
clear('spec')
nrSamples = 1;
filename = 'data';
filedir = '~/Desktop/CPMG/27_July_2017_100%PEGDA_2%HCPK_2%PPh3/30s_60%/4/';
% omitEchoes = 0;
% alpha = 1e8;
% lowLim = 1e-5; %s
% hiLim = 1e0;  %s
%

for ll = 1:nrSamples
    fileloc = strcat(filedir,filename,num2str(ll),'.2d');
    [ap,aa] = readKea4d(fileloc);
    spec(:,ll) = aa./max(aa);

end
    parloc  = strcat(filedir,'acqu.par');
    tE = readpar_Kea(parloc,'echoTime')*1e-6;
    tD = readpar_Kea(parloc,'dwellTime')*1e-6;
    nrEchoes = ap.yDim;
    nrPts = ap.xDim;
    echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
    nrILTSteps = min(128,length(echoVec));
    
    spec = reshape(spec,nrPts*nrEchoes*ll,1);
    spec = reshape(spec,nrPts,nrEchoes*ll);
    spec = spec(:,omitEchoes+1:end);    
    specsum = sum(spec,1);
    echoVec2 = repmat(echoVec,1,nrSamples);
    
    realData = real(specsum);
    
kernel1 = 'exp(-h/T)';
[spectrum,tau] = upnnlsmooth1D(realData',echoVec2',  lowLim, hiLim, alpha ,  -1,  nrILTSteps,kernel1);
spectrum60 = spectrum./specref;
int60 = cumsum(spectrum60);
int60 = int60./max(int60);


%%
% 80% Power
clear('spec')
nrSamples = 1;
filename = 'data';
filedir = '~/Desktop/CPMG/27_July_2017_100%PEGDA_2%HCPK_2%PPh3/30s_80%/3/';
% omitEchoes = 0;
% alpha = 1e8;
% lowLim = 1e-5; %s
% hiLim = 1e0;  %s
%

for ll = 1:nrSamples
    fileloc = strcat(filedir,filename,num2str(ll),'.2d');
    [ap,aa] = readKea4d(fileloc);
    spec(:,ll) = aa./max(aa);

end
    parloc  = strcat(filedir,'acqu.par');
    tE = readpar_Kea(parloc,'echoTime')*1e-6;
    tD = readpar_Kea(parloc,'dwellTime')*1e-6;
    nrEchoes = ap.yDim;
    nrPts = ap.xDim;
    echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
    nrILTSteps = min(128,length(echoVec));
    
    spec = reshape(spec,nrPts*nrEchoes*ll,1);
    spec = reshape(spec,nrPts,nrEchoes*ll);
    specsum = sum(spec,1);
    echoVec2 = repmat(echoVec,1,nrSamples);
    
     realData = real(specsum);
    
 kernel1 = 'exp(-h/T)';
 [spectrum,tau] = upnnlsmooth1D(realData',echoVec2',  lowLim, hiLim, alpha ,  -1,  nrILTSteps,kernel1);
 spectrum80 = spectrum./specref;
int80 = cumsum(spectrum80);
int80 = int80./max(int80);

% 
% 
%%
%100%Power
clear('spec')
nrSamples = 1;
filename = 'data';
filedir = '~/Desktop/CPMG/27_July_2017_100%PEGDA_2%HCPK_2%PPh3/30s_100%/3/';
% omitEchoes = 0;
% alpha = 1e8;
% lowLim = 1e-5; %s
% hiLim = 1e0;  %s
%

for ll = 1:nrSamples
    fileloc = strcat(filedir,filename,num2str(ll),'.2d');
    [ap,aa] = readKea4d(fileloc);
    spec(:,ll) = aa./max(aa);

end
    parloc  = strcat(filedir,'acqu.par');
    tE = readpar_Kea(parloc,'echoTime')*1e-6;
    tD = readpar_Kea(parloc,'dwellTime')*1e-6;
    nrEchoes = ap.yDim;
    nrPts = ap.xDim;
    echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
    nrILTSteps = min(128,length(echoVec));
    
    spec = reshape(spec,nrPts*nrEchoes*ll,1);
    spec = reshape(spec,nrPts,nrEchoes*ll);
    spec = spec(:,omitEchoes+1:end);    
    specsum = sum(spec,1);
    echoVec2 = repmat(echoVec,1,nrSamples);
    
    realData = real(specsum);
    
kernel1 = 'exp(-h/T)';
[spectrum,tau] = upnnlsmooth1D(realData',echoVec2',  lowLim, hiLim, alpha ,  -1,  nrILTSteps,kernel1);
spectrum100 = spectrum./specref;
int100 = cumsum(spectrum100);
int100 = int100./max(int100);


%%
specWaterfall(1,:) =  spectrum0;
specWaterfall(2,:) =  spectrum20;
specWaterfall(3,:) =  spectrum40;
specWaterfall(4,:) =  spectrum60;
specWaterfall(5,:) =  spectrum80;
specWaterfall(6,:) =  spectrum100;

intWaterfall(1,:) =  int0;
intWaterfall(2,:) =  int20;
intWaterfall(3,:) =  int40;
intWaterfall(4,:) =  int60;
intWaterfall(5,:) =  int80;
intWaterfall(6,:) =  int100;

powerAxis = [0 20 40 60 80 100];

figure(4)
ax1 = subplot(1,2,1);
colormap([0 0 0]); caxis=[0 0];
% hold on
h1 = waterfall(tau,powerAxis,specWaterfall);
% h2 = waterfall(tau,powerAxis,intWaterfall);
set(gca,'XScale','log')
set(gca, 'YDir','reverse')
set(h1,'LineWidth',2);
xlabel('T2 [s]')
ylabel('UV power %')

ax2 = subplot(1,2,2);
colormap([0 0 0]); caxis=[0 0];
hold on
% h1 = waterfall(tau,powerAxis,specWaterfall);
for ii = 1:6
    plot3(tau,powerAxis(ii)*ones(1,nrILTSteps),intWaterfall(ii,:));
end
% legend('0','20','40','60','80','100')
set(gca,'XScale','log')
set(gca, 'YDir','reverse')
% set(h2,'LineWidth',1);
xlabel('T2 [s]')
ylabel('UV power %')

hlink = linkprop([ax1,ax2],{'CameraPosition','CameraUpVector'}); 
rotate3d on



% figure(5)
% surf(tau,powerAxis,specWaterfall)
% set(gca,'XScale','log')
% shading interp
% xlabel('T2 [s]')
% ylabel('UV power %')
% view([0 90])