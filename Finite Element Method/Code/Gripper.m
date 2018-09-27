%Finite element analysis
%Isabel Cristina Lopez Giraldo

%Gripper Script.

clear all
close all
clc

A1 = (1.5 * 10^-3) * (2 * 10^-3);
A2 = (1.5 * 10^-3) * (8 * 10^-3);

I1 = ((1.5 * 10^-3) * (2 * 10^-3)^3) / 12;
I2 = ((1.5 * 10^-3) * (8 * 10^-3)^3) / 12;

E = 172 * 10^6;

nodes = [1   48.64   0;
         2   45      29.63;
         3   20.37   230.20;
         4   16.56   261.25;
         5   25.04   274.15;
         6   29.24   279.52;
         7   55.21   271.09;
         8   47.71   273.52;
         9   0       289.03;
         10  0.37    293.27;
         11  5.38    357.57;
         12  29.26   364.87;
         13  54.58   372.61;
         14  70.89   377.6;
         15  64.79   447.29;
         16  102.56  447.29;
         17  94.46   377.6;
         18  112.77  372.71;
         19  138.1   364.87;
         20  161.98  357.57;
         21  166.98  293.27;
         22  167.35  289.03;
         23  119.64  273.52;
         24  112.14  271.09;
         25  139.51  279.52;
         26  142.31  274.15;
         27  150.79  261.25;
         28  146.98  230.2;
         29  122.35  29.63;
         30  118.71  0];

     nodes(:,2) = nodes(:,2) * 10^-3;
     nodes(:,3) = nodes(:,3) * 10^-3;
     
elements = [1   1   30  A2  I2  E;
            2   1   2   A1  I1  E;
            3   2   3   A2  I2  E;
            4   3   4   A1  I1  E;
            5   4   5   A2  I2  E;
            6   5   6   A1  I1  E;
            7   7   8   A1  I1  E;
            8   8   6   A2  I2  E;
            9   6   9   A2  I2  E;
            10  9   10  A1  I1  E;
            11  10  11  A2  I2  E;
            12  11  12  A1  I1  E;
            13  12  13  A2  I2  E;
            14  13  14  A1  I1  E;
            15  11  15  A2  I2  E;
            16  20  16  A2  I2  E;
            17  18  17  A1  I1  E;
            18  19  18  A2  I2  E;
            19  20  19  A1  I1  E;
            20  21  20  A2  I2  E;
            21  22  21  A1  I1  E;
            22  25  22  A2  I2  E;
            23  23  25  A2  I2  E;
            24  24  23  A1  I1  E;
            25  26  25  A1  I1  E;
            26  27  26  A2  I2  E;
            27  28  27  A1  I1  E;
            28  29  28  A2  I2  E;
            29  30  29  A1  I1  E];

dispbc = [1   1   2  -(10 * 10^-3);
          2   7   1  0;
          3   7   2  0;
          4   7   3  0;
          5   14  1  0;
          6   14  2  0;
          7   14  3  0;
          8   17  1  0;
          9   17  2  0;
          10  17  3  0;
          11  24  1  0;
          12  24  2  0;
          13  24  3  0];
      
forces = [0 0  0  0];

plotNodes(nodes)
hold on
plotElements(elements,nodes)
axis equal

[L, Theta] = GeomProp(elements,nodes);

[globalK] = CalculateK (elements,nodes,dispbc);

[globalU, globalF] = SolveMet(elements,nodes,dispbc,forces);

[stresses] = Stresses(nodes,elements,dispbc,forces);