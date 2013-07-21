%% Plot Weighting Function Permutations
figure('name','Weighting Function Permutations');
semilogx(0,length(vectorLog));
hold on;
grid on;


for iPermutation=1: 1 : nPermutations^2
    semilogx( vectorLog, Wu_uncertain_discrete(1:length(vectorLog),iPermutation) ,'black' )
end
hold off;

%% Plot Chosen Weighting Function Discrete
figure('name','Chosen Weighting Function Discrete');
semilogx(0,length(vectorLog));
hold on;
grid on;


for cur_i=1: 1 : nPermutations^2
    semilogx( vectorLog, Wu_discrete ,'black' )
end

hold off;

%% Plot Fitted Weighting Function
figure('name','Weighting Function');
hold on;
grid on;
bode(Wu)
hold off;

%% Plot Gp_uncertain(i,j)/Gp_nominal - 1  (SLOW!!!)
%     for i=1 : 1 : nPermutations
%         for j=1 : 1 : nPermutations
%             hold on
%             bode( Gp_uncertain(i,j)/Gp_nominal - 1 );
%         end
%     end

%% Plot Loop, Sensitivity, and complimentary senstivity function
figure('name','Loop function and sensitivity functions');
hold on;
grid on;
bode(L,S,T)
legend('Loop Function','Sensitivity Function','Complimentary Sensitivity Function')
hold off;

%% Plot Nominal Loop, Sensitivity, and complimentary senstivity function
figure('name','Nominal Loop function and sensitivity functions');
hold on;
grid on;
bode(Ln,Sn,Tn)
legend('Nominal Loop Function','Nominal Sensitivity Function','Nominal Complimentary Sensitivity Function')
hold off;

%% Plot nichols with Sp and Tp
% ngrid('new')
figure('name','Nichols of loop function');
myngridst(Tp,Sp)
legend('Tp','Sp')
hold on
nichols(L,'r')
hold off;

%% Plot nominal nichols of Ln with Sp and Tp
% ngrid('new')
figure('name','Nichols of nominal loop function');
myngridst(Tp,Sp)
hold on
nichols(Ln,'r')
legend('Tp','Sp','Ln')
hold off;

%% check for nominal performance
figure('name','Check NP, should not pass 0db');
bode(Ws*Sn,Wt*Tn) % both curves should not pass 0db
legend('Ws*Sn','Wt*Tn')


%% check robust performance
% blue should be over red for lf
% blue should be under green for hf

figure('name','Check RP, blue over red for lf, blue under green for hf ');
bode(Ws/(1-Wu),'r',L,'b',(1-Ws)/Wu,'g')
legend('Ws/(1-Wu)','L','(1-Ws)/Wu')


%% Check for robust stability
figure('name','Check RS, should not pass 0db');
bode(Wu*Tn) % should not pass 0db
legend('Wu*Tn')

%% Check for nominal performance and robust stability
figure('name','Check NP and RS, should not pass 0db');
bode(Ws*Sn+Wu*Tn) % should not pass 0db
legend('Ws*Sn + Wu*Tn')

%% Plot Error function Er
figure('name','Error function Er (Gre*r-Kd*r)');
plot(simulink_ery_time,simulink_ery_out(:,2))
%% Plot Error function Ea
figure('name','Error function Ea');
plot(simulink_eay_time,simulink_eay_out(:,2))
%% Plot Error function Ep
figure('name','Error function Ep');
plot(simulink_epy_time,simulink_epy_out(:,2))
%% Plot Error function Es
figure('name','Error function Es');
plot(simulink_esy_time,simulink_esy_out(:,2))

%% End
hold off;