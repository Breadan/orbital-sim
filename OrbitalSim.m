
% TODO: implement instantaneous forces calculation, sim should not
%       calculate Fg based on where obj "should" be over given time,
%       but rather at every point of time and position it takes for
%       the obj to get from A to B (oscillation problem)

clc;
clear;
close all;
format long g;

timestep = 1E5;
frames = 1000;

uni = Universe(Universe.setSolarSystem(),timestep);
uni.bigBang(frames);


