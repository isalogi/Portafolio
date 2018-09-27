% Isabel Cristina Lopez Giraldo

% This function plots the elements.

function plotElements(elements,nodes)

Ci = [];
Cf = [];
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
    plot([Ci(element,1),Cf(element,1)],[Ci(element,2),Cf(element,2)],'b')
    hold on
    
end

hold off
end