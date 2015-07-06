% CHIRP phase table generator for Tecmag
% Adapted from Tecmag's CHIRP script

clear
clc
close all

%%%%%%% User-defined parameters %%%%%%%

dt = 500e-9 ; %time per point in waveform (s) [Scout limit is 20ns]
tau = 15e-3; %pulse length (s)
sliceheight = 0.020; %mm
G = 6.59; %T m-1, B0 field gradient
offset = 0; %mm, frequency offset (if applicable)
amplitude = 15; %dB, for Tecmag
% NOTE: positive offset moves to the left in the FT spectrum (negative
% position)

%%%%%%% END User-defined parameters %%%%%%%


N = round(tau/dt); %number of points per pulse waveform
gamma = 42.576; %MHz T-1
SW = sliceheight*G*gamma*1000; %Hz
offsetHz = offset*1000*G*gamma; %Hz

phase = zeros(N,1);

ind = 1:N;
f = (ind-N/2)*(SW/N);
inc = 2*pi*f*dt;
o_inc = 2*pi*offsetHz*dt;

for i = 1:N-1
    phase(i+1) = phase(i)+inc(i)-o_inc;
end

phase = mod((phase*360/2/pi),360);
% dlmwrite('CHIRP_Phase.dat',phase);



figure(1)
hold on
t = dt:dt:N*dt;
plot(t,phase,'-k')


amp = amplitude*(1-(cos(pi*t/tau)).^40);
% dlmwrite('CHIRP_Amp.dat',amp);

figure(2)
plot(t,amp,'-k')