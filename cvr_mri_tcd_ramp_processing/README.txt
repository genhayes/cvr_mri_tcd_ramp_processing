G. Hayes 2025

These are the scripts I used for the ramp cerebrovascular reactivity (CVR) in MRI and TCD analysis in:

G. Hayes, S. Sparks, J. Pinto, and D. P. Bulte, "Models of Cerebrovascular Reactivity in BOLD-fMRI and Transcranial Doppler Ultrasound"

The data consisted of 2 MHz pulsed transcranial Doppler ultrasound blood flow velocity, acquired in the middle cerebral artery.
The CO2 data was acquired using using an anaesthetic face mask (Intersurgical, Wokingham, Berkshire, UK) and an infrared gas analyser.
The BOLD-fMRI data was acquired in a 3T Siemens Prisma scanner (GE-EPI sequence, TR/TE = 800/30 ms, MB = 6, 2.4 mm isotropic). A high-resolution MPRAGE structural image was also acquired (1 mm isotropic, TR/TE = 1900 ms/3.97 ms).
These signals were acquired during a protocol of consisted of 3 repetitions of 5 deep breaths, followed by 30 s of regular breathing on synthetic medical air, 40 s breathing a 5% CO2 balanced gas mixture, and 40 s breathing a 10% CO2 balanced gas mixture.

Feel free to download and alter this code to suit your own analysis and reference/acknowledge the publication above if you do so.

Adjust parameters as needed for your data. Notably, pay attention to your file paths, sampling rate, the peak promience for peak identification, and the barometric pressue in your location.

It should be noted that our input TCD powerlabs (PWL) data had the following channels: channel 1 of the pwl data is the CO2, channel 2 is the O2 data, channel 3 is the raw TCD data, channel 4 is the PPG data, and channel 5 is the comment data.
