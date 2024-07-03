% Mask data within GM and LONI atlas MFC regions

% mask_template=fmri_data(which('Grp_CBD_All_fdr05.nii')); % this is a .nii file where all 6 MFC regions have a value of 1 and all other voxels are set to 0

gm_mask=fmri_data(which('TPM.nii')); %tissue probability map from SPM distribution
gm_mask.dat=gm_mask.dat(:,1)>.5; %threshold at prob GM > 50%

%% Adult
%[masked_dat_A]=apply_mask(A.FullDataSet,mask_template); %first apply MFC mask
[masked_dat_A]=apply_mask(A.FullDataSet,gm_mask); %then apply GM mask

% some contrasts have no ACC activity, clean up for analysis CHECK THIS
masked_dat_A.Y=masked_dat_A.Y(~masked_dat_A.removed_images);
A.FullDataSet.Y=A.FullDataSet.Y(~masked_dat_A.removed_images);
masked_dat_A=remove_empty(masked_dat_A);

%% Child Low
%[masked_dat_Clow]=apply_mask(Clow.FullDataSet,mask_template); %first apply MFC mask
[masked_dat_Clow]=apply_mask(Clow.FullDataSet,gm_mask); %then apply GM mask

% some contrasts have no ACC activity, clean up for analysis CHECK THIS
masked_dat_Clow.Y=masked_dat_Clow.Y(~masked_dat_Clow.removed_images);
Clow.FullDataSet.Y=Clow.FullDataSet.Y(~masked_dat_Clow.removed_images);
masked_dat_Clow=remove_empty(masked_dat_Clow);

%% Child High
%[masked_dat_Chigh]=apply_mask(Chigh.FullDataSet,mask_template); %first apply MFC mask
[masked_dat_Chigh]=apply_mask(Chigh.FullDataSet,gm_mask); %then apply GM mask

% some contrasts have no ACC activity, clean up for analysis CHECK THIS
masked_dat_Chigh.Y=masked_dat_Chigh.Y(~masked_dat_Chigh.removed_images);
Chigh.FullDataSet.Y=Chigh.FullDataSet.Y(~masked_dat_Chigh.removed_images);
masked_dat_Chigh=remove_empty(masked_dat_Chigh);
