%%% Process input

%% Get nominal plant transfer function

% Get nominal value for plant coefficients
for iCoeff=1: 1 : length(Gp.coefficient)
    Gp.coefficient(iCoeff).nominal=(Gp.coefficient(iCoeff).low + Gp.coefficient(iCoeff).high)/2;
end

% substitute nominal values into Gp string
Gp.nominal.string = strrep(Gp.inputString, 'coeff1', 'Gp.coefficient(1).nominal');
if length(Gp.coefficient) > 1
    Gp.nominal.string = strrep(Gp.nominal.string, 'coeff2', 'Gp.coefficient(2).nominal');
    if length(Gp.coefficient) > 2
        Gp.nominal.string = strrep(Gp.nominal.string, 'coeff3', 'Gp.coefficient(3).nominal');
    end
end

% build plant transfer function
Gp.nominal.tf= eval(Gp.nominal.string);
[Gp.nominal.numerator,Gp.nominal.denominator]=tfdata(Gp.nominal.tf,'v');

% plant static gain
Kp=dcgain(Gp.nominal.tf);

%% Calculate Feedforward gain
Gf=Gr/(Kd*Gs);



%% Build input functions
r.signal=buildsignalinputfunction( r.coefficient, r.type, r.frequency, r.order, vector.log.value );
da.signal=buildsignalinputfunction( da.coefficient, da.type, da.frequency, da.order, vector.log.value);
dp.signal=buildsignalinputfunction( dp.coefficient, dp.type, dp.frequency, dp.order, vector.log.value );
ds.signal=buildsignalinputfunction( ds.coefficient, ds.type, ds.frequency, ds.order, vector.log.value);

%% Scale input signals by downhill transfer function or gain before
%% addition


r.cltfString='( Gc*Ga*Gp/(1+Gf*Gs*Gc*Ga*Gp) )';% aka Gry
r.tempString=strcat( '(', r.cltfString, ' - ', int2str(Kd) ,')' );
r.errorString= strcat( tf2string(tf(r.signal*r.tf)), ' * ' ,r.tempString );% aka Ery

da.cltfString='(Gp/ (1 + Gp*Ga*Gc*Gf*Gs))';
da.errorString= strcat(da.cltfString , ' * ' , tf2string(tf(da.signal*da.tf) ));


dp.cltfString='(1 / (1 + Gp*Ga*Gc*Gf*Gs))';
dp.errorString= strcat(dp.cltfString , ' * ' , tf2string(tf(dp.signal*dp.tf) ));

ds.cltfString='(Gf*Gc*Ga*Gp / (1 + Gp*Ga*Gc*Gf*Gs))';
ds.errorString= strcat(ds.cltfString , ' * ' , tf2string(tf(ds.signal*ds.tf) ));


