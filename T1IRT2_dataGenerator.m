% 7 July 2015
% This file generates 2D T1(inversion recovery)-T2 data. The user should
% input T1 and T2 values (only one peak is in this implementation), the
% time increment for both the T1 and T2 axes, and the number of points on
% each axis. The program generates T2 and T1 curves, then multiplies them
% (line 32) to make the final data set. Plotting and saving for use in
% Prospa is also avaiable.


clear
close all
clc

%%

% User defined parameters
T1_1 = 4.5e-3; %s
w1 = 0.45; % First T1 weight
T1_2 = 6.0e-3; %s
w2 = 0.55; % Second T1 weight
T2 = 3.5e-3; %s
t_T1 = 500e-6; %s, time increment for T1 axis
t_T2 = 500e-6; %s, time increment for T2 axis
nPtsT1 = 20; %points for T1 axis
nPtsT2 = 32; %points for T2 axis
%end user-defined parameters

data = zeros(nPtsT1,nPtsT2); %make blank matrix
T1axis = linspace(t_T1, t_T1*nPtsT1, nPtsT1); %set up axes
T2axis = linspace(t_T2, t_T2*nPtsT2, nPtsT2);

T2data = exp(-T2axis/T2); %1D T2 curve
T1data = w1*(1-2*exp(-T1axis/T1_1)) + w2*(1-2*exp(-T1axis/T1_2)); %1D T1 curve

data2D = T1data'*T2data; %make 2D data set

% Add in noise
for i = 1:length(T1axis)
    for j = 1:length(T2axis)
        noise = randn/200;
        while 0.5 < noise < -0.5
            noise = randn/200;
        end
    
        data2D(i, j) = data2D(i,j) + randn/20;
    end
end

surf(T2axis',T1axis,data2D) %plotting
shading flat
% set(gca,'Xscale','log','Yscale','log')
ylabel('T1 [s]')
xlabel('T2 [s]')
ylim([min(T1axis) max(T1axis)]);
xlim([min(T2axis) max(T2axis)]);

% Save the data
saveDir = '/Users/jaredking/Documents/Chemistry/Research_Files_and_Data/CHIRP/';
saveName = 'DataSim_32by20';
save(strcat(saveDir, saveName, '.dat'), 'data2D', '-ascii');