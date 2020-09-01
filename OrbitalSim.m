clc;
clear;
close all;
format long g;

sunMass = 1.989E30;
earthMass = 5.972E24;
earthDist = -149.6E9;
%pvrm
sun = CelestialBody([0,0],[0,0],100,1E10,'static');
planet1 = CelestialBody([-100,0],[0,0],50,1E3);
uni = Universe([sun,planet1], 10);

frames = 200;
sim = figure();
disp("a big bang bangs...");
for i = 1:frames
    if(~ishghandle(sim))
        break 
    end
    % DEBUG: bodies not updating with new planet1
    % update physics 
    % Find a better solution than _update...
    uni.bodies(2) = PhysEng.updateCelestialBody(uni.bodies(2), uni);
    %planet1.vel = planet1_update.vel; planet1.pos = planet1_update.pos;
    disp(uni.bodies(2));
    
    % prepare frame below
    clf();
    hold on;
    xlim([-2E2,2E2]); % [-150E9,150E9]
    ylim([-1E2,1E2]); % [-1E3,1E3]
    % draw points below
    scatter(uni.bodies(1).pos(1), uni.bodies(1).pos(2), 2*uni.bodies(1).radius, 'RED', 'filled');
    scatter(uni.bodies(2).pos(1), uni.bodies(2).pos(2), 2*uni.bodies(2).radius, 'GREEN', 'filled');
    hold off;


    drawnow();
end
disp("a big crunch crunches...");

