% Isabel Cristina Lopez Giraldo

% This function assemblies the globalU and the globalF.

function [globalU, globalF] = UFassembly(nodes,elements,forces,dispbc)

n = size(nodes,1);
m = size(elements,1);
p = size(dispbc,1);
f = size(forces,1);
globalU = zeros(n * 3,1);
globalF = zeros(n * 3,1);

[IndexDof, FixedDof, FreeDof] = DofIndexes(elements,dispbc,nodes);

globalU(FixedDof,1) = globalU(FixedDof,1) + dispbc(:,4);
globalF(FreeDof,1) = globalF(FreeDof,1) + forces(:,4);
end