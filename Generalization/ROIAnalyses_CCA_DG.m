%% Initialization
clear all %#ok<*CLALL>
% Restores the MATLAB search path to default
restoredefaultpath
% Add present directory to search path
addpath(genpath('/home/haolei/Projects/data_CBD/2020_Hao_CommDevArchi/Codes/Generalization'));

%% Run analysis
% Arrange data
%ImgArrange_con_Cond6

% Preparation before analysis
PreliminaryTasks_CCA

% Calculate the generalization index of each ROI
BootstrapROI_CCA_Cond6_NS
