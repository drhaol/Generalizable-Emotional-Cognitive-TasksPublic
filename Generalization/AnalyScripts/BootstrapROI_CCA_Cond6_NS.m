%% Perform bootstrap analysis for inference within each ROI
% Create RDM-based model
n_bs     = 5000;                     % Number of bootstrap
res_name = 'bs_Cond6_CCA_DG_5000.mat'; % Name of the result file

model_lv1_cond = [91 91 89];    % number of children in the four low age group
model_lv2_task = [182 182 178]; % number of participants in the each process
model_lv3_grp  = [546 546 534]; % number of participants in the each attention domain

%% Create variable with roi names
rois = {
    'ns_r01_md', ...
    'ns_r02_ipl', ...
    'ns_r03_fef', ...
    'ns_r04_psma', ...
    'ns_r05_dlpfc', ...
    'ns_r06_ai'
    };

%% create RDMs (same for all rois)
% Construct vectors indicating the membership of children in the four low age group
model_lv1_X = []; cnt_cond = 0; cnt_sub = 0;
for igrp = 1:length(model_lv3_grp)
    for icond = 1:6
        cnt_cond = cnt_cond + 1;
        for isub = 1:model_lv1_cond(1,igrp)
            cnt_sub = cnt_sub + 1;
            model_lv1_X(cnt_sub,1) = cnt_cond; %#ok<*SAGROW>
        end
    end
end

% Construct vectors indicating the membership of each process
model_lv2_X = []; cnt_task = 0; cnt_sub = 0;
for igrp = 1:length(model_lv3_grp)
    for itask = 1:3
        cnt_task = cnt_task + 1;
        for isub = 1:model_lv2_task(1,igrp)
            cnt_sub = cnt_sub + 1;
            model_lv2_X(cnt_sub,1) = cnt_task; %#ok<*SAGROW>
        end
    end
end

% Construct vectors indicating the membership of each attention domain
model_lv3_X = []; cnt_grp = 0; cnt_sub = 0;
for igrp = 1:length(model_lv3_grp)
    cnt_grp = cnt_grp + 1;
    for isub = 1:model_lv3_grp(1,igrp)
        cnt_sub = cnt_sub + 1;
        model_lv3_X(cnt_sub,1) = cnt_grp; %#ok<*SAGROW>
    end
end

inds_lv1 = condf2indic(ceil(model_lv1_X)); % Matrix of 0/1 based on age group membership
inds_lv2 = condf2indic(ceil(model_lv2_X)); % Matrix of 0/1 based on process membership
inds_lv3 = condf2indic(ceil(model_lv3_X)); % Matrix of 0/1 based on domain membership

% Effects unique to each age group (36 total)
for i=1:size(inds_lv1,2)
    RDM_lv1(i,:)=pdist(inds_lv1(:,i),'seuclidean');
end

% RDM for each attention process separately (9 total)
for i=1:size(inds_lv2,2)
    RDM_lv2(i,:)= pdist(inds_lv2(:,i),'seuclidean');
end

% RDM for each attention domain separately (3 total)
for i=1:size(inds_lv3,2)
    RDM_lv3(i,:)= pdist(inds_lv3(:,i),'seuclidean');
end

% Place RDMs in design matrix
X=[RDM_lv1' RDM_lv2' RDM_lv3'];

% Scale to have mean of 1000
for i=1:size(X,2)
    X(:,i)=1000*X(:,i)/sum(X(:,i));
end

%% Do bootstrap resampling separately for each neural RDM (per ROI)
if computeBootstrap
    clear b;
    for r = 1:length(rois)
        rng(6) % Start with same seed for each region of interest
        
        % Mask out data that is not within this ROI
        roi_masked_dat_g1C = apply_mask(masked_dat_g1C, remove_empty(fmri_data(which([rois{r} '.nii']))));
        roi_masked_dat_g2C = apply_mask(masked_dat_g2C, remove_empty(fmri_data(which([rois{r} '.nii']))));
        roi_masked_dat_g3A = apply_mask(masked_dat_g3A, remove_empty(fmri_data(which([rois{r} '.nii']))));
        
        roi_masked_dat.dat   = cat(2, roi_masked_dat_g1C.dat, roi_masked_dat_g2C.dat, roi_masked_dat_g3A.dat);
        
        % Bootstrap resampling of subjects within age group
        bootstrap_num = 0;
        for it = 1:n_bs % 5000 bootstrap samples
            bootstrap_num = bootstrap_num + 1;
            disp(['bootstrap number = ', num2str(bootstrap_num)])
            
            bs_inds(1:91)   =randi([1,91],1,91);    % Resample with replacement within 1 conditon
            bs_inds(92:182) =randi([92,182],1,91);  % Resample with replacement within 2 condition
            bs_inds(183:273)=randi([183,273],1,91); % Resample with replacement within 3 condition
            bs_inds(274:364)=randi([274,364],1,91); % ... ...
            bs_inds(365:455)=randi([365,455],1,91); % ... ...
            bs_inds(456:546)=randi([456,546],1,91); % ... ...
            
            bs_inds(547:637)=randi([547,637],1,91); % ... ...
            bs_inds(638:728)=randi([638,728],1,91); % ... ...
            bs_inds(729:819)=randi([729,819],1,91); % ... ...
            bs_inds(820:910)=randi([820,910],1,91); % ... ...
            bs_inds(911:1001)=randi([911,1001],1,91); % ... ...
            bs_inds(1002:1092)=randi([1002,1092],1,91); % ... ...
            
            bs_inds(1093:1181)=randi([1093,1181],1,89); % ... ...
            bs_inds(1182:1270)=randi([1182,1270],1,89); % ... ...
            bs_inds(1271:1359)=randi([1271,1359],1,89); % ... ...
            bs_inds(1360:1448)=randi([1360,1448],1,89); % ... ...
            bs_inds(1449:1537)=randi([1449,1537],1,89); % ... ...
            bs_inds(1538:1626)=randi([1538,1626],1,89); % Resample with replacement within 24 age group
            
            resampled_mat = roi_masked_dat.dat(:,bs_inds)'; % Grab data from bootstrap indices
            Y = pdist(resampled_mat,'correlation');         % Compute distance matrix on this data
            Y(Y<.00001) = NaN;                              % Exclude very small off diagonal elements (because subjects can be replicated, and because some subjects have low variance)
            
            [full_x] = glmfit([ones(length(Y),1) double(X)],Y','normal','constant','off'); % Estimate coefficients with OLS
            b(it,r,:) = full_x;                                                            % Store bootstrap statistic for each iteration, each roi
            
        end
        save([basedir filesep res_name],'b', '-v7.3'); % Save bootstrap statistics to disk
    end
end
