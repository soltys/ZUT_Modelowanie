function [u] = force(k)
x=[0 1 3];
y=[-1 -1 -0.5];
d=-1;
w=0;
c=0;
for i=1:3
    w=w+(x(i)-k(1))/(sqrt((x(i)-k(1))^2+(y(i)-k(2))^2+d^2))^3;
end
for i=1:3
    c=c+(y(i)-k(2))/(sqrt((x(i)-k(1))^2+(y(i)-k(2))^2+d^2))^3;
end
u(1)=w;
u(2)=c;