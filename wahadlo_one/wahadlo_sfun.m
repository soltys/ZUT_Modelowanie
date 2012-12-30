function [ sys, x0, str, ts] = wahadlo_sfun(t,x,u,flag,l,m,fi0,to)
switch flag
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes(l,m,fi0,to);
    case 2,
        sys = mdlUpdate(t,x,u,l);
    case {1, 3, 4,9}
        sys = [];
    otherwise
        error(['Unhandled flag =', num2str(flag)]);
end
end

function [sys,x0,str,ts] =  mdlInitializeSizes(l,m,fi0,to)
sizes = simsizes;
sizes.NumContStates = 0;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 0;
sizes.NumInputs = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes=1;
sys = simsizes(sizes);
x0 = [];
str=[];
ts = [to 0];
graphics_init(l,m,fi0);
end

function sys = mdlUpdate(t,x,u,l)
fig = get_param(gcbh,'UserData');
if ishandle(fig)
    ud = get(fig, 'UserData');
    set(ud.s, 'XData', -l*sin(u), 'YData', -l*cos(u));
    set(ud.p, 'XData', [0 -l*sin(u)], 'YData', [0 -l*cos(u)]);
    drawnow
    pause(0.01);
end
sys = [];
end

function graphics_init(l,m,fi0)
figureName = 'Wizualizacja wahadla';
Fig=figure('Name', figureName);
u=fi0;
p= line('XData', [0 -l*sin(u)], 'YData', [0 -l*cos(u)],...
    'Color', 'r','LineWidth',2,'Erase','normal');
s = line('XData', -l*sin(u), 'YData', -l*cos(u),...
    'Color', 'b','Marker','.','MarkerSize',5*m, 'Erase','normal');
axis([-1.1*l 1.1*l -1.1*l 1.1*l]);
set(gca, 'DataAspectRatio',[1 1 1]);
set(gca, 'XTick', [-l 0 l], 'YTick', [-l 0 l]);
FigUD.p = p;
FigUD.s = s;
set(Fig, 'UserData', FigUD);
set_param(gcbh, 'UserData', Fig);
end