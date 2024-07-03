%% Set some parameters, configure MATLAB path, and load data
% Configure analyses:
ConfigureAnalysisOptions

% Load data
%ReadSharedData_Age1
%ReadSharedData_Age2
ReadSharedData_Age3

% Read low age group children data
g1C = load('/home/haolei/Projects/data_CBD/2020_Hao_CommDevArchi/BrainImg/Generalization/g1C.mat');
% Read high age group children data
g2C = load('/home/haolei/Projects/data_CBD/2020_Hao_CommDevArchi/BrainImg/Generalization/g2C.mat');
% Read low age group adults data
g3A = load('/home/haolei/Projects/data_CBD/2020_Hao_CommDevArchi/BrainImg/Generalization/g3A.mat');

% Mask data
MaskLONI_tmp_CCA

% Clear command line
clc