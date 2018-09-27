% Isabel Cristina Lopez Giraldo

% This function assings the indexes for each degree of freedom of the
% frame. It also defines de free and the fixed elements and corresponding vectors.

function [IndexDof, FixedDof, FreeDof] = DofIndexes(elements,dispbc,nodes)

n = size(elements,1);
p = size(dispbc,1);
Dof = size(nodes,1) * 3;
IndexDofT = [];
IndexDof = [];
FixedDof = [];
FreeDof = [];

for element = 1:1:n
    InitialNode = elements(element,2);
    FinalNode = elements(element,3);
    
    Index3 = InitialNode * 3;
    Index2 = InitialNode * 3 - 1;
    Index1 = InitialNode * 3 - 2;
    Index6 = FinalNode * 3;
    Index5 = FinalNode * 3 - 1;
    Index4 = FinalNode * 3 - 2;
    
    IndexDofT = [Index1; Index2; Index3; Index4; Index5; Index6];
    IndexDof = [IndexDof IndexDofT];
end

for disp = 1:1:p
    if dispbc(disp,3) == 1
        FixedDofT = dispbc(disp,2) * 3 - 2;
    end
    if dispbc(disp,3) == 2
        FixedDofT = dispbc(disp,2) * 3 - 1;
    end
    if dispbc(disp,3) == 3
        FixedDofT = dispbc(disp,2) * 3 ;
    end
    
    FixedDof = [FixedDof; FixedDofT];
end

for counter = 1:1:Dof
    FreeDof = [FreeDof;counter];
end

for disp2 = 1:1:p
    for counter2 = 1:1:(Dof - p)
        if FreeDof(counter2,1) == FixedDof(disp2,1)
           FreeDof(counter2,:) = [];
        end
    end
end
end