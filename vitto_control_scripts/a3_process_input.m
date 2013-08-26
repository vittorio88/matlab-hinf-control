%%% Process input

%% Get nominal plant transfer function

% Get nominal value for plant coefficients
for iCoeff=1: 1 : length(Gp.coeffecient)
    Gp.coeffecient(iCoeff).nominal=(Gp.coeffecient(iCoeff).low + Gp.coeffecient(iCoeff).high)/2;
end

% substitute nominal values into Gp string
Gp.nominal.string = strrep(Gp.inputString, 'coeff1', 'Gp.coeffecient(1).nominal');
if length(Gp.coeffecient) > 1
    Gp.nominal.string = strrep(Gp.nominal.string, 'coeff2', 'Gp.coeffecient(2).nominal');
    if length(Gp.coeffecient) > 2
        Gp.nominal.string = strrep(Gp.nominal.string, 'coeff3', 'Gp.coeffecient(3).nominal');
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
dp.signal=buildsignalinputfunction( dp.coefficient, dp.type, dp.frequency, dp.order, vector.log.value );
da.signal=buildsignalinputfunction( da.coefficient, da.type, da.frequency, da.order, vector.log.value);
ds.signal=buildsignalinputfunction( ds.coefficient, ds.type, ds.frequency, ds.order, vector.log.value);


%%% PICK UP HERE CHECK MEEEE
r.cltfNoGc=Ga*Gp.nominal.tf / (1-Gf*Gs*Ga*Gp.nominal.tf);
r.errorSignalNoGc =(1/r.cltfNoGc);

da.cltfNoGc=Gp.nominal.tf / (1-Gf*Gs*Ga*Gp.nominal.tf);
da.errorSignalNoGc =(1/r.cltfNoGc);

dp.cltfNoGc=1 / (1-Gf*Gs*Ga*Gp.nominal.tf);
dp.errorSignalNoGc =(1/r.cltfNoGc);

ds.cltfNoGc=  Gf*Ga*Gp.nominal.tf /(1-Ga*Gf*Gs*Gp.nominal.tf) ;
ds.errorSignalNoGc =(1/r.cltfNoGc);