% ver_output.m
% output everything formatted as matlab script
%% change displayformat to frequency

Wt.zpk.value.DisplayFormat='frequency';
Wu.zpk.value.DisplayFormat='frequency';
Ws.zpk.value.DisplayFormat='frequency';
W1.mod.zpk.DisplayFormat='frequency';
W1.mod.zpk.DisplayFormat='frequency';
W2.tf.zpk.DisplayFormat='frequency';
W2.mod.zpk.DisplayFormat='frequency';
Gc.zpk.value.DisplayFormat='frequency';
Gc.mod.zpk.DisplayFormat='frequency';


%% PRINT ZPK in frequency format

Wt.zpk.value
Wu.zpk.value
Ws.zpk.value
W1.mod.zpk
W1.mod.zpk
W2.tf.zpk
W2.mod.zpk
Gc.zpk.value
Gc.mod.zpk
%% build tf strings

Wt.out=tf2string(Wt.tf.value);
Wu.out=tf2string(Wu.tf.value);
Ws.out=tf2string(Ws.tf.value);

W1.tf.out=tf2string(W1.tf.value);
W1.mod.out=tf2string(W1.mod.value);
W2.tf.out=tf2string(W2.tf.value);
W2.mod.out=tf2string(W2.mod.value);

Gc.out=tf2string(Gc.tf.value);
Gc.mod.out=tf2string(Gc.mod.value);

%% print tf strings

Wt.out
Wu.out
Ws.out

W1.tf.out
W1.mod.out
W2.tf.out
W2.mod.out

Gc.out
Gc.mod.out
