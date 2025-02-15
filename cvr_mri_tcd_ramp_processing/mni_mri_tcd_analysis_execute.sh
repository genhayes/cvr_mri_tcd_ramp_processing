#!/bin/bash
# G. Hayes 2025
# This script is used to run a batch analysis for the TCD and MRI data for the work presented in:
# G. Hayes, S. Sparks, J. Pinto, and D. P. Bulte, "Models of Cerebrovascular Reactivity in BOLD-fMRI and Transcranial Doppler Ultrasound"
# Updated this script for your purposes, notably:
# - the data file name
# - the output file name
# - alter parameters that may differ for your data
papermill --version

region_name="r6r"

# Example subject 1
# # MR subject number 003, TCD subject number 021
# TCD data
tcd_local='path/to/tcd/data/'
mca_filepath='sub-021/ses-01/sub-021_ses-01_YYYYMMDD_task_task-ramp_MCAvmean.csv'
petco2_filepath='sub-021/ses-01/sub-021_ses-01_YYYYMMDD_task_task-ramp_petco2.csv'
# MRI data
mri_local='path/to/mri/data/'
func_filepath="mr-003_func_final_${region_name}.csv"
mrpetco2_filepath="mr-003_petco2_final_${region_name}.csv"
sub='MR-003'
sub_tcd='SUB-021'
mca_peak_min_distance=110
mca_peak_prominence=50
mca_start_peak_search=110

papermill 3_mni_mri_tcd_analysis.ipynb mni_mri_analysis_003.ipynb -p tcd_local $tcd_local -p mca_filepath $mca_filepath -p petco2_filepath $petco2_filepath -p mri_local $mri_local -p func_filepath $func_filepath -p mrpetco2_filepath $mrpetco2_filepath -p sub $sub -p sub_tcd $sub_tcd -p mca_peak_min_distance $mca_peak_min_distance -p mca_peak_prominence $mca_peak_prominence -p mca_start_peak_search $mca_start_peak_search

#Examples subject 2
# # # MR subject number 004, TCD subject number 022 
# TCD data
tcd_local='path/to/tcd/data/'
mca_filepath='sub-022/ses-01/sub-022_ses-01_YYYYMMDD_task_task-ramp_MCAvmean.csv'
petco2_filepath='sub-022/ses-01/sub-022_ses-01_YYYYMMDD_task_task-ramp_petco2.csv'
# MRI data
mri_local='path/to/mri/data/'
func_filepath="mr-004_func_final_${region_name}.csv"
mrpetco2_filepath="mr-004_petco2_final_${region_name}.csv"
sub='MR-004'
sub_tcd='SUB-022'
mca_peak_min_distance=110
mca_peak_prominence=50
mca_start_peak_search=110

papermill 3_mni_mri_tcd_analysis.ipynb mni_mri_analysis_004.ipynb -p tcd_local $tcd_local -p mca_filepath $mca_filepath -p petco2_filepath $petco2_filepath -p mri_local $mri_local -p func_filepath $func_filepath -p mrpetco2_filepath $mrpetco2_filepath -p sub $sub -p sub_tcd $sub_tcd -p mca_peak_min_distance $mca_peak_min_distance -p mca_peak_prominence $mca_peak_prominence -p mca_start_peak_search $mca_start_peak_search