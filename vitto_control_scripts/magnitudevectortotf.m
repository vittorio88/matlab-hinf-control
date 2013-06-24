function [ tfFitted ] = magnitudevectortotf( magnitudeVector, frequencyVector, order )
%magnitudevectortotf Convert magnidtuve vector to tf given a frequency
%vector

tf_packed=vpck(magnitudeVector',frequencyVector');
tf_fitted=fitsys(tf_packed, order); % 2nd argument is order of fit
[A,B,C,D]=unpck(tf_fitted);
[Z,P,K]=ss2zp(A,B,C,D);
[tfNum tfDen] = zp2tf(Z,P,K);
tfFitted = tf(tfNum, tfDen);

end

