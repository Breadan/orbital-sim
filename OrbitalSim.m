clc;
clear;
close all;
format long g;

sunMass = 1.989E30;
earthMass = 5.972E24;
earthDist = -149.6E9;
%pvrm
sun = CelestialBody([0,0],[0,0],100,1E7,'static');
planet1 = CelestialBody([-100,0],[-10,0],50,1E7);
uni = Universe([sun,planet1], 25);



disp("a big bang bangs...");
figure();
for i = 1:uni.time
    % update physics
    planet1 = PhysEng.updateCelestialBody(planet1, uni);
    
    % prepare frame below
    clf();
    hold on;
    xlim([-2E2,2E2]); % [-150E9,150E9]
    ylim([-1E2,1E2]); % [-1E3,1E3]
    % draw points below
    scatter(sun.pos(1), sun.pos(2), 2*sun.radius, 'RED', 'filled');
    scatter(planet1.pos(1), planet1.pos(2), 2*planet1.radius, 'GREEN', 'filled');
    hold off;


    drawnow();
end
disp("a big crunch crunches...");

