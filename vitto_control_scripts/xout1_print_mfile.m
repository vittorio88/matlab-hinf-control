% ver_output.m
% output everything formatted as matlab script

Wt.out=tf2string(Wt.tf.value);
Wu.out=tf2string(Wu.tf.value);
Ws.out=tf2string(Ws.tf.value);

W1.tf.out=tf2string(W1.tf.value);
W1.mod.out=tf2string(W1.mod.value);
W2.tf.out=tf2string(W2.tf.value);
W2.mod.out=tf2string(W2.mod.value);

Gc.out=tf2string(Gc.tf.value);
Gc.mod.out=tf2string(Gc.mod.value);