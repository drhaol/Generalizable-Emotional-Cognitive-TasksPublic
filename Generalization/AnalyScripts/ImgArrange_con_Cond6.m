% written by hao1ei (ver_20.06.17)
% hao1ei@foxmail.com
% qinlab.BNU
clear
clc

%% Set up
% The task name corresponds to the first level condition in model
task_name = {
    'task1_ant', 'task1_ant', 'task2_nb', 'task2_nb', ...
    'task3_em', 'task3_em'};

% Which contrast imaging files need to be modeling corresponds to above task
task_con = {'1', '2', '2', '3', '1', '2'};
% task1_ant: 1, alerting; 2, oeirnting; 3, executive
% task2_nb: 1, nb00; 2, nb11; 3, nb22
% task3_em: 1, emotion; 2, control; 3, emo-con

% Path of the present script
script_dir = '/home/haolei/Projects/data_CBD/2020_Hao_CommDevArchi/Codes/GenralRepresent';
% Path of the participants list
subj_list = '/home/haolei/Projects/data_CBD/2020_Hao_CommDevArchi/Codes/GenralRepresent/list_t1_g2C.txt';
% Path of the first level analysis results
firstlv_dir = '/home/haolei/Projects/data_CBD/2019_Hao_DevBrainFuncAtlas/derivatives/firstlevel';
% Path of the data after arrangement
firstlv_arrdir = '/home/haolei/Projects/data_CBD/2019_Hao_DevBrainFuncAtlas/derivatives/genral_represent/g2C';

%% Read participants list
fid = fopen(subj_list); sublist = {}; cnt = 1;
while ~feof (fid)
    linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
    sublist(cnt,:) = linedata{1}; cnt = cnt + 1; %#ok<*SAGROW>
end
fclose(fid);

%% Start arrangement
for icond = 1:size(task_con, 2)
    % Create and change to the arrangement path
    arrdir = fullfile(firstlv_arrdir, ['Cond', num2str(icond)]);
    mkdir(arrdir); cd(arrdir)
    
    for isub = 1:size(sublist, 1) % Number of participants
        % Locate to the target imaging file
        subfile = fullfile(firstlv_dir, task_name{1,icond}, ['sub-', sublist{isub, 1}], ...
            ['con_000', task_con{1, icond}, '.nii']);
        % Copy file and rename
        copyfile(subfile, fullfile(arrdir, [sublist{isub, 1}, '.nii']));
    end
end

%% Done
cd(script_dir)
disp('All Done');