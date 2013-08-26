%% Plot Weighting Function Permutations
figure('name','Weighting Function Permutations');
semilogx(0,length(vector.log.value));
hold on;
grid on;


for iPermutation=1: 1 : nPermutations^2
    semilogx( vector.log.value, Wu.uncertain.discreteArray(1:length(vector.log.value),iPermutation) ,'black' )
end
hold off;

%% Plot Chosen Weighting Function Discrete
figure('name','Chosen Weighting Function Discrete');
semilogx(0,length(vector.log.value));
hold on;
grid on;


for cur_i=1: 1 : nPermutations^2
    semilogx( vector.log.value, Wu.tf.discrete,'black' )
end

hold off;

%% Plot Fitted Weighting Function
figure('name','Weighting Function');
hold on;
grid on;
bode(Wu.tf.value)
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
bode(L.design.value,S.design.value,T.design.value)
legend('Loop Function','Sensitivity Function','Complimentary Sensitivity Function')
hold off;

%% Plot Nominal Loop, Sensitivity, and complimentary senstivity function
figure('name','Nominal Loop function and sensitivity functions');
hold on;
grid on;
bode(L.nominal.value,S.nominal.value,T.nominal.value)
legend('Nominal Loop Function','Nominal Sensitivity Function','Nominal Complimentary Sensitivity Function')
hold off;

%% Plot nichols with Sp and Tp
% ngrid('new')
figure('name','Nichols of loop function');
myngridst(T.design.p.value,S.design.p.value)
legend('Tp','Sp')
hold on
nichols(L.design.value,'r')
hold off;

%% Plot nominal nichols of Ln with Sp and Tp
% ngrid('new')
figure('name','Nichols of nominal loop function');
myngridst(T.design.p.value,S.design.p.value)
hold on
nichols(L.nominal.value,'r')
legend('Tp','Sp','Ln')
hold off;

%% check for nominal performance
figure('name','Check NP, should not pass 0db');
bode(Ws.tf.value*S.nominal.value,Wt.tf.value*T.nominal.value) % both curves should not pass 0db
legend('Ws*Sn','Wt*Tn')


%% check robust performance
% blue should be over red for lf
% blue should be under green for hf

figure('name','Check RP, blue over red for lf, blue under green for hf ');
bode(Ws.tf.value/(1-Wu.tf.value),'r',L.design.value,'b',(1-Ws.tf.value)/Wu.tf.value,'g')
legend('Ws/(1-Wu)','L','(1-Ws)/Wu')


%% Check for robust stability
figure('name','Check RS, should not pass 0db');
bode(Wu.tf.value*T.nominal.value) % should not pass 0db
legend('Wu*Tn')

%% Check for nominal performance and robust stability
figure('name','Check NP and RS, should not pass 0db');
bode(Ws.tf.value*S.nominal.value+Wu.tf.value*T.nominal.value) % should not pass 0db
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