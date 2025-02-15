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
ID=(001 002 003)

for id in ${ID[@]}; do 
    # set the path to the data directory 
    preproc_dir=path/to/preproc/$id.feat

    # set the path to the output directory
    output_dir=path/to/preproc/$id.feat

    echo "===> Starting PSC evaluation for $id"
    # set the path to the subject directory
    echo "preproc_dir = $preproc_dir"

    cd $preproc_dir

    # If the filtered_func_norm doesn’t exist, create it
    if [ ! -f filtered_dunc_norm ]; then
        echo "==> Creating filtered_func_norm map for $id"
        fslmaths filtered_func_data.nii.gz -div mean_func.nii.gz filtered_func_norm
    else
        echo "==> filtered_func_norm map already exists for $id"
    fi

    # If the percent signal change doesn’t exist, create it
    if [ ! -f pscbold ]; then
        echo "==> Creating PSC map for $id"
        fslmaths filtered_func_data.nii.gz -sub mean_func.nii.gz -div mean_func.nii.gz -mul 100 pscbold
    else
        echo "==> PSC map already exists for $id"
    fi

    # If the percent signal change masked doesn’t exist, create it
    if [ ! -f pscbold_masked ]; then
        echo "==> Masking the PSC for $id"
        fslmaths pscbold.nii.gz -mas thresh_zstat1.nii.gz pscbold_masked
    else
        echo "==> Masked PSC map already exists for $id"
    fi

    # Done with the PSC calculation
    echo "===> Done the PSC evaluation for $id"

done