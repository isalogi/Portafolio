% Isabel Cristina Lopez Giraldo

% This function calculates the K for each element and assambles it in the
% global K matrix.

function [globalK] = CalculateK (elements,nodes,dispbc)

n = size(elements,1);
m = size(nodes,1);
globalK = zeros(3*m,3*m);
localK = [];
IndexDof = [];

[L,Theta] = GeomProp(elements,nodes);

for element = 1:1:n
    
    A = elements(element,4);
    I = elements(element,5);
    E = elements(element,6);
    Ang = Theta(element,1);
    Long = L(element,1);
    
    Term1 = ((A*E/Long)*(cos(Ang))^2)+((12*E*I/(Long^3))*(sin(Ang))^2);
    Term2 = ((A*E/Long)*(sin(Ang))^2)+((12*E*I/(Long^3))*(cos(Ang))^2);
    Term3 = ((A*E/Long)-(12*E*I/(Long^3)))*(cos(Ang))*(sin(Ang));
    Term4 = 6*E*I*sin(Ang)/(Long^2);
    Term5 = 6*E*I*cos(Ang)/(Long^2);
    Term6 = 4*E*I/Long;
    Term7 = 2*E*I/Long;
    
    localK = [ Term1  Term3 -Term4 -Term1 -Term3 -Term4;
               Term3  Term2  Term5 -Term3 -Term2  Term5;
              -Term4  Term5  Term6  Term4 -Term5  Term7;
              -Term1 -Term3  Term4  Term1  Term3  Term4;
              -Term3 -Term2 -Term5  Term3  Term2 -Term5;
              -Term4  Term5  Term7  Term4 -Term5  Term6];
    
    [IndexDof, IndexFixDof, IndexFreeDof] = DofIndexes(elements,dispbc,nodes);    
          
    globalK(IndexDof(:,element),IndexDof(:,element)) = globalK(IndexDof(:,element),IndexDof(:,element)) + localK;
end
end
