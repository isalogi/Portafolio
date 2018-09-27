% Isabel Cristina Lopez Giraldo

% This function creates de U, the k matrix and the forces for each element.

function [localU, localF] = Locals(nodes,elements,dispbc,forces)

n = size(nodes,1);
m = size(elements,1);
IndexVector = [];
Ind = zeros(3 * n,1);
IndexU = [];
localF = [];

[globalK] = CalculateK (elements,nodes,dispbc);
[IndexDof, FixedDof, FreeDof] = DofIndexes(elements,dispbc,nodes);
[globalU, globalF] = SolveMet(elements,nodes,dispbc,forces);

for Index1 = 1:1:m
    Ind = IndexDof(:,Index1);
    for Dof = 1:1:6
        IndexU = Ind(Dof,1);
        localU(Dof,1) = globalU(IndexU,1);
    end
    elementU(:,Index1) = localU;
end

for element = 1:1:m
    Kelement = globalK(IndexDof(:,element),IndexDof(:,element));
    U = elementU(:,element);
    Felement =  Kelement * U;
    localF = [localF Felement];
end
end