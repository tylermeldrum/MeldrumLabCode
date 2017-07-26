function [echoVec, v, T2Ddata] = RC_T2Dsim(AmpA, T1A, T2A, DA, AmpB, T1B, T2B, DB, delta, DELTA, tE, nEchoes, n, G, SNR);

gamma = 42.577*1e6*2*pi; %rad s-1 T-1

echoVec = tE:tE:nEchoes*tE;
dEff = linspace(0.05*delta,0.5*delta,n);

T2Ddata = zeros(n,nEchoes);
noise = randn(n,nEchoes);

% Diffusion signal attenuation for first points
timefac = delta^3-3*delta^2*dEff + 3*(delta + 2*DELTA)*dEff.^2 + 3*dEff.^3;
v = (1/6)*gamma^2*G^2*timefac*1e-9;
DvecRCA = exp(-v*DA - 2*delta/T2A - DELTA/T1A);
DvecRCB = exp(-v*DB - 2*delta/T2B - DELTA/T1B);

% Include T2 relaxation
for ii = 1:n
    T2Ddata(ii,:) = AmpA.*exp(-echoVec/T2A).*DvecRCA(ii) + AmpB.*exp(-echoVec/T2B).*DvecRCB(ii);
end

noiseFac = max(max(T2Ddata))/mean(rms(noise));
noise = noise./(SNR/noiseFac);

T2Ddata = T2Ddata + noise;
end