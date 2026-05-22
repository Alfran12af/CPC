clear;
close all;
clc;

PrintBanner();

%% Mission definition

mission = DataDefinition();

%% Delta-V budget

[mission.DV_ascent, mission.DV_insertion] = ...
    GetDeltaV( ...
    mission.latitude, ...
    mission.H);

%% Launcher architecture

architecture = SetArchitecture();

%% Optimization parameters

params = SetParams();

%% Vehicle optimization

result = OptimizeRocket( ...
    mission, ...
    architecture, ...
    params);

%% Results

PrintResults(result);

%% Figures

PlotResults(result);