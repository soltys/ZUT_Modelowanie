function [sys,x0,str,ts] = sprzezyna_wahadlo_sfun(t,x,u,flag,mk,mw,l,g,c,k1,k2,phi0,z0,t0)

switch flag,
    case 0
        [sys,x0,str,ts] = mdlInitialzeSizes(mk,mw,l,g,c,k1,k2,phi0,z0,t0);
        
    case 2,
        sys = mdlUpdate(t,x,u,mk,mw,l);
        
    case {1,3,4,9}
        sys = [];
    otherwise
        error(['Unhandled flag = ',num2str(flag)]);
end
end

%__________________________________________________

function [sys,x0,str,ts] = mdlInitialzeSizes(mk,mw,l,g,c,k1,k2,phi0,z0,t0)

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

Inicjalizacja(mk,mw,l,g,c,k1,k2,phi0,z0,t0);
end
function sys = mdlUpdate(t,x,u,mk,mw,l)

fig = get_param (gcbh,'UserData');
if ishandle(fig)

     ud = get(fig,'UserData');
g = -1;
springY = [l*2/20,0];
delta = abs(g-u(1))/4;
set(ud.spring1, 'XData',[g,g+delta],'YData',springY);    
    g = g + delta;
    springY = fliplr(springY);
   set(ud.spring2,  'XData',[g,g+delta],'YData',springY);    
    g = g + delta;
    springY = fliplr(springY);
    set(ud.spring3,'XData',[g,g+delta],'YData',springY);    
    g = g + delta;
    springY = fliplr(springY);
    set(ud.spring4, 'XData',[g,g+delta],'YData',springY);
    
    
     x1 =-l*sin(u(2)) + u(1);
    y1 = -l*cos(u(2));

     set(ud.s1,'XData', x1, 'YData', y1);
     set(ud.p1,'XData',[u(1)+l*2/10 x1], 'YData', [l/10 y1]);
     

set(ud.block,'Position', [u(1) 0 l*2/5 l/5]);
     
     drawnow
end

sys = [];
end


function Inicjalizacja(mk,mw,l,g,c,k1,k2,phi0,z0,t0)
close all

FigureName = 'Wizualizacja sprezyna-bloczek-wahadlo';
Fig = figure('Name' , FigureName);

u2 = phi0;
x1 =-l*sin(u2) + z0;
y1 = -l*cos(u2);

g = -1;
springY = [0,l/5];
delta = abs(g-z0)/4;
    
spring1 =    line('XData',[g,g+delta],'YData',springY,'Color','k');    
    g = g + delta;
    springY = fliplr(springY);
    spring2 =    line('XData',[g,g+delta],'YData',springY,'Color','k');    
    g = g + delta;
    springY = fliplr(springY);
    spring3 =    line('XData',[g,g+delta],'YData',springY,'Color','k');    
    g = g + delta;
    springY = fliplr(springY);
    spring4 =    line('XData',[g,g+delta],'YData',springY,'Color','k');    
    

    

block =  rectangle('Curvature', [0 0],'Position', [z0 0 l*2/5 l/5], 'FaceColor', 'b','EdgeColor','b');
p1 = line('XData',[z0+l*2/10 x1], 'YData', [l/10 y1], 'Color', 'r','LineWidth',1,'Erase','normal');
s1 = line('XData',x1,'YData', y1, 'Color', 'g', 'Marker','.','MarkerSize',40*mw,'Erase','normal');



axis([-1.1*(l+z0) 1.1*(l+z0) -1.1*(l+z0) 1.1*(l+z0)])
set(gca,'DataAspectRatio',[1 1 1])
set(gca,'XTick',[-(l) 0 (l)] , 'YTick', [-(l) 0 (l)])
FigUD.p1 = p1;
FigUD.s1 = s1;
FigUD.block = block;
FigUD.spring1 = spring1;
FigUD.spring2 = spring2;
FigUD.spring3 = spring3;
FigUD.spring4 = spring4;
set(Fig,'UserData',FigUD);
set_param(gcbh,'UserData',Fig);
end



