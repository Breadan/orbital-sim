
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

timestep = 0.2;
frames = 10000;
pframes = 2650;
x_limit = [-250,250];
y_limit = [-500,500];

%{
% moon & planet
planet1 = CelestialBody("Red",   'r', [-150,5],  [2.64,deg2rad(90)],  5, 15, 9E5);
planet2 = CelestialBody("Blue",  'b', [-160,0],  [1.95,deg2rad(90)], 5, 30, 9E10);
planet3 = CelestialBody("Green", 'g', [0,0],     [0,deg2rad(225)], 5, 60, 9E12, "static");
%}

o = [0.996, 0.611, 0.043];
i = [0.584, 0.043, 0.996];
v = [0.729, 0.043, 0.996];

planet1 = CelestialBody("R", 'r', [-150,-500], [2.75,deg2rad(90)],  5, 15, 9E1);
planet2 = CelestialBody("O",  o,  [-100,-500], [2.70,deg2rad(90)],  5, 15, 9E1);
planet3 = CelestialBody("Y", 'y', [-50,-500],  [2.65,deg2rad(90)],  5, 15, 9E1);
planet4 = CelestialBody("G", 'g', [0,-500],    [2,deg2rad(90)],     5, 15, 9.6E11);
planet5 = CelestialBody("B", 'b', [50,-500],   [2.65,deg2rad(90)],  5, 15, 9E1);
planet6 = CelestialBody("I",  i,  [100,-500],  [2.70,deg2rad(90)],  5, 15, 9E1);
planet7 = CelestialBody("V",  v,  [150,-500],  [2.75,deg2rad(90)],  5, 15, 9E1);


uni = Universe([planet1,planet2,planet3,planet4,planet5,planet6,planet7],timestep,x_limit, y_limit);
uni.bigBang(frames, pframes);


