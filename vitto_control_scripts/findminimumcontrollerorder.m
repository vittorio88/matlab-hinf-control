% name: findminimumcontrollerorder
% author: vittorio alfieri

% example:
% minimumControllerOrder =
% findminimumcontrollerorder(toleratedError, inputOrder, nPlantPoles)
%
%
% output:
% minimumControllerOrder =
% 1

function minimumControllerOrder = findminimumcontrollerorder(toleratedError, nPolesOfHighestOrderInput, nPolesPlant)

if toleratedError == 0
    minimumControllerOrder =  nPolesOfHighestOrderInput + nPolesPlant + 1;
end

if abs(toleratedError) > 0
    minimumControllerOrder = nPolesOfHighestOrderInput + nPolesPlant;
end

