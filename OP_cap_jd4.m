%With Jamming
function [OP1,OP2,OP1E,OP2E,cap_1,cap_2,cap_1E,cap_2E,cap_S1,cap_S2,gamma1f,gamma2f]=OP_cap_jd4(m1,omega1,m2,omega2,m3,omega3,m4,omega4,m5,omega5,m6,omega6,NO,gammadbCU1,gammadbCU2,gammadbCU3,Psdb,P1db,NOL,alpha1,alpha2)
%m represents fading severity, omega represents channel mean power, NO
%represents noice, Psdb is power from S, P1db is power of jamming signal,
%NOL represents number of iterations, alpha1 and alpha 2 are power
%allocation coefficients. gammadbCU1, gammadbCU2 and gammadbCU3 are
%threshold levels for users in the system. 

%beta is ratio of m and omega, where m is fading severity and omega is channel mean power.
Beta1=m1/omega1;
Beta2=m2/omega2;
Beta3=m3/omega3;
Beta5=m5/omega5;
Beta6=m6/omega6;

%Converting db to linear scale.
gammaCU1=10^(gammadbCU1/10);
gammaCU2=10^(gammadbCU2/10);
gammaCU3=10^(gammadbCU3/10);
gamma1bars=10^(P1db/10)/NO;
Ps=10^(Psdb/10);



for jj=1:length(omega4)
    Beta4=m4/omega4(jj);
    gammabars=Ps/NO;  % gamabars is the avg power transmitted at S.
    
    OP1(jj)=0; % Outage probability of user 1.
    OP2(jj)=0; % Outage probability of user 2.
    OP1E(jj)=0; % Outage probability of eavesdropper against user1.
    OP2E(jj)=0; % Outage probability of eavesdropper against user2.
    cap_1(jj)=0; %channel capacity of user 1.
    cap_2(jj)=0; %channel capacity of user 2.
    cap_1E(jj)=0; %channel capacity of eavesdropper against user2.
    cap_2E(jj)=0; %channel capacity of eavesdropper against user1.
    gamma1f(jj)=0;
    gamma2f(jj)=0;
    gamma3f(jj)=0;
    gamma4f(jj)=0;
    gamma1rr=0;
    gamma2rr=0;
    
    for ii=1:NOL
        % Channel coefficients using gamma distribution.
        X1=gamrnd(m1,1/Beta1);
        X2=gamrnd(m2,1/Beta2);
        X3=gamrnd(m3,1/Beta3);
        X4=gamrnd(m4,1/Beta4);
        X5=gamrnd(m5,1/Beta5);
        X6=gamrnd(m6,1/Beta6);
        % SINR when UE1 decodes UE2.
        gamma11=(alpha2*gammabars*X1)/(alpha1*gammabars*X1+1);
        gamma12=(alpha1*gammabars*X1); %SINR of UE1 after applying SIC.
        gamma1=min(gamma11,gamma12); % end to end SINR at UE1.
        
       % SINR of UE2 decoded its signal from S.
        gamma21=(alpha2*gammabars*X2)/(alpha1*gammabars*X2+1);
        gamma22=(alpha2*gammabars*X3);%SINR of UE2 from UE1.
        gamma2=max(gamma21,gamma22); % end to end at UE2.
        
        %SINR of eavesdropper against UE2.
        gamma1E=(alpha2*gammabars*X4)/(alpha1*gammabars*X4+gamma1bars*X5+alpha2*gammabars*X6+1);
        gamma2E=(alpha1*gammabars*X4)/(gamma1bars*X5+alpha2*gammabars*X6+1); % SINR of eavesdropper against UE2.
        
        
        gamma1rr(ii)=gamma1;
        gamma2rr(ii)=gamma2;

        
        
          % Conditions for outage probability and secrecy capacity.
        if (gamma1<gammaCU1)
            OP1(jj)=OP1(jj)+1;
        else
            cap_1(jj)=cap_1(jj)+log2(1+gamma1);
        end
        if (gamma2<gammaCU2)
            OP2(jj)=OP2(jj)+1;
        else
            cap_2(jj)=cap_2(jj)+log2(1+gamma2);
        end
        if (gamma1E<gammaCU3)
            OP1E(jj)=OP1E(jj)+1;
        else
            cap_1E(jj)=cap_1E(jj)+log2(1+gamma1E);
        end
        if (gamma2E<gammaCU3)
            OP1E(jj)=OP2E(jj)+1;
        else
            cap_2E(jj)=cap_2E(jj)+log2(1+gamma2E);
        end
        
    end
        %Calculating SINR, outage probabilities and secrecy capcities.
        gamma1f(jj)=mean(gamma1rr);
        gamma2f(jj)=mean(gamma2rr);
        OP1(jj)=OP1(jj)/NOL;
        OP2(jj)=OP2(jj)/NOL;
        OP1E(jj)=OP1E(jj)/NOL;
        OP2E(jj)=OP2E(jj)/NOL;
        cap_1(jj)=cap_1(jj)/NOL;
        cap_2(jj)=cap_2(jj)/NOL;
        cap_1E(jj)=cap_1E(jj)/NOL;
        cap_2E(jj)=cap_2E(jj)/NOL;
        cap_S1(jj)=cap_1(jj)-cap_2E(jj);
        cap_S2(jj)=cap_2(jj)-cap_1E(jj);
 
end
end


        
        
            