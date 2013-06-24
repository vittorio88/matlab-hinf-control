function [ uncertainTfArray ] = permutatetfstringonedof( transferFunctionString, stringName1, lowValue1, highValue1)
%perfmutateTfStringOneDof This function will permutate a transfer function over a
%range of values for up to one dependent variable and save values into an
%array
% sample: 
% transferFunctionString =
% '(2*(10^5)*(s + Gp_coeff1))/((s - 20)*(s + Gp_coeff2)*(s/200+1))';
s=tf('s');
nPermutations=10;
uncertaintyVector1 = lowValue1 :(highValue1 - lowValue1)/(nPermutations - 1) : highValue1;


%% Create Array with all permutations
uncertainTfArray = tf( 1:nPermutations );
tempString=strrep(transferFunctionString, stringName1,'uncertaintyVector1(iCoeff1)');

for iCoeff1=1 : 1 : nPermutations
    uncertainTfArray(iCoeff1) = eval(tempString);
end


end

