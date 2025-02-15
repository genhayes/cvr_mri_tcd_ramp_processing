#!/bin/bash
# G. Hayes 2025
# G. Hayes, S. Sparks, J. Pinto, and D. P. Bulte, "Models of Cerebrovascular Reactivity in BOLD-fMRI and Transcranial Doppler Ultrasound"

# This script is used to preprocess the fsl data for the ramp-protocol project
# It will perform the following steps:
# 1. BET image
# 2. Generate field_prepare.nii for fieldmap correction
# 3. Run FEAT analysis 
# 4. Generate percent signal change 4D file using filtered_func_data.nii
# 5. Saves the feat analysis outputs and percent signal change 4D file in the output directory preproc/feat/MRI-XXX

# use list of subjects to analyze
ID=(028 029) 

# set the path to the data directory 
data_dir='path/to/data'

# set the path to the output directory
output_dir='path/to/output'

# set the path to the fsl MNI directory
fsl_MNI_brain='/usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz'

for id in ${ID[@]}; do 
    echo "===> Starting processing of $id"
    # set the path to the subject directory
    subj_dir=$data_dir/MRI/W3T_2023_121_$id
    echo "subj_dir = $subj_dir"

    cd $subj_dir
    # If the brain mask for fieldmap doesn’t exist, create it
    if [ ! -f images_04_fieldmap_3mm_FoV_216x216x144_e2_brain.nii.gz ]; then
        echo "==> Creating brain mask for $id fieldmap"
        bet images_04_fieldmap_3mm_FoV_216x216x144_e2.nii images_04_fieldmap_3mm_FoV_216x216x144_e2_brain
    else
        echo "==> Brain mask already exists for $id fieldmap"
    fi

    # If the brain mask for structural doesn’t exist, create it
    if [ ! -f images_012_t1_mpr_ax_1mm_iso_PSN_brain.nii.gz ]; then
        echo "==> Creating brain mask for $id structural image"
        bet images_012_t1_mpr_ax_1mm_iso_PSN.nii images_012_t1_mpr_ax_1mm_iso_PSN_brain
    else
        echo "==> Brain mask already exists for $id structural image"
    fi

    # If the brain mask for functional doesn’t exist, create it
    if [ ! -f images_03_BOLD_2p4_MB6_P1_TE30_TR800_AP_hippocampal_brain.nii.gz ]; then
        echo "==> Creating brain mask for $id functional image"
        bet images_03_BOLD_2p4_MB6_P1_TE30_TR800_AP_hippocampal.nii images_03_BOLD_2p4_MB6_P1_TE30_TR800_AP_hippocampal_brain -F -f 0.6 -g 0
    else
        echo "==> Brain mask already exists for $id functional image"
    fi

    # If the field_prepare.nii or field_prepare.nii.gz doesn’t exist, create it
    if [ ! -f field_prepare.nii ] && [ ! -f field_prepare.nii.gz ]; then
        echo "==> Creating field_prepare.nii for $id"
        fsl_prepare_fieldmap SIEMENS images_05_fieldmap_3mm_FoV_216x216x144_e2_ph.nii images_04_fieldmap_3mm_FoV_216x216x144_e2_brain.nii.gz field_prepare.nii 2.46
       
    else
        echo "==> field_prepare.nii already exists for $id"
    fi

    # Copy the design files into the subject directory, and then
    cp path/to/templates/design_FM_bbr_stats-201020.fsf .

    # replace all instances of 003 with the current subject number
    sed -i '' "s/003/$id/g" design_FM_bbr_stats-201020.fsf
    echo "===> Design file updated for $id"

    # Run FEAT analysis
    echo "===> Running FEAT analysis for $id"
    feat design_FM_bbr_stats-201020.fsf

done








