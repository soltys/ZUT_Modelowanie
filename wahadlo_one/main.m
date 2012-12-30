clc
clear
close
sim('wahadlo');

length = 3;
axis_max = 1.2 * length;
axis_min = 1.2* (-length);
axis manual

hold on


ballSize = 0.3;

for theta=y'    
    axis ([axis_min axis_max axis_min axis_max]);
    R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    point = [0; length];
    rotated  = R * point ;
    
rectangle('Position',[-1,0,2,0.3],...
          'Curvature',[0,0],...
         'LineWidth',1, ...
         'FaceColor', 'g');
    line([0 rotated(1)],[0 -rotated(2)],'LineWidth',4,'Color',[0 0 0]); 
    
        rectangle('Position',[rotated(1)-(ballSize/2),-rotated(2)-(ballSize/2),ballSize,ballSize],...
          'Curvature',[1,1],...
         'LineWidth',1, ...
         'FaceColor', 'r');
    drawnow
    pause(0.01);
    clf
end


