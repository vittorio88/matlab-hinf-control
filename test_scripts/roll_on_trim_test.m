%Ws.tf.inv


vector.log.freq.low=-5;
vector.log.freq.high=8;
vector.log.value = logspace(vector.log.freq.low,vector.log.freq.high,vector.log.slices); % Frequency vector for plotting (Goes from 10^-3 to 10^4. 3rd argument is how many slices)


if da.values.type== 2
stable_filt=Ws.tf.inv*(s-da.values.frequency*10^-1)^sys.h/s^sys.h
stable_filt=minreal(stable_filt)
end

if dp.values.type== 2
stable_filt=Ws.tf.inv*(s-dp.values.frequency*10^-1)^sys.h/s^sys.h
stable_filt=minreal(stable_filt)
end




% debug print
bode(Ws.tf.inv,tf(S.design.p.value),tf(Ms_lf.value),stable_filt ,vector.log.value)

