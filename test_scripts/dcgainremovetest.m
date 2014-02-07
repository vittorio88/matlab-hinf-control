 


W1.mod.inv=W1.tf.inv /s^sys.h * (s/10+1)^sys.h * 10
% W1.mod.inv=W1.tf.inv*s^sys.h/(s/da.values.frequency*10^-1 + 1)^sys.h;
 
 
 zpk(W1.tf.inv)
 
 bode(W1.tf.inv, W1.mod.inv)