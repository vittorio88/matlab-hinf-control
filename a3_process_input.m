%%% Process input

%% Process Gp input


if isfield(Gp, 'coefficient')
    % Get nominal value for plant coefficients
    for iCoeff=1: 1 : length(Gp.coefficient)
        Gp.coefficient(iCoeff).nominal=(Gp.coefficient(iCoeff).low + Gp.coefficient(iCoeff).high)/2;
    end
    
    % substitute nominal values into Gp string
    Gp.nominal.string = strrep(Gp.inputString, Gp.coefficient(1).name, 'Gp.coefficient(1).nominal');
    if length(Gp.coefficient) > 1
        Gp.nominal.string = strrep(Gp.nominal.string, Gp.coefficient(2).name, 'Gp.coefficient(2).nominal');
        if length(Gp.coefficient) > 2
            Gp.nominal.string = strrep(Gp.nominal.string, Gp.coefficient(3).name, 'Gp.coefficient(3).nominal');
        end
    end
else
    Gp.nominal.string = Gp.inputString;
end
% build plant transfer function
Gp.nominal.tf= eval(Gp.nominal.string);
[Gp.nominal.numerator,Gp.nominal.denominator]=tfdata(Gp.nominal.tf,'v');

% Count poles at origin
Gp.nOriginPoles=countpolesatorigin(Gp.nominal.tf);


% plant static gain
Kp=dcgain(Gp.nominal.tf*s^Gp.nOriginPoles);

%% Calculate Feedforward gain
Gf=Gr/(Kd*Gs);



%% Build input functions
% Input functions are dependent on order of disturbance, coefficients, and
% include downhill tf.
r.signal  = buildsignalinputfunction(  r.values );
da.signal = buildsignalinputfunction( da.values );
dp.signal = buildsignalinputfunction( dp.values );
ds.signal = buildsignalinputfunction( ds.values );

%% Scale input signals by downhill transfer function or gain before
%% addition
% cltf string is derived from block diagram reduction from feedback form

r.cltfString = '( Gc*Ga*Gp/(1+Gf*Gs*Gc*Ga*Gp) )';% aka Gry
r.errorString = strcat( tf2string(tf(r.signal)), '* (', int2str(Kd) ,' - ',r.cltfString,')');

da.cltfString='( Gp / (1 + Gp*Ga*Gc*Gf*Gs) )';
da.errorString= strcat(da.cltfString , ' * ' , tf2string(tf(da.signal) ));

dp.cltfString='(1 / (1 + Gp*Ga*Gc*Gf*Gs) )';
dp.errorString= strcat(dp.cltfString , ' * ' , tf2string(tf(dp.signal) ));

ds.cltfString='(Gf*Gc*Ga*Gp / (1 + Gp*Ga*Gc*Gf*Gs) )';
ds.errorString= strcat(ds.cltfString , ' * ' , tf2string(tf(ds.signal) ));


%% Caclulate attenuation required by filter masks
if da.values.type == 2
    
    % Calculate Ms_lf based on values.coefficient, errors.max, and
    % values.tf if present
    if isa(da.values.tf,'double')
        Ms_lf.value=da.errors.max/da.values.coefficient;
    end
    if isa(da.values.tf,'tf')
        Ms_lf.value=da.errors.max/da.values.coefficient- evalfr(da.values.tf,1i*da.values.frequency) ;
    end
    Ms_lf.db=20*log10(Ms_lf.value) ;
end

if dp.values.type == 2
    
    % Calculate Ms_lf based on values.coefficient, errors.max, and
    % values.tf if present
    if isa(dp.values.tf,'double')
        Ms_lf.value=dp.errors.max/dp.values.coefficient;
    end
    if isa(dp.values.tf,'tf')
        Ms_lf.value=dp.errors.max/dp.values.coefficient - evalfr(dp.values.tf,1i*dp.values.frequency) ;
    end
    Ms_lf.db=20*log10(Ms_lf.value) ;
end


if ds.values.type==2
    if isa(ds.values.tf,'double')
        Mt_hf.value=ds.errors.max*Gs/ds.values.coefficient;
    end
    if isa(ds.values.tf,'tf')
        Mt_hf.value=ds.errors.max*Gs/ds.values.coefficient - evalfr(ds.values.tf,1i*ds.values.frequency) ;
    end
    Mt_hf.db=20*log10(Mt_hf.value);
end

