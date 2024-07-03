# %% Import package
import os
import glob

# %% Set up
img_flt = 'spmT*.nii'                                                                               # Filter keywords for imaging files which need to converting
img_dir = 'D:\\OneDrive\\Projects\\2018_Hao_AttenNeuroDev\\BrainImg\\IMGs\\FF_GrpxCond_SWU_FullSmp' # Path of imaging files which need to converting

# %% Set convert surface file
wb_commd = 'D:\\Applications\\Workbench\\Workbench_v1.3.2\\bin_windows64\\wb_command' # Path of the Workbench
surf_dir = 'D:\\Applications\\Workbench\\Template\\Conte69_Atlas_32k_v2'              # Path of the convert template
transurfL = os.path.join(surf_dir, 'Conte69.L.midthickness.32k_fs_LR.surf.gii')       # Which the left hemisphere template to use
transurfR = os.path.join(surf_dir, 'Conte69.R.midthickness.32k_fs_LR.surf.gii')       # Which the right hemisphere template to use

# %% Convert .nii to .shape.gii
# When convert ROI and the resulting surface image have strange shading
# around the edges of the ROIs. Use "-enclosing" instead of "-trilinear"
img_files = sorted(glob.glob(os.path.join(img_dir, img_flt))) # Acquire name of imaging files

# Start conversion
for iimg in img_files:
    os.system('%s -volume-to-surface-mapping %s %s %s_L.shape.gii -trilinear' %
              (wb_commd, iimg, transurfL, iimg[0:-4]))
    os.system('%s -volume-to-surface-mapping %s %s %s_R.shape.gii -trilinear' %
              (wb_commd, iimg, transurfR, iimg[0:-4]))

# Done
print('scr_nii2gii is executed')
