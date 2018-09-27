% Isabel Cristina Lopez Giraldo

% This function calculates the stresses for each element.

function [stresses] = Stresses(nodes,elements,dispbc,forces)

n = size(nodes,1);
m = size(elements,1);
stresses = [];

cMatrix = [];

[L,Theta] = GeomProp(elements,nodes);
[localU, localF] = Locals(nodes,elements,dispbc,forces);

for element = 1:1:m
    A = elements(element,4);
    I = elements(element,5);
    elementc = sqrt((I / A));
    Ang = Theta(element,1);
    elementF = localF(:,element);
    Moment1 = abs(elementF(3,1));
    Moment2 = abs(elementF(6,1));
    
    if Moment1 >= Moment2
        elementMoment = Moment1;
    else
        elementMoment = Moment2;
    end
    
    cMatrix = [cMatrix; elementc];
    AxS = (elementF(1,1) * cos(Ang) + elementF(2,1) * sin(Ang)) / A;
    ShS = (elementF(1,1) * sin(Ang) + elementF(2,1) * cos(Ang)) / A;
    BeS = elementMoment * elementc / I;
    
    stresses(element,1) = element;
    stresses(element,2) = AxS;
    stresses(element,3) = ShS;
    stresses(element,4) = BeS;
end
end