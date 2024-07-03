%% Set some parameters for doing analyses and configure path

% Perform bootstrap analyses (if true, this can be slow) or load bootstrap results (if false)
computeBootstrap = true;
% Location of scripts folder
basedir = which('ConfigureAnalysisOptions.m');
% Location of base folder
basedir = basedir(1:end-40);
% Some subjects have missing data in ROIs (and are excluded from some
% analyses), this suppressing warning about low variance
warning off stats:pdist:ConstantPoints

% Restores the MATLAB search path to default
restoredefaultpath
% Add basepath and subfolders
addpath(genpath(basedir));
% Add ROIs directory
addpath(genpath('/home/haolei/Projects/data_CBD/2020_Hao_CommDevArchi/BrainImg/ROIs'))
% Add spm directory
addpath(genpath('/home/haolei/Toolbox/spm12'));
% Add canlab core codes
addpath(genpath('/home/haolei/Toolbox/CanlabCore'));