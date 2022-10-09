
clear all 
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fading severity is kept 2 for the chosen environment.
m1=2;
m2=2;
m3=2;
m4=2;
m5=2;
m6=2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=3; % Path loss exponent.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Distances of users according to the system model.
d1=0.3;
d2=1.2;
d3=1.3;
d4=1.5;
d5=0.3;
d6=2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Channel mean power.
omega1=d1^-n;
omega2=d2^-n;
omega3=d3^-n;
omega4=d4^-n;
omega5=d5^-n;
omega6=d6^-n;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NO=1; %Noise power.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Threshold levels for UE1, UE2 and eavesdropper.
gammadbCU1=2;
gammadbCU2=2;
gammadbCU3=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Psdb=0:1:20; % Power from S.
P1db=15; % Jamming signal power.
NOL=10^6; %number of iterations.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Power allocation coefficients.
alpha1=0.2;
alpha2=0.8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[OP1,OP2,OP1E,OP2E,cap_1,cap_2,cap_1E,cap_2E,cap_S1,cap_S2,gamma1f,gamma2f]=OP_cap_N(m1,omega1,m2,omega2,m3,omega3,m4,omega4,m5,omega5,m6,omega6,NO,gammadbCU1,gammadbCU2,gammadbCU3,Psdb,P1db,NOL,alpha1,alpha2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1),
plot(Psdb,gamma1f,'-*')
hold on
plot(Psdb,gamma2f,'-*')
grid on
legend('gamma1','gamma2')
xlabel('Transmitted Power (dB)')
ylabel('SNR/SINR')