function [echoVec, v, T2Ddata] = Reg_T2Dsim(AmpA, T2A, DA, AmpB, T2B, DB, delta, DELTA, tE, nEchoes, n, G, SNR);

gamma = 42.577*1e6*2*pi; %rad s-1 T-1

echoVec = tE:tE:nEchoes*tE;
dEff = linspace(0.05*delta,0.5*delta,n);

T2Ddata = zeros(n,nEchoes);
noise = randn(n,nEchoes);

% Diffusion signal attenuation for first points
v = gamma^2*G^2*dEff.^2.*(DELTA-dEff/3)*1e-9;
DvecA = exp(-v*DA);
DvecB = exp(-v*DB);

% Include T2 relaxation
for ii = 1:n
    T2Ddata(ii,:) = AmpA.*exp(-echoVec/T2A).*DvecA(ii) + AmpB.*exp(-echoVec/T2B).*DvecB(ii);
end

noiseFac = max(max(T2Ddata))/mean(rms(noise));
noise = noise./(SNR/noiseFac);

T2Ddata = T2Ddata + noise;
end