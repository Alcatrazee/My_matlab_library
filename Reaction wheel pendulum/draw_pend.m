function draw_pend(states,rod_length)
figure(3);

for i = 1:size(states,1)
    clf;
    
    rectangle('position',[-0.2 -0.05 0.4 0.05],'facecolor',[0.9 0 0])
    rod_end_x = rod_length*cos(pi/2+states(i,2));
    rod_end_y = rod_length*sin(pi/2+states(i,2));
    rectangle('Position',[rod_end_x-0.04,rod_end_y-0.04,0.08,0.08],'Curvature',[1,1],  'FaceColor','r')
    line([0 rod_end_x],[0 rod_end_y],'LineWidth',2);
    axis([-0.4 0.4 -0.2 0.2]);
    axis equal
    drawnow
end
end