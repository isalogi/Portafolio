% Isabel Cristina Lopez Giraldo

% This function takes the GlobalK and the Free and Fixed vectors to create
% the matrices needed for the solution.

function [globalU, globalF] = SolveMet(elements,nodes,dispbc,forces)

n = size(nodes,1);
m = size(elements,1);

[IndexDof, FixedDof, FreeDof] = DofIndexes(elements,dispbc,nodes);
[globalK] = CalculateK (elements,nodes,dispbc);

[globalU, globalF] = UFassembly(nodes,elements,forces,dispbc);

globalU(FreeDof) = globalK(FreeDof,FreeDof) \ (globalF(FreeDof) + globalK(FreeDof,FixedDof) * globalU(FixedDof));

globalF = globalK * globalU;
end