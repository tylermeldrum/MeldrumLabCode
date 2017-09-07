clear
clc
close all

gamma = 42.577e6*2*pi;  %rad s-1 T-1
G = 6.59; %T m-1

T2 = 7.7e-3; %s
T1 = 2620e-3; %s


D = logspace(-8,-12,5);
DELTA = linspace(0,250e-3,250);
delta = linspace(0,25e-3,250);



f1 = linspace(0,1,100);
f3 = f1.^3;
f2 = f1.^2;


for mm = 1:length(D)
    alpha = -D(mm)*(gamma*G)^2*delta'.^2;
    
    for ll = 1:length(DELTA)
        
        Shold = (-(1/2)*bsxfun(@times,delta',f3) + bsxfun(@times,2*delta'+DELTA(ll),f2) - bsxfun(@times,2*(delta'+DELTA(ll)),f1) + (DELTA(ll) + (2/3)*delta'));
        Shold = bsxfun(@times,alpha,Shold);
        Shold = Shold - 2*delta'/T2 -DELTA(ll)/T1;
        Shold = exp(Shold);
        S(:,:,ll,mm) = Shold;
        for ii = 1:length(delta)
            Srange(ii,ll,mm) = S(ii,end,ll,mm)-S(ii,1,ll,mm);
        end
    end


% figure
% surf(DELTA,delta',Srange);
% shading flat
% xlabel('DELTA')
% ylabel('delta')
% caxis([0 1]);
% zlim([0 1])
    
end



[C,I] = max(Srange);
delta(I);

[~,J] = max(C);

ffff = [D',1000*DELTA(J)',squeeze(1000*max(delta(I))),squeeze(max(C))];
sprintf('for D = %.0e; DELTA = %0.2f ms, delta = %0.2f ms, encoding = %0.2f\n',ffff')    


