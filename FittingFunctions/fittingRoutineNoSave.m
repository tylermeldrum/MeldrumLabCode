function [yData,p,scaling,shift] = fittingRoutineNoSave(offOrOn,time,confInt)
yOrig=offOrOn; 

A=max(yOrig);
tau=10;
vStart=[A,tau];
fprintf('Start: A=%f  tau=%f\n',vStart(1),vStart(2));
yStart=exponential1(vStart,time);

[vEnd, r, J, COVB, mse] = nlinfit(time,yOrig,@exponential1,vStart); %fit raw data points to y=A*e^(-x/tau) to find scaling
yEnd=exponential1(vEnd,time);
fprintf('End: A=%f  tau=%f\n', vEnd(1),vEnd(2));

ci = nlparci(vEnd, r, 'covar', COVB,'alpha',(1-confInt)); %generates 90% confidence intervals for the fit coefficients

scaling = vEnd(1);
scalingError = abs((ci(1,1)-ci(1,2))/2);

% scale data to max fit height
data5 = offOrOn ./ vEnd(1);

%% refit with y-offset
yOrig=data5;

y0=1;
tau=10;
vStart=[y0,tau];
%fprintf('Start: y0=%f  tau=%f\n',vStart(1),vStart(2));
yStart=exponential2(vStart,time);

[vEnd, r, J, COVB, mse] = nlinfit(time,yOrig,@exponential2,vStart); %fit scaled data to y=y0 + exp(-x/tau) to find y-offset and error
yEnd=exponential2(vEnd,time);
%fprintf('End: y0=%f  tau=%f\n', vEnd(1),vEnd(2));

ci = nlparci(vEnd, r, 'covar', COVB,'alpha',(1-confInt)); %generates 90% confidence intervals for the fit coefficients

shift = vEnd(1);
shiftError = abs((ci(1,1) - ci(1,2)) / 2);

% shift data vertically
data6 = data5 - shift;

%% fit for tau
yOrig=data6;

tau=10;
vStart=[tau];
yStart=exponential3(vStart,time);

[vEnd, r, J, COVB, mse] = nlinfit(time,yOrig,@exponential3,vStart); %final fit with scaled, shifted data to y=exp(-x/tau) to get tau and its error
yEnd=exponential3(vEnd,time);

ci = nlparci(vEnd, r, 'covar', COVB,'alpha',(1-confInt)); %generates 90% confidence intervals for the fit coefficients

tauvalue = vEnd(1);
tauvalueError = abs((ci(1,1) - ci(1,2))/2);

yData = yEnd;

%% final results and plotting
finalFit = [time, data6, yEnd, yEnd - shiftError, yEnd + shiftError];
fitparams = [tauvalue, tauvalueError;shift,shiftError;scaling,scalingError];

ci = nlparci(vEnd, r, 'covar', COVB,'alpha',0.1); %generates 90% confidence intervals for the fit coefficients

% fprintf('End: tau = %f +/- %f\n     y0 = %f +/- %f\n     A = %f +/- %f\n', tauvalue, tauvalueError, shift, shiftError, scaling, scalingError);

fprintf('End: tau = %f +/- %f\n', tauvalue, tauvalueError);

p = fitparams(1,:);
