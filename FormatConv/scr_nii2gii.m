clear

%% Set up
img_head  = '*';
img_dir = 'D:\BrainImg\Cog_FDR_05_45\Mask';

%% Set tranform surface file
surf_dir  = 'C:\Users\Kirin\Applications\NeuToolbox\Conte69_Atlas_32k_v2';
transurfL = fullfile(surf_dir, 'Conte69.L.midthickness.32k_fs_LR.surf.gii');
transurfR = fullfile(surf_dir, 'Conte69.R.midthickness.32k_fs_LR.surf.gii');

%% Convert .nii to .shape.gii
% When convert ROI and the resulting surface image have strange shading
% around the edges of the ROIs. Use "-enclosing" instead of "-trilinear"
niiconvlist = dir(fullfile(img_dir, [img_head, '.nii']));
for inii = 1: length(niiconvlist)
    niifile = fullfile(img_dir, niiconvlist(inii).name);
    unix(cat(2, 'C:\Users\Kirin\Applications\NeuToolbox\workbench\bin_windows64\wb_command -volume-to-surface-mapping ', niifile, ' ', transurfL,...
        ' ', fullfile(img_dir, [niiconvlist(inii).name(1:end-4), 'L.shape.gii ']), '-trilinear'));
    unix(cat(2, 'C:\Users\Kirin\Applications\NeuToolbox\workbench\bin_windows64\wb_command -volume-to-surface-mapping ', niifile, ' ', transurfR,...
        ' ', fullfile(img_dir, [niiconvlist(inii).name(1:end-4), 'R.shape.gii ']), '-trilinear'));
end


%% Done
disp('=== Convert Done ===');