clc;
clear;
close all;
format compact;

sun = CelestialBody([0,0],[0,0],100,1000,'static');
planet1 = CelestialBody([-10,0],[10,pi],5,50);
uni = Universe([sun,planet1], 100);


disp(rad2deg(PhysEng.testPhys(planet1, sun)));
disp(sun.vel);
disp(planet1.vel);

%{
figure();
for i = 1:uni.time
    clf();
    hold on;
    axis([0,1000,0,1000]);
    % draw points below
    %scatter(planet1(i,1), planet1(i,2), 2*radius, 'BLUE', 'filled');
    %scatter(planet2(i,1), planet2(i,2), 2*radius, 'RED', 'filled');
    hold off;


    drawnow();
end
%}