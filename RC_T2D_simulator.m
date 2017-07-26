% Generate T2-D data using relaxation compensated kernel
% July 25, 2017, TKM

clear
close all
clc

%% Define parameters

% COMPONENT 1
AmpA = 0.5;            %fraction
T1A = 300 * 1e-3;      %s
T2A = 15 * 1e-3;       %s
DA = 0.5;              %1e-9 m2 s-1

% COMPONENT 2
AmpB = 1-AmpA;         %calculated automatically
T1B = 1500 * 1e-3;     %s
T2B = 2 * 1e-3;        %s
DB = 3;                %1e-9 m2 s-1

% ACQUITISION PARAMETERS
delta = 1 * 1e-3;      %s
DELTA = 50 * 1e-3;     %s
tE = 400 * 1e-6;       %s
nEchoes = 128;         %number of echoes

% OTHER PARAMETERS
n = 100;               %number of delta_eff points to simulate
G = 6.59;              %T m-1

%% Calculations

%Other parameters
gamma = 42.577*1e6*2*pi; %rad s-1 T-1

echoVec = tE:tE:nEchoes*tE;
dEff = linspace(0.05*delta,0.5*delta,n);

T2Ddata = zeros(n,nEchoes);


% Diffusion signal attenuation for first points

timefac = delta^3-3*delta^2*dEff + 3*(delta + 2*DELTA)*dEff.^2 + 3*dEff.^3;
v = (1/6)*gamma^2*G^2*timefac*1e-9;

attenA = -v*DA - 2*delta/T2A - DELTA/T1A;
attenB = -v*DB - 2*delta/T2B - DELTA/T1B;
Dvec = AmpA*exp(attenA) + AmpB*exp(attenB);


% Include T2 relaxation
for ii = 1:n
    T2Ddata(ii,:) = (AmpA.*exp(-echoVec/T2A) + AmpB.*exp(-echoVec/T2B)).*Dvec(ii);
end

figure(1)
surf(echoVec,v,T2Ddata)
shading flat
xlabel('echoVec/s');
ylabel('v/[s m-2] (inverse diffusion)')
view([0 90]);


% Output for TwoDLaplaceInverse
save('T2Ddata.dat', 'T2Ddata', '-ascii');
save('T2axis.dat', 'echoVec', '-ascii')
save('vaxis.dat', 'v', '-ascii')

% Show the percentage you throuw off the attenuation factors by not
% including T1/T2 relaxation
clc
T2vsDA = (-2*delta/T2A)/(attenA(1))
T1vsDA = (-DELTA/T1A)/(attenA(1))
T2vsDB = (-2*delta/T2B)/(attenB(1))
T1vsDB = (-DELTA/T1B)/(attenB(1))