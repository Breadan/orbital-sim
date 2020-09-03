
% TODO: implement instantaneous forces calculation, sim should not
%       calculate Fg based on where obj "should" be over given time,
%       but rather at every point of time and position it takes for
%       the obj to get from A to B (oscillation problem)
%       - alternative solution: disable center clipping, creates insane
%         amount of velocity

% NOTE: smaller timestep enables greater precision



clc;
clear;
close all;
format long g;

timestep = 1;
frames = 10000;

planet1 = CelestialBody("Red",   'r', [-150,0], [1.2,deg2rad(90)],  5, 60, 9E12, "static");
planet2 = CelestialBody("Blue",  'b', [150,0],  [0.8,deg2rad(90)], 5, 60, 9E12);
planet3 = CelestialBody("Green", 'g', [0,0],    [1E-1,deg2rad(225)], 5, 60, 9E12, "static");

x_limit = [-250,250];
y_limit = [-250,250];
uni = Universe([planet1,planet2,planet3],timestep,x_limit, y_limit);
uni.bigBang(frames);


