
%% Plot Weighting Function Permutations and Chosen Weighting Function
if isfield(Gp, 'coefficient')
    figure('Name','Wu permutations and selection')
    hold on
    grid on;
    bode(Wu.multiplicative.tf.value,'r')
    h = findobj(gcf,'type','line');
    set(h,'linewidth',4);
    bode(Wu.multiplicative.uncertain.value,'g')
    hold off
end

%% Sensitivity function values and weights
figure('name','Sensitivity function values and weights');
hold on
sstar_subplot1 = subplot(121);
title(sstar_subplot1, 'S* range')
bode(S.star.upperLimit*s,S.star.lowerLimit*s, S.star.value);
legend('S* upper limit','S* lower limit','S* chosen')

sstar_subplot2 = subplot(122);
title(sstar_subplot2, 'nominal')
bode(S.design.value,tf(S.design.p.value),Ws.tf.inv,S.star.lowerLimit*s)
legend('S design','S design peak','Ws^-1','S.star.lowerLimit*s')

hold off


%% Plot Loop, Sensitivity, and complimentary senstivity function
figure('name','Loop function and sensitivity functions');
hold on
lst_subplot1 = subplot(121);
bode(L.design.value,S.design.value,T.design.value,tf(S.design.p.value),tf(T.design.p.value));
legend('L','S','T','Sp','Tp')

sstar_subplot2 = subplot(122);
bode(L.nominal.value,S.nominal.value,T.nominal.value,tf(S.design.p.value),tf(T.design.p.value))
legend('L','S','T','Sp','Tp')

title(lst_subplot1, 'design')
title(sstar_subplot2, 'nominal')
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
check_subplot1 = subplot(121);
title(check_subplot1, 'Nominal output with weighting functions should not pass 0db')
bode(Ws.tf.value*S.nominal.value,Wt.tf.value*T.nominal.value) %should not pass 0db
legend('NP:Ws*Sn','NP:Wt*Tn')
if isfield(Gp, 'coefficient')
    bode( Wu.multiplicative.tf.value*T.nominal.value) % should not pass 0db
    legend('RS:Wu*Tn')
    bode(Ws.tf.value*S.nominal.value+ Wu.multiplicative.tf.value*T.nominal.value) % should not pass 0db
    legend('NP & RS: Ws*Sn + Wu*Tn')
    
    check_subplot2 = subplot(122);
    title(check_subplot2, 'Check RP, blue over red for lf, blue under green for hf')
    bode(Ws.tf.value/(1- Wu.multiplicative.tf.value),'r',L.design.value,'b',(1-Ws.tf.value)/ Wu.multiplicative.tf.value,'g')
    legend('Ws/(1-Wu)','L','(1-Ws)/Wu')
end


hold off



%% Plot Simulink error signals
figure('name','Simulink error signals');
hold on

% plot max err
error_subplot1 = subplot(221);
title(error_subplot1, 'Error function Er (Gre*r-Kd*r)')
plot(simulink_ery_time, ones( length(simulink_ery_out), 1)*r.errors.max,'linewidth',4,'color','r')
set(error_subplot1,'NextPlot','add'); 
plot(simulink_ery_time,simulink_ery_out)

error_subplot2 = subplot(222);
title(error_subplot2, 'Error function Ea')
plot(simulink_eay_time, ones( length(simulink_eay_out), 1)*da.errors.max,'linewidth',4,'color','r')
set(error_subplot2,'NextPlot','add'); 
plot(simulink_eay_time,simulink_eay_out)

error_subplot3 = subplot(223);
title(error_subplot3, 'Error function Ep')
plot(simulink_epy_time, ones( length(simulink_epy_out), 1)*dp.errors.max,'linewidth',4,'color','r')
set(error_subplot3,'NextPlot','add'); 
plot(simulink_epy_time,simulink_epy_out)

error_subplot4 = subplot(224);
title(error_subplot4, 'Error function Es')
plot(simulink_esy_time, ones( length(simulink_esy_out), 1)*ds.errors.max,'linewidth',4,'color','r')
set(error_subplot4,'NextPlot','add'); 
plot(simulink_esy_time,simulink_esy_out)


hold off


%% End
hold off;