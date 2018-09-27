% Isabel Cristina Lopez Giraldo

% This function calculates the length and angle of each element.

function [L,Theta] = GeomProp(elements,nodes)

L = [];
Theta = [];
Ci = [];
Cf = [];
Lx = [];
Ly = [];
n = size(elements,1);
m = size(nodes,1);

for element = 1:1:n
    initialNode = elements(element,2);
    finalNode = elements(element,3);
    for node = 1:1:m
        if  initialNode == nodes(node,1)
            Xi = nodes(node,2);
            Yi = nodes(node,3);
            CiT = [Xi,Yi];
            Ci = [Ci ; CiT];
        end
        if  finalNode == nodes(node,1)
            Xf = nodes(node,2);
            Yf = nodes(node,3);
            CfT = [Xf,Yf];
            Cf = [Cf ; CfT];
        end
    end
    
    LxT = Cf(element,1) - Ci(element,1);
    LyT = Cf(element,2) - Ci(element,2);
    
    Lx = [Lx ; LxT];
    Ly = [Ly ; LyT];
    
    LT = sqrt(Lx(element,1)^2 + Ly(element,1)^2);
    L = [L ; LT];
    
    ThetaT = atan2(Ly(element,1) , Lx(element,1));
    Theta = [Theta ; ThetaT];
    
end
end