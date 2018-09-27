%Isabel Cristina López Giraldo
% 4 bar mechanism- natural coordinates

clear all
clc
close all

%Lenghts
% la=sqrt((x1-xa)^2+(y1-ya)^2);
a=2;
b=4;
c=5;
d=6;

%Initial variables
phi1=0; %Angle from ground
phi2initial=0;
omega2initial=1;
alpha2initial=1;
counter=0;

%Coordinates of the bars
x1=2;
x2=3;
xa=0;
xb=d*cos(phi1)+xa;

y1=0.3;
y2=5;
ya=0;
yb=d*sin(phi1)+ya;

 xi=[x1 y1 x2 y2]';
%Newton-Raphson

for phi2=0:0.05:2*pi
    counter=counter+1;
    residue=1;
    while residue > 0.00001
        
        %Time
        t=(phi2-phi2initial)/omega2initial;
        %tp=((-omega2initial)+(sqrt(omega2initial^2-2*alpha2initial*(phi2initial-phi2)))/alpha2initial);
        %tn=((-omega2initial)-(sqrt(omega2initial^2-2*alpha2initial*(phi2initial-phi2)))/alpha2initial);
        
        
        x1=xi(1);
        y1=xi(2);
        
        x2=xi(3);
        y2=xi(4);
        
        %Function
        %x1-xa-a*cos((0.5*alpha2initial*t^2)+(omega2initial*t)+phi2initial)
        fx = [(x1-xa)^2+(y1-ya)^2-a^2;
              (x2-x1)^2+(y2-y1)^2-b^2;
              (x2-xb)^2+(y2-yb)^2-c^2;
               x1-xa-a*cos((omega2initial*t)+phi2initial)];
        
        %The Jacobian
        Jx=[2*(x1-xa)  2*(y1-ya)    0         0;
           -2*(x2-x1) -2*(y2-y1) 2*(x2-x1) 2*(y2-y1);
              0         0       2*(x2-xb) 2*(y2-yb);
              1         0           0         0];
                
        xf =xi - Jx\fx;
        xi = xf;
        residue = xf - xi;
        residue = norm(fx);
    end
    
    figure(1)
    plot(xa,ya,'ok')
    hold on
    plot(xb,yb,'ok')
    hold on
    plot(xf(1),xf(2),'or')
    plot(xf(3),xf(4),'ob')
    line([xa xf(1)],[ya xf(2)],'Color',[0 0 1])
    line([xf(1) xf(3)],[xf(2) xf(4)],'Color',[0 0 1])
    line([xf(3) xb],[xf(4) yb],'Color',[0 0 1])
    whitebg('w')
    title('4 bar mechanism')
    xlabel('x (arbitrary units)');
    ylabel('y (arbitrary units)');
    axis([-3 10 -4 10])
    hold off
    pause(0.005);
   
     %Aceleration
    alpha2=alpha2initial;
    
    %Angular velocity as a function of rotation and not time
    omega2=sqrt(2*alpha2*(phi2-phi2initial)+omega2initial^2);
    
    %Velocity
    vfinal=-Jx\[0;0;0;a*sin(omega2initial*t+phi2initial)*(omega2initial)];
    V(:,counter)=vfinal;
end
   
    figure (2)
    X=[0:0.05:2*pi];
    Y=V(1,:);
    plot(X,Y,'m')
    title('Velocity')
    xlabel('x (arbitrary units)');
    ylabel('y (arbitrary units)');
    hold on
    Y=V(2,:);
    plot(X,Y,'b')
    Y=[V(1,:).^2 + V(2,:).^2];
    plot(X,Y,'r')
    legend('Velocity 1','Velocity 2','Norm')
    axis equal
    
    figure(3)
    X=[0:0.05:2*pi];
    Y=V(3,:);
    plot(X,Y,'m')
    title('Velocity')
    xlabel('x (arbitrary units)');
    ylabel('y (arbitrary units)');
    hold on
    Y=V(4,:);
    plot(X,Y,'b')
    Y=[V(3,:).^2 + V(4,:).^2];
    plot(X,Y,'r')
    legend('Velocity 1','Velocity 2','Norm')
    axis equal


