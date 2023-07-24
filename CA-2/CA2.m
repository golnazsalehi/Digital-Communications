%%
clc
clear
%% Part1
T = 1;
Beta = 0;
Fs = 10;
delta_t = T/Fs;
duration = -6*T:delta_t:6*T;
%--------
Raised_Cosine = nyquist_pulse(duration,T,Beta);
%--------
bits = rand(10^6,1)';
modulated_symbols = -3*(bits<0.1) + -1*(bits>=0.1 & bits<0.5) + ...
       (bits>=0.5 & bits<0.9) + 3*(bits>=0.9);
%--------  
L = T*Fs;
temp0 = upsample(modulated_symbols,L);
temp0 = temp0(1:end-(L-1));
%--------
S = size(Raised_Cosine,2);
Length = length(temp0) + S-1;
transmitted_signal = conv(temp0,Raised_Cosine);
%--------
SNR_dB = 0:10;
N0 = ((10.^(SNR_dB./10))./2.6).^(-1);
coefs = N0.^(1/2)./(sqrt(2));
%---
S = size(transmitted_signal,2);
received_signal = zeros(11,S);

for j = 1:11
    noise = randn(1,S);
    received_signal(j,:) = transmitted_signal + coefs(j)*noise;
end

%% Part2
T_sampling = 6*L+1:L:(10^6+6-1)*L+1;
%% MAP
detected_symbols_MAP = zeros(11,10^6);

for j = 1:11
        thr1 = coefs(j)^2*log(2) + 2;
        thr2 = 0;
        thr3 = -thr1;
        samples = received_signal(j,T_sampling);
         detected_symbols_MAP(j,:) = (samples > thr1)*3 + ...
                                  + (samples > thr2 & samples <= thr1) + ...
                                  - (samples > thr3 & samples <= thr2) + ...
                                  + (-3)*(samples < thr3);
end
%% Erro Calculation for MAP
error = zeros(1,11);
for j = 1:11
    dummy = reshape(detected_symbols_MAP(j,:),10^6,1);
    Sum = sum(modulated_symbols'==dummy);
     error(j) = 1-Sum/10^6;
end
figure(1)
semilogy(0:10,error,'g','LineWidth',1.5)
grid on
title('The Performance of MPAM For ${\beta}$ = 0','Interpreter','latex')
xlabel('Es/ ${\eta}$','Interpreter','latex')
ylabel('Bit Error Rate','Interpreter','latex')
%% ML
detected_symbols_ML = zeros(11,10^6);

thr1 = 2;
thr2 = 0;
thr3 = -2;

for j = 1:11
       samples = received_signal(j,T_sampling);
       detected_symbols_ML(j,:) = (samples > thr1)*3 + ...
                                  + (samples > thr2 & samples <= thr1) + ...
                                  - (samples > thr3 & samples <= thr2) + ...
                                  + (-3)*(samples < thr3);                          
end
%% Erro Calculation for ML
error = zeros(1,11);
for j = 1:11
    dummy = reshape(detected_symbols_ML(j,:),10^6,1);
    Sum = sum(modulated_symbols'==dummy);
     error(j) = 1-Sum/10^6;
end
figure(1)
hold on
semilogy(0:10,error,'m','LineWidth',1.5)
legend('MAP Reciever','ML Reciever')
%% Functions
function [pulse]=nyquist_pulse(t,T,Beta)
    L = length(t);
    pulse = zeros(1,L);
    for i = 1:L
        if abs(t(i)) == T/(2*Beta)
             pulse(i) = pi/4*sinc(1/(2*Beta));
        else
            x = t(i);
            pulse(i) =  sinc(x/T)*cos(pi*Beta*x/T)/(1-(2*Beta*x/T)^2);
        end
    end
end