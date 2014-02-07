%% Plot Weighting Function Permutations and Chosen Weighting Function
figure('Name','Wu permutations and selection')
hold on
grid on;
bode(Wu.multiplicative.tf.value,'r')
h = findobj(gcf,'type','line');
set(h,'linewidth',4);
bode(Wu.multiplicative.uncertain.value,'g')
hold off


%% Plot Loop, Sensitivity, and complimentary senstivity function
figure('name','Loop function and sensitivity functions');
hold on
lst_subplot1 = subplot(121);
bode(L.design.value,S.design.value,T.design.value,tf(S.design.p.value),tf(T.design.p.value));
legend('L','S','T','Sp','Tp')

lst_subplot2 = subplot(122);
bode(L.nominal.value,S.nominal.value,T.nominal.value,tf(S.design.p.value),tf(T.design.p.value))
legend('L','S','T','Sp','Tp')

title(lst_subplot1, 'design')
title(lst_subplot2, 'nominal')
hold off

%% Plot nichols with Sp and Tp
figure('name','Nichols with Loop function');
hold on
nichols_subplot1 = subplot(121);
myngridst(T.design.p.value,S.design.p.value)
nichols(L.design.value,'r')
legend('Tp','Sp','L')

nichols_subplot2 = subplot(122);
myngridst(T.design.p.value,S.design.p.value)
nichols(L.nominal.value,'r')
legend('Tp','Sp','Ln')

title(nichols_subplot1, 'design')
title(nichols_subplot2, 'nominal')

hold off


%% Check for NS, NP, RS, and RP
figure('name','Check for NS, NP, RS, and RP');
hold on
check_subplot1 = subplot(221);
bode(Ws.tf.value*S.nominal.value,Wt.tf.value*T.nominal.value) % both curves should not pass 0db
legend('Ws*Sn','Wt*Tn')

check_subplot2 = subplot(222);
bode(Ws.tf.value/(1- Wu.multiplicative.tf.value),'r',L.design.value,'b',(1-Ws.tf.value)/ Wu.multiplicative.tf.value,'g')
legend('Ws/(1-Wu)','L','(1-Ws)/Wu')

check_subplot3 = subplot(223);
bode( Wu.multiplicative.tf.value*T.nominal.value) % should not pass 0db
legend('Wu*Tn')

check_subplot4 = subplot(224);
bode(Ws.tf.value*S.nominal.value+ Wu.multiplicative.tf.value*T.nominal.value) % should not pass 0db
legend('Ws*Sn + Wu*Tn')

title(check_subplot1, 'Check NP, should not pass 0db')
title(check_subplot2, 'Check RP, blue over red for lf, blue under green for hf')
title(check_subplot3, 'Check RS, should not pass 0db')
title(check_subplot4, 'Check NP and RS, should not pass 0db')

hold off



%% Plot Simulink error signals
figure('name','Simulink error signals');
hold on
error_subplot1 = subplot(221);
plot(simulink_ery_time,[simulink_ery_out, ones( length(simulink_ery_out), 1)*r.errors.max])

error_subplot2 = subplot(222);
plot(simulink_eay_time,[simulink_eay_out, ones( length(simulink_eay_out), 1)*da.errors.max])

error_subplot3 = subplot(223);
plot(simulink_epy_time,[simulink_epy_out, ones( length(simulink_epy_out), 1)*dp.errors.max])

error_subplot4 = subplot(224);
plot(simulink_esy_time,[simulink_esy_out, ones( length(simulink_esy_out), 1)*ds.errors.max])

title(error_subplot1, 'Error function Er (Gre*r-Kd*r)')
title(error_subplot2, 'Error function Ea')
title(error_subplot3, 'Error function Ep')
title(error_subplot4, 'Error function Es')

hold off

% %% Plot Error function Er OLD
% figure('name','Error function Er (Gre*r-Kd*r)');
% plot(simulink_ery_time,simulink_ery_out)
% %% Plot Error function Ea
% figure('name','Error function Ea');
% plot(simulink_eay_time,simulink_eay_out)
% %% Plot Error function Ep
% figure('name','Error function Ep');
% plot(simulink_epy_time,simulink_epy_out)
% %% Plot Error function Es
% figure('name','Error function Es');
% plot(simulink_esy_time,simulink_esy_out)

%% End
hold off;