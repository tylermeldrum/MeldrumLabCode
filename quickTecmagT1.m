clear
clc
close all

%%

filename = '400mMCu_T1IR_BURP_18Sept2015.tnt';
filedir = '/Users/jaredking/Documents/Chemistry/Research/CHIRP/ExcelDataSets_CHIRP/400mMCu/';

fileloc = strcat(filedir,filename);

[ap,spec,spec2,spec3,spec4] = readTecmag4d(fileloc);
tEcho = 700; %us

nEchoes = 8;
nPts = 76;
nPtsBlank = 2;
nT1Pts = 21;
T1min = 0.1; %ms
T1max = 8; %ms
T1guess = 0; %ms 

T1vector = linspace((T1min),(T1max),nT1Pts); % Linspace T1sat
echoVector = (tEcho:tEcho:nEchoes*tEcho)*1e-6;

% T1vector = logspace(log10(T1min),log10(T1max),nT1Pts); % Logspace T1sat

data = reshape(spec2',nPts,nEchoes,nT1Pts);
data = data(1:(nPts-nPtsBlank),:,:);
dataInt = sum(sum(data,1),2);
dataInt = reshape(dataInt,1,nT1Pts);
dataIntRe = real(dataInt);
dataIntIm = imag(dataInt);


%% cftool
cftool(T1vector, -dataIntRe./min(dataIntRe))

%%
guesses = [1, max(dataIntRe), T1guess];
[beta, Resids, J] = nlinfit(T1vector,dataIntRe,@T1_recovery,guesses);
ypred = T1_recovery(beta,T1vector);
CI = nlparci(beta, Resids, 'jacobian', J);


figure(1)
hold on
scatter(T1vector,dataIntRe);
plot(T1vector,ypred);

%% Make 2D data set for T1SRT2

data2d = sum(real(data),1);
data2d = reshape(data2d,nEchoes, nT1Pts);
data2d = data2d';

surf(data2d); shading flat

save('150mMGdH2O_T1IR_BURP_10Sep2015.dat', 'data2d', '-ascii')
