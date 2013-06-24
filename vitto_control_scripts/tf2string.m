% name: tf2string
% author: vittorio alfieri

% example:
% W1_out=tf2string(W1)
% 
%
% output:
% W1_out =
% (s + 37.0)/(1.646*s)

function output_string = tf2string(input_tf)

syms s

sym_num=poly2sym(input_tf.num{:},s);
sym_num=vpa(sym_num, 4);
char_num=char(sym_num);

sym_den=poly2sym(input_tf.den{:},s);
sym_den=vpa(sym_den, 4);
char_den=char(sym_den);

output_string = ['(', char_num, ')/(', char_den, ')'];
s=tf('s');