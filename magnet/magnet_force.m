function [u]=magnet_force(pendulumX, pendulumY)
x=[-0.2 -0.2 0.4];
y=[0.5 -0.5 0];
d=[0.1 0.1 0.1];

w=0;
c=0;
for i=1:3
    w=w+(x(i)-pendulumX)/(sqrt((x(i)-pendulumX)^2+(y(i)-pendulumY)^2+d(i)^2))^3;
end
for i=1:3
    c=c+(y(i)-pendulumY)/(sqrt((x(i)-pendulumX)^2+(y(i)-pendulumY)^2+d(i)^2))^3;
end
u(1)=w;
u(2)=c;

end