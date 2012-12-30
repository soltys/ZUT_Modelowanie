function [sys,x0,str,ts] = wahadlo_fun(t,x,u,flag,l1,l2,m1,m2,fi1,fi2,t0)

switch flag,
    case 0
        [sys,x0,str,ts] = mdlInitialzeSizes(l1,l2,m1,m2,fi1,fi2,t0);
        
    case 2,
        sys = mdlUpdate(t,x,u,l1,l2,m1);
        
    case {1,3,4,9}
        sys = [];
    otherwise
        error(['Unhandled flag = ',num2str(flag)]);
end
end

%__________________________________________________

function [sys,x0,str,ts] = mdlInitialzeSizes(l1,l2,m1,m2,fi1,fi2,t0)

sizes = simsizes;

sizes.NumContStates = 0;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 0;
sizes.NumInputs = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);

x0 = [];
str = [];
ts = [t0 0];

Inicjalizacja(l1,l2,m1,m2,fi1,fi2);
end
function sys = mdlUpdate(t,x,u,l1,l2,m1)

fig = get_param (gcbh,'UserData');
if ishandle(fig),
    ud = get(fig,'UserData');
    
    x1 =-l1*sin(u(1));
    y1 = -l1*cos(u(1));
    x2 = x1 -l2*sin(u(2));
    y2 = y1 -l2*cos(u(2));
    
    set(ud.s1,'XData', x1, 'YData', y1);
    set(ud.p1,'XData',[0 x1], 'YData',[0 y1]);
    
    set(ud.s2,'XData', x2, 'YData', y2);
    set(ud.p2,'XData',[x1 x2], 'YData',[y1 y2]);
    drawnow
end

sys = [];
end


function Inicjalizacja(l1,l2,m1,m2,fi1,fi2)
close all

FigureName = 'Wizualizacja wahadla';
Fig = figure('Name' , FigureName);

u1 = fi1;
u2 = fi2;
x1 =-l1*sin(u1);
y1 = -l1*cos(u1);
x2 = x1 -l2*sin(u2);
y2 = y1 -l2*cos(u2);

p1 = line('XData',[0 x1], 'YData', [0 y1], 'Color', 'r','LineWidth',1,'Erase','normal');
s1 = line('XData',x1,'YData', y1, 'Color', 'r', 'Marker','.','MarkerSize',4*m1,'Erase','normal');

p2 = line('XData',[x1 x2], 'YData',[y1 y2], 'Color', 'k','LineWidth',1,'Erase','normal');
s2 = line('XData',x2,'YData', y2, 'Color', 'k', 'Marker','.','MarkerSize',4*m2,'Erase','normal');

axis([-1.1*(l1+l2) 1.1*(l1+l2) -1.1*(l1+l2) 1.1*(l1+l2)])
set(gca,'DataAspectRatio',[1 1 1])
set(gca,'XTick',[-(l1+l2) 0 (l1+l2)] , 'YTick', [-(l1+l2) 0 (l1+l2)])
FigUD.p1 = p1;
FigUD.s1 = s1;
FigUD.p2 = p2;
FigUD.s2 = s2;
set(Fig,'UserData',FigUD);
set_param(gcbh,'UserData',Fig);
end



