function [ uncertainTfArray ] = permutatetfstringthreedof( transferFunctionString, stringName1, lowValue1, highValue1, stringName2, lowValue2, highValue2, stringName3, lowValue3, highValue3, nPermutations)
%perfmutateTfStringOneDof This function will permutate a transfer function over a
%range of values for up to three dependent variables and save values into an
%array
% sample:
% transferFunctionString =
% '(2*(10^5)*(s + Gp_coeff1))/((s - 20)*(s + Gp_coeff2)*(s/200+1))';
s=tf('s');

uncertaintyVector1 = lowValue1 :(highValue1 - lowValue1)/(nPermutations - 1) : highValue1;
uncertaintyVector2 = lowValue2 :(highValue2 - lowValue2)/(nPermutations - 1) : highValue2;
uncertaintyVector3 = lowValue3 :(highValue3 - lowValue3)/(nPermutations - 1) : highValue3;

%% Create Array with all permutations
uncertainTfArray = tf( 1:nPermutations ) ;
tempString=strrep(transferFunctionString, stringName1,'uncertaintyVector1(iCoeff1)');
tempString=strrep(tempString, stringName2,'uncertaintyVector2(iCoeff2)');
tempString=strrep(tempString, stringName3,'uncertaintyVector3(iCoeff3)');

for iCoeff1=1 : 1 : nPermutations
    for iCoeff2=1 : 1 : nPermutations
        for iCoeff3=1 : 1 : nPermutations
            uncertainTfArray(iCoeff1, iCoeff2, iCoeff3) = eval(tempString);
        end
    end
end


end

