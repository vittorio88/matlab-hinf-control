% xout3_report.m
% contains various checks to assure proper functionality of control system


%% Check error values

disp('########')
disp('Check error values')
disp('########')

% Error tolerances
r.maxError % Max output error due to reference input
r.actualError % output error due to reference input
da.maxError % Max output error in presence of da
da.actualError % output error in presence of da
dp.maxError % Max output error in presence of dp
dp.actualError % output error in presence of dp
ds.maxError % Max output error in presence of ds
ds.actualError % output error in presence of ds


%% Calculation of system steady-state gain.

disp('########')
disp('Calculation of system steady-state gain')
disp('########')

disp( ['Given Kd= ',num2str(Kd), ', and Gs= ',num2str(Gs),' the feedforward gain Gf can be calculated. '   ])
disp( 'The feedforward gain can be calculated using a characteristic negative-feedback block diagram.')
disp( 'INSERT NEGATIVE FEEDBACK BLOCK DIAGRAM' )
disp( 'ALG: Assuming H=1/Kd and H=Gs*Gf')
disp( 'ALG: and our desired Gry=Kd')
disp( 'ALG: We can solve for Gf')
disp([ 'ALG: Evaluating Gf=1/(Gs*Kd) with Gs=',num2str(Gs),' and Kd=',num2str(Kd),' we get Gf=',num2str(Gf)])

%% Calculation of steady-state reference output error

disp('########')
disp('Calculation of steady-state reference output error')
disp('########')

disp( ['Given that maxmimum error from input reference signal of order = ',num2str(r.order), ', and maximum error= ',num2str(r.maxError),' the minimum controller order can be calculated. '   ])
disp( 'Extracting the error signal from a block diagram permits us to find the the transfer function Gre to which we can then apply the final value theorem.')
disp( 'INSERT GRE BLOCK DIAGRAM' )
disp( 'ALG: Assuming mu + p >= h')
disp( 'ALG: Our error signal as a function of time is: er(t)= Yr(t)-Kd*r(t)')
disp( 'ALG: Performing the Laplace transform: er(s)= Yr(s)-Kd*r(s)')
disp( 'ALG: So Gre= er/r, and Gre= S*Kd')
disp( 'ALG: We can apply the final value theorem to Gre*r(s)')
disp( 'ALG: |erinf| = lim(s->0) s*|Gre*r(s)|')
disp( 'ALG: Substituting Gre for S*Kd, and r(s) for Ro/s^(h+1)')
disp( 'ALG: |erinf| = lim(s->0) s*|S*Kd*Ro/s^(h+1)|')
disp( 'ALG: Substituting S for S*(0)*s^(mu+p) which is S with no poles at s=0')
disp( 'ALG: |erinf| = lim(s->0) s*|S*(0)*s^(mu+p)*Kd*Ro/s^(h+1)|')
disp( 'ALG: Taking s out of the magnitude and regrouping')
disp( 'ALG: |erinf| = lim(s->0) s*s^(mu+p)/s^(h+1) * |S*(0) * Kd * Ro| ')
disp( 'ALG: Simplyifying s')
disp( 'ALG: |erinf| = lim(s->0) s^(mu+p)/s^(h) * |S*(0) * Kd * Ro| ')
disp( 'From the preceding equation, it is evident that for the limit to exist h must be greater than or equal to ')
if r.maxError == 0
    disp( 'For a null error mu + p must be greater than h')
    disp([ 'Because p=',num2str(sys_p),' and the input order is',num2str(r.order),' to satisfy the null error specification a mu of',num2str(dr_mu), 'is required'])
    
end
if r.maxError ~= 0
    disp( 'For a non-null error mu + p can be equal to h')
    disp([ 'Because p=',num2str(sys_p),' and the input order is',num2str(r.order),' to satisfy the non-null error specification a mu of',num2str(dr_mu), 'is required'])
    if dr_mu == sys_mu
        disp( 'Because mu + p = h, and we know the max error, we can calculate the maximum of S*(0)')
        disp( 'ALG: |erinf| = lim(s->0) |S*(0) * Kd * Ro| ')
        disp([ 'Evaluating with the max error ro=',num2str(r.maxError),' and the the steady-state gain Kd=',num2str(Kd),', and the input coefficient Ro=',num2str(r.coefficient)])
        disp('Solving for S*(0).... S*(0)<= (ro)/(Kd*Ro) ')
        disp([ 'ALG: S*(0)<=  ',num2str(r.maxError/Kd/r.coefficient)])
    end
end



%% Calculation of steady-state plant disturbance output error

if dp.type == 1
disp('########')
disp('Calculation of steady-state plant disturbance output error')
disp('########')

disp( ['Given that maxmimum error from input plant disturbance signal of order = ',num2str(dp.order), ', and maximum error= ',num2str(dp.maxError),' the minimum controller order can be calculated. '   ])
disp( 'Extracting the error signal from a block diagram permits us to find the the transfer function Gpe to which we can then apply the final value theorem.')
disp( 'INSERT GDP BLOCK DIAGRAM' )
disp( 'ALG: Assuming mu + p >= h')
disp( 'ALG: Our error signal as a function of time is: ep(t)= yd(t)')
disp( 'ALG: The steady-state output error of  edp(t) is defined by:')
disp( 'ALG: |edpinf| = lim(t->0) edp(t)')
disp( 'ALG: Where the Laplace transform is: edp(t)= edp(s)')
disp( 'ALG: Substituting edp(s)=ydp(s)')
disp( 'ALG: We can apply the final value theorem to ydp(s)')
disp( 'ALG: |edpinf| = lim(s->0) s*|ydp(s)|')
disp( 'ALG: Substituting edp(s)=ydp(s)=S(s)*dp(s)')
disp( 'ALG: |edpinf| = lim(s->0) s*|S(s)*dp(s)|')
disp( 'ALG: Substituting S for S*(0)*s^(mu+p), which is S with no poles at s=0')
disp( 'ALG: |edpinf| = lim(s->0) s*|S*(0)*s^(mu+p)*dp(s)|')
disp( 'ALG: Substituting dp(s) for Dp0/s^(h+1)')
disp( 'ALG: |edpinf| = lim(s->0) s*|S*(0)*s^(mu+p)*Dp0/s^(h+1)|')
disp( 'ALG: Taking s out of the magnitude and regrouping')
disp( 'ALG: |erinf| = lim(s->0) s*s^(mu+p)/s^(h+1) * |S*(0)| * Dp0  ')
disp( 'ALG: Simplyifying s')
disp( 'ALG: |erinf| = lim(s->0) s^(mu+p)/s^(h) * |S*(0)| * Dp0 ')
disp( 'From the preceding equation, it is evident that for the limit to exist h must be greater than or equal to ')
if dp.maxError == 0
    disp( 'For a null error mu + p must be greater than h')
    disp([ 'Because p=',num2str(sys_p),' and the input order is',num2str(dp.order),' to satisfy the null error specification a mu of',num2str(dp_mu), 'is required'])
    
end
if dp.maxError ~= 0
    disp( 'For a non-null error mu + p can be equal to h')
    disp([ 'Because p=',num2str(sys_p),' and the input order is',num2str(dp.order),' to satisfy the non-null error specification a mu of',num2str(dp_mu), 'is required'])
    if da_mu == sys_mu
        disp( 'Because mu + p = h, and we know the max error, we can calculate a maximum of S*(0)')
        disp( 'ALG: |edpinf| = lim(s->0) |(S*(0))| * Dp0 ')
        disp([ 'Evaluating with the max error rodp=',num2str(dp.maxError),' and the input coefficient Dp0=',num2str(dp.coefficient)])
        disp('Solving for S*(0).... S*(0)<= (rodp)/(Dp0) ')
        disp([ 'ALG: S*(0)<=  ',num2str(dp.maxError/dp.coefficient)])
    end
end


end

if dp.type == 2
disp('########')
disp('Calculation of steady-state plant disturbance output error')
disp('########')

disp( ['Given that maxmimum error from plant disturbance with frequency = ',num2str(dp.frequency), ', and maximum error= ',num2str(dp.maxError),' a constraint on the frequency domain can be calculated. '])
disp( 'Extracting the error signal from a block diagram permits us to find the the transfer function Gpe which we can use to estimate filter mask values')
disp( 'INSERT GDP BLOCK DIAGRAM' )
disp( 'ALG: Our error signal as a function of time is: dp(t)= ap*sin(wp*t)')
disp( 'ALG: The steady-state output error of  edp(t) is defined by:')
disp( 'ALG: |edpinf| = |ydpinf| <= rop')
disp( 'ALG: Where the Laplace transform is: edp(t)= edp(s)')
disp( 'ALG: Substituting edp(s)=ydp(s)')
disp( 'ALG: |edpinf| = ydp(s)')
disp( 'ALG: Substituting ydp(s)=|a|S(jwp)|*sin(jwp*t)|<=rop')
disp( 'ALG: |edpinf| = =|a|S(jwp)|*sin(jwp*t)|<=rop')
disp( 'ALG: Rearranging')
disp( 'ALG: S(jw) <= rop/ap = Ms_lf')
disp( 'ALG: We have calculated un upper bound of S at a disturbance frequency')
disp([ 'ALG: Evaluating Ms_lf with rop=',num2str(r.maxError),' and input coefficient ap=',num2str(dp.coefficient),' we get Ms_lf=',num2str(Ms_lf),' = ',num2str(Ms_lf_db),'db'])
    
end



%% Calculation of steady-state actuator disturbance output error

if da.type == 1
disp('########')
disp('Calculation of steady-state actuator disturbance output error')
disp('########')

disp( ['Given that maxmimum error from input actuator disturbance signal of order = ',num2str(da.order), ', and maximum error= ',num2str(da.maxError),' the minimum controller order can be calculated. '   ])
disp( 'Extracting the error signal from a block diagram permits us to find the the transfer function Gpe to which we can then apply the final value theorem.')
disp( 'INSERT GDP BLOCK DIAGRAM' )
disp( 'ALG: Assuming mu + p >= h')
disp( 'ALG: Our error signal as a function of time is: ea(t)= ya(t)')
disp( 'ALG: The steady-state output error of  eda(t) is defined by:')
disp( 'ALG: |edainf| = lim(t->0) eda(t)')
disp( 'ALG: Where the Laplace transform is: eda(t)= eda(s)')
disp( 'ALG: Substituting eda(s)=yda(s)')
disp( 'ALG: We can apply the final value theorem to yda(s)')
disp( 'ALG: |edainf| = lim(s->0) s*|yda(s)|')
disp( 'ALG: Substituting eda(s)=yda(s)=aa*(1+Gc*Ga*Gf*Gs)/Gpn where Gpn and Gc have poles in s=0 removed')
disp( 'ALG: |edainf| = lim(s->0) s^(mu+p)/s^h*|aa*(1+Gc*Ga*Gf*Gs)/Gpn |')
disp( 'From the preceding equation, it is evident that for the limit to exist h must be greater than or equal to ')
if da.maxError == 0
    disp( 'For a null error mu + p must be greater than h')
    disp([ 'Because p=',num2str(sys_p),' and the input order is',num2str(da.order),' to satisfy the null error specification a mu of',num2str(da_mu), 'is required'])
    
end
if da.maxError ~= 0
    disp( 'For a non-null error mu + p can be equal to h')
    disp([ 'Because p=',num2str(sys_p),' and the input order is',num2str(da.order),' to satisfy the non-null error specification a mu of',num2str(da_mu), 'is required'])
    if da_mu == sys_mu
        disp( 'Because mu + p = h, and we know the max error, we can calculate a maximum of S*(0)')
        disp( 'ALG: |edainf| = lim(s->0) s^(mu+p)/s^h*|aa*(1+Gc*Ga*Gf*Gs)/Gpn |')
    end
end

end

%% Calculation of steady-state sensor disturbance output error
if ds.type == 2
disp('########')
disp('Calculation of steady-state sensor disturbance output error')
disp('########')

disp( ['Given that maxmimum error from sensor disturbance with frequency = ',num2str(ds.frequency), ', and maximum error= ',num2str(ds.maxError),' a constraint on the frequency domain can be calculated. '])
disp( 'Extracting the error signal from a block diagram permits us to find the the transfer function Gpe which we can use to estimate filter mask values')
disp( 'INSERT GDS BLOCK DIAGRAM' )
disp( 'ALG: Our error signal as a function of time is: ds(t)= as*sin(ws*t)')
disp( 'ALG: The steady-state output error of  eds(t) is defined by:')
disp( 'ALG: |edsinf| = |ydsinf| <= ros')
disp( 'ALG: Where the Laplace transform is: eds(t)= eds(s)')
disp( 'ALG: Substituting eds(s)=yds(s)')
disp( 'ALG: |edpinf| = yds(s)')
disp( 'ALG: Substituting yds(s)=|as|T(jws)|*sin(jws*t)|<=ros*Gs')
disp( 'ALG: |edpinf| = =|as|T(jws)|*sin(jws*t)|<=ros*Gs')
disp( 'ALG: Rearranging')
disp( 'ALG: T(jw) <= ros*Gs/as = Mt_hf')
disp( 'ALG: We have calculated un upper bound of T at a disturbance frequency')
disp([ 'ALG: Evaluating Mt_hf with ros=',num2str(ds.maxError),' and input coefficient as=',num2str(ds.coefficient),'and sensor gain Gs=',num2str(Gs),' we get Mt_hf=',num2str(Mt_hf),' = ',num2str(Mt_hf_db),'db'])
    
end



%% System explanation
disp('########')
disp('Elaborate on system')
disp('########')

disp('for time constraints, copy formulas from sources, and evaluate')
disp('state chosen system type, number of poles mu, and chosen crossover frequency')


disp('########')
disp('Elaborate on filters')
disp('########')

disp('Insert and evaluate Tp and Sp formulas')
disp('Explain how Ws is built, and evaluate values to check filtering')
disp('Draw filter')
disp('Explain how Wt is built, and evaluate values to check filtering')
disp('Draw filter')
disp('Explain how Wu is built.')
disp('Draw filter and propogations')


disp('########')
disp('Elaborate on chosen weighting functions')
disp('########')

disp('W1 is Ws. Poles in s=0 must be swapped for low frequency poles.')
disp('W2 is higher of Wu or Wt without unstable zeros')
disp('Explain how poles are removed to not cause simulink errors and then readded using sderiv')

disp('########')
disp('Elaborate on contoller generation')
disp('########')

disp('Elaborate on Plant M with filters')
disp('draw plant m')
disp('readd filters')
disp('optimize in to lti sys, convert to state space, then tf, then zpk')

disp('########')
disp('Elaborate on loop functions')
disp('########')

disp('write loop functions')
disp('draw nichols')
disp('draw RS and RP verifications')


disp('########')
disp('system simulation')
disp('########')

disp('draw system')
disp('draw time performance')
disp('draw error signal with error functions, and calculated errors vs simulated errors')
