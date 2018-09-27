% Isabel Cristina López Giraldo
% 4 bar mechanism (kinematic analysis)


clear all
clc
close all

%Dimensions of the bars
a=2.23;
b=4.47;
c=6;
d=8;

%Initial variables
phi2initial=0;
omega2initial=1;
alpha2initial=1;
counter=0;

%Newton-Raphson

for phi2=0:0.05:2*pi
    counter=counter+1;
    xi=[1;2.2];
    residue=1;
    while residue>0.00001
        %Function
        fx = [a*cos(phi2)+b*cos(xi(1))-c*cos(xi(2))-d;
            a*sin(phi2)+b*sin(xi(1))-c*sin(xi(2))];
        
        %The Jacobian
        Jx = [-b*sin(xi(1)) c*sin(xi(2));
              b*cos(xi(1)) -c*cos(xi(2))];
        
        xf = xi - pinv(Jx)*fx;
        xi = xf;
        residue = xf - xi;
        residue = norm(fx);
    end
    
    %Aceleration
    alpha2=alpha2initial;
    
    %Angular velocity as a function of rotation and not time
    omega2=sqrt(2*alpha2*(phi2-phi2initial)+omega2initial^2);
    
    %Velocity
    vfinal=-inv(Jx)*[-a*omega2*sin(phi2);a*omega2*cos(phi2)];
    V(:,counter)=[omega2;vfinal];
    
    
    dJx=[-b*vfinal(1)*cos(xf(1)) c*vfinal(2)*cos(xf(2));
        -b*vfinal(1)*sin(xf(1)) c*vfinal(2)*sin(xf(2))];
    
    atan=[-a*alpha2*sin(phi2);
        a*alpha2*cos(phi2)];
    
    anorm=[-a*omega2^2*cos(phi2);
        -a*omega2^2*sin(phi2)];
    afinal=-inv(Jx)*(dJx*vfinal+atan+anorm);
    
    P(:,counter)=[alpha2;afinal];
    
    X=[0 a*cos(phi2) d+c*cos(xf(2)) d];
    Y=[0 a*sin(phi2) c*sin(xf(2)) 0];
    plot(X, Y,'b')
    whitebg('w')
    title('4 bar mechanism')
    xlabel('x (arbitrary units)');
    ylabel('y (arbitrary units)');
    axis ([ -2 8 -4 7])
    % Pause for the mechanism is optional  
    pause(0.005)
end

figure (1)
X=[0:0.05:2*pi];
Y=[V(2,:)];
plot(X,Y,'m')
title('Velocity')
xlabel('x (arbitrary units)');
ylabel('y (arbitrary units)');
hold on
Y=[V(3,:)];
plot(X,Y,'c')
legend('Velocity 2','Velocity 3')
axis equal

figure (2)
X=[0:0.05:2*pi];
Y=[P(2,:)];
plot(X,Y,'g')
title('Aceleration')
xlabel('x (arbitrary units)');
ylabel('y (arbitrary units)');
hold on
Y=[P(3,:)];
plot(X,Y,'r')
legend('Aceleration 2','Aceleration 3')
axis equal

