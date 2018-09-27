% Isabel Cristina Lopez Giraldo

% This function plots the nodes of the frame.

function plotNodes(nodes)

n = size(nodes,1);

for node = 1:1:n
    plot(nodes(node,2),nodes(node,3),'m.')
    hold on
end

hold off
end