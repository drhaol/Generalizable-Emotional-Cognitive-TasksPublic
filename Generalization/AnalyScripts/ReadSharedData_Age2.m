%% This script takes imaging data saved in .nii files and formats as a CANLAB data object
% Number of conditions
cond_num = 6;
% Which sample the data belongs to
sample    = 'g2C';
% Name of the result file
set_name  = 'g2C.mat';
% Path of the participants list
subj_list = '/home/haolei/Projects/data_CBD/2020_Hao_CommDevArchi/Codes/GenralRepresent/list_t1_g2C.txt';
% Path of the data after arrangement
data_dir  = '/home/haolei/Projects/data_CBD/2019_Hao_DevBrainFuncAtlas/derivatives/genral_represent';

%% Read participants list
fid = fopen(subj_list); sublist = {}; cnt = 1;
while ~feof (fid)
    linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');
    sublist(cnt,:) = linedata{1}; cnt = cnt + 1; %#ok<*SAGROW>
end
fclose(fid);

%% Read data
image_counter = 0; % Initialize counter for storing data
for icond = 1:cond_num  % Indices of conditions
    
    for subject =1:length(sublist) % Indices of subjects
        
        tv=fmri_data([data_dir filesep sample filesep ['Cond' num2str(icond)] ...
            filesep sublist{subject,1} '.nii']); % Read data from disk
        tv=replace_empty(tv);                    % Replace voxels with 0 values (for concatenating)
        image_counter=image_counter+1;           % Update counter for indexing
        
        if image_counter==1                       % If this is the first image in data object
            FullDataSet=tv;                       % Initialize as temporary object
            FullDataSet.Y(image_counter,1)=icond; % First study so Y = 1
        else
            FullDataSet.dat=[FullDataSet.dat tv.dat]; % Concatenate data
            FullDataSet.Y(image_counter,1)=icond;     % Add study index to Y
        end
    end
end

% Remove voxels that are always 0
FullDataSet = remove_empty(FullDataSet);
% Save to disk as data object in .mat file
save([data_dir filesep set_name], 'FullDataSet');
