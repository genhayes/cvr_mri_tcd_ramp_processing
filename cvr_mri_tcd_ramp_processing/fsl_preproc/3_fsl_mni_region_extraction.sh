#!/bin/bash
# G. Hayes 2025
# G. Hayes, S. Sparks, J. Pinto, and D. P. Bulte, "Models of Cerebrovascular Reactivity in BOLD-fMRI and Transcranial Doppler Ultrasound"

# This script is used to preprocess the mri data and MNI:
# It will perform the following steps:
# 1. Apply transformation to all MNI regions to subject space, binarize the resulting image above 0.5
# 2. Apply the MNI region masks to pscbold_masked.nii.gz
# ----- save each region as r1_pscbold_gm.nii.gz

# Updated this script for your purposes, notably:
# - the data folder/file names (SEARCH AND REPLACE AND INSTANCES OF "path/to/")
# - the output file name
# - alter parameters that may differ for your data

# use list of subjects to analyze
ID=(001 002 003)

# list of mni brain regions to analyze
REGION=(6)

# set the path to the data directory 
data_dir='path/to/data'

# set the path to the output directory
output_dir='path/to/output'

for id in ${ID[@]}; do 
    echo "===> Starting processing of $id"
    mkdir -p $output_dir/${id}

    for region in ${REGION[@]}; do 
        
        # set the path to the subject directory
        subj_dir=$data_dir/$id.feat
        echo "subj_dir = $subj_dir"

        # # all MNI regions without hemisphere distinction
        # # If the transformed region doesn't exist, create it using /reg/standard2example_func.mat
        # if [ ! -f $output_dir/${id}/mr-${id}_r${region}_mni_thr50-2mm_gm_bin.nii ] && [ ! -f $output_dir/${id}/mr-${id}_r${region}_mni_thr50-2mm_gm_bin.nii.gz ]; then
        #     echo "==> Creating region $region mask for $id"
        #     path/to/Applications/fsl/bin/flirt -in path/to/MNI/thr50-2mm/R${region}_MNI-maxprob-thr50-2mm_bin.nii.gz -applyxfm -init path/to/preproc/${id}.feat/reg/standard2example_func.mat -out path/to/output/folder/${id}/mr-${id}_r${region}_mni_thr50-2mm_gm.nii.gz -paddingsize 0.0 -interp trilinear -ref path/to/ramp_protocol/preproc/${id}.feat/pscbold_masked.nii.gz
        #     fslmaths $output_dir/${id}/mr-${id}_r${region}_mni_thr50-2mm_gm.nii.gz -thr 0.5 -bin $output_dir/${id}/mr-${id}_r${region}_mni_thr50-2mm_gm_bin.nii.gz
        # else
        #     echo "==> region ${id} mask already exists for $id"
        # fi   
        
        # right hemisphere MNI parietal lobe
        # If the transformed region doesn't exist, create it using /reg/standard2example_func.mat
        if [ ! -f $output_dir/${id}/mr-${id}_r${region}_mni_right-2mm_gm.nii ] && [ ! -f $output_dir/${id}/mr-${id}_r${region}_mni_right-2mm_gm.nii.gz ]; then
            echo "==> Creating region $region mask for $id"
            path/to/Applications/fsl/bin/flirt -in path/to/MNI/right-2mm/R${region}_MNI_2mm_right_bin.nii.gz -applyxfm -init path/to/preproc/${id}.feat/reg/standard2example_func.mat -out path/to/output/folder/${id}/mr-${id}_r${region}_mni_right-2mm_gm.nii.gz -paddingsize 0.0 -interp trilinear -ref path/to/ramp_protocol/preproc/${id}.feat/pscbold_masked.nii.gz
            fslmaths $output_dir/${id}/mr-${id}_r${region}_mni_right-2mm_gm.nii.gz -thr 0.5 -bin $output_dir/${id}/mr-${id}_r${region}_mni_right-2mm_gm_bin.nii.gz
        else
            echo "==> region ${id} mask already exists for $id"
        fi             

        # # Apply a mask
        #     # If the percent signal change masked doesn’t exist, create it
        # if [ ! -f pscbold_masked_${region}.nii.gz ] && [ ! -f pscbold_masked_${region}.nii ]; then
        #     echo "==> Region $region masking the PSC for $id"
        #     fslmaths path/to/preproc/${id}.feat/pscbold_masked.nii.gz -mas $output_dir/${id}/mr-${id}_r${region}_mni_thr50-2mm_gm_bin.nii.gz $output_dir/${id}/pscbold_masked_${region}.nii.gz
        # else
        #     echo "==> Masked region $region for PSC map already exists for $id"
        # fi

    done

done