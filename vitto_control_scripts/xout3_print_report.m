% xout3_report.m
% contains various checks to assure proper functionality of control system


%% Check error values

disp('########')
disp('Check error values')
disp('########')

% Error tolerances
dr_error_max % Max output error due to reference input
dr_error % output error due to reference input
da_error_max % Max output error in presence of da
da_error % output error in presence of da
dp_error_max % Max output error in presence of dp
dp_error % output error in presence of dp
ds_error_max % Max output error in presence of ds
ds_error % output error in presence of ds


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

%% Calculation of steady-state output error

disp('########')
disp('Calculation of steady-state output error')
disp('########')

disp( ['Given that maxmimum error from input reference signal of order = ',num2str(dr_h), ', and maximum error= ',num2str(dr_error_max),' the minimum controller order can be calculated. '   ])
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
disp( 'ALG: Substituting S for (S*)*s^(mu+p) which is S with no poles at s=0')
disp( 'ALG: |erinf| = lim(s->0) s*|(S*)*s^(mu+p)*Kd*Ro/s^(h+1)|')
disp( 'ALG: Taking s out of the magnitude and regrouping')
disp( 'ALG: |erinf| = lim(s->0) s*s^(mu+p)/s^(h+1) * |(S*) * Kd * Ro| ')
disp( 'ALG: Simplyifying s')
disp( 'ALG: |erinf| = lim(s->0) s^(mu+p)/s^(h) * |(S*) * Kd * Ro| ')
disp( 'From the preceding equation, it is evident that for the limit to exist h must be greater than or equal to ')
if dr_error_max == 0
    disp( 'For a null error mu + p must be greater than h')
    disp([ 'Because p=',num2str(sys_p),' and the input order is',num2str(dr_h),' to satisfy the null error specification a mu of',num2str(dr_mu), 'is required'])
    
end
if dr_error_max ~= 0
    disp( 'For a non-null error mu + p can be equal to h')
    disp([ 'Because p=',num2str(sys_p),' and the input order is',num2str(dr_h),' to satisfy the non-null error specification a mu of',num2str(dr_mu), 'is required'])
    if dr_mu == sys_mu
        disp( 'Because mu + p = h, and we know the max error, we can calculate the maximum of S*(0)')
        disp( 'ALG: |erinf| = lim(s->0) |(S*) * Kd * Ro| ')
        disp([ 'Evaluating with the max error ro=',num2str(dr_error_max),' and the the steady-state gain Kd=',num2str(Kd),', and the input coefficient Ro=',num2str(dr_coeff)])
        disp('Solving for S*(0).... S*(0)<= (ro)/(Kd*Ro) ')
        disp([ 'ALG: S*(0)<=  ',num2str(dr_error_max/Kd/dr_coeff)])
    end
end

