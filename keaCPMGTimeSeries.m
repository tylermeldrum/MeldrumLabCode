clear
clc
close all

%%
% USER-DEFINED PARAMETERS
filename = 'data.2d';
filedir = fullfile('Z:','Data','JYU','CPMG (summer 2017)','26July','P250.2015e_acetone_overnight');


nMeas = 60;
nSmooth = 21;

omitEchoes = 0; %front-end echoes to omit

guess = [0 1 0.008]; %[y-offset, amplitude, T2 in s]

t0 = datetime('26-Jul-2017 20:34:00');
tEnd = datetime('27-Jul-2017 09:11:00');
% END USER-DEFINED PARAMETERS

tElapsed = tEnd - t0;
t = linspace(t0,tEnd,nMeas);

T2 = zeros(nMeas,2);

%%
for nn = 1:nMeas
    fileloc = fullfile(filedir,num2str(nn-1),filename);
    parloc  = fullfile(filedir,num2str(nn-1),'acqu.par');
    
    [ap,spec] = readKea4d(fileloc);
    tE = readpar_Kea(parloc,'echoTime')*1e-6;
    nrEchoes = ap.yDim;
    nrPts = ap.xDim;
    
    echoVec = (omitEchoes+1)*tE:tE:nrEchoes*tE;
    spec2d = reshape(spec,nrPts,nrEchoes);
    spec2d = spec2d(:,omitEchoes+1:end);
    fitdata = sum(spec2d,1);
    fitdataP = autophase(fitdata,1);
    fitdataR  = real(fitdataP);
    fitdataI = imag(fitdataP);
    fitdataM = abs(fitdata);

    
    try    
        [beta,R,J,CovB] = nlinfit(echoVec,fitdataR./fitdataR(1), @t2monofit, guess);
        ci = nlparci(beta,R,'jacobian',J);
        guess = beta;
        
        T2(nn,1) = beta(3);
        T2(nn,2) = beta(3)-ci(3,1);
    catch
        T2(nn,1) = NaN;
        T2(nn,2) = NaN;
    end
        
    

end
%%
close all

T2smooth = smooth(T2(:,1),nSmooth);

hh = figure(1);
hold on
plot(t,1000*T2(:,1))
plot(t,1000*T2smooth)
xlabel('time')
ylabel('T2 [ms]')
title(strcat('CPMG time series, time interval = ',datestr(t(2)-t(1),'MM'),':',datestr(t(2)-t(1),'SS')))
legend('raw',strcat('smoothed, n =',num2str(nSmooth)))
pubgraph(hh,14,1,'w','Arial')