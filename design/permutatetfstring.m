function [ permutatedVector ] = permutatetfstring( tfString, coefficientStruct, nPermutations)
%perfmutateTfStringOneDof This function will permutate a transfer function over a
%range of values for up to three dependent variables and save values into an
%array
% sample:
%     Gp.inputString='(10e6*K)/((s^2 + P*s))';
%     Gp.coefficient(1)=struct('name','K'...
%         ,'low', 0.8 ...
%         ,'high', 1.2 );
%     Gp.coefficient(2)=struct('name','P'...
%         ,'low', 420 ...
%         ,'high', 580 );
%     transferFunctionString = Gp.inputString;
%     coefficientStruct=Gp.coefficient;
%     nPermutations=10;


s=tf('s');
nCoeff=length(coefficientStruct);

%% create vectors from with nPermutations amount of slices that goes from
% low to high value of range of uncertain coefficient
uncertaintyRange(1:nCoeff,1:nPermutations)=0;

for iCoeff = 1:nCoeff
    %    for iPerm = 1 : nPermutations
    uncertaintyRange(iCoeff,1:nPermutations) = ...
        coefficientStruct(iCoeff).low:...
        (coefficientStruct(iCoeff).high - coefficientStruct(iCoeff).low)/(nPermutations - 1) :...
        coefficientStruct(iCoeff).high;
end


%% init values, iIndex is index for serialezed tfs, permutated vector is
% unidimensional array containing all uncertain tfs
iIndex=1;
permutatedVector=tf(zeros(1,1,(nPermutations^nCoeff),1));

%% permutate tf throughout uncertainty vector
if nCoeff == 1
    for iPerm=1:nPermutations
        uncertainString = strrep(tfString, coefficientStruct(1).name, uncertaintyRange(1,iPerm));
        permutatedVector(:,:,iIndex,1) = eval(uncertainString);
        iIndex = iIndex +1;
    end
end

if nCoeff == 2
    for iPerm=1:nPermutations
        for jPerm=1:nPermutations
            uncertainString = strrep(tfString, coefficientStruct(1).name, num2str(uncertaintyRange(1,iPerm)) );
            uncertainString = strrep(uncertainString, coefficientStruct(2).name, num2str(uncertaintyRange(2,jPerm)));
            permutatedVector(:,:,iIndex,1) = eval(uncertainString);
            iIndex = iIndex +1;
        end
    end
end

if nCoeff == 3
    for iPerm=1:nPermutations
        for jPerm=1:nPermutations
            for kPerm=1:nPermutations
                uncertainString = strrep(tfString, coefficientStruct(1).name, uncertaintyRange(1,iPerm));
                uncertainString = strrep(uncertainString, coefficientStruct(2).name, uncertaintyRange(2,jPerm));
                uncertainString = strrep(uncertainString, coefficientStruct(3).name, uncertaintyRange(3,kPerm));
                permutatedVector(:,:,iIndex,1) = eval(uncertainString);
                iIndex = iIndex +1;
            end
        end
    end
end



end

