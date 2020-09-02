
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

timestep = 0.75;
frames = 1000;

planet1 = CelestialBody("Red",   'r', [0,0], [0,deg2rad(0)],  5, 60, 8E12, "static");
planet2 = CelestialBody("Blue",  'b', [-150,0],  [2,deg2rad(90)], 5, 30, 8E10);
planet3 = CelestialBody("Green", 'g', [-140,0], [2.75,deg2rad(90)], 5, 15, 5E1);

x_limit = [-200,200];
y_limit = [-200,200];
uni = Universe([planet1,planet2,planet3],timestep,x_limit, y_limit);
uni.bigBang(frames);


