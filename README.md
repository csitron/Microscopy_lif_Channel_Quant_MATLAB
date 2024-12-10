Quantification of positive channel area in Matlab

Project description:
This package contains a function that enables analysis of .lif image files from Leica microscopes. This 
function enables quantification of the area of a fluorescence channel of interest, normalized to another 
channel.

How to install the project:
Outside of standard Matlab functions, this code depends on the bfopen function, developed by 
Openmicroscopy, which can be found at https://docs.openmicroscopy.org/bio-
formats/5.8.2/users/matlab/index.html. Ensure that each of these functions is in the Matlab path. This 
code should run on any operating system capable of running Matlab, but has been formally tested on 
Windows 10. No special hardware is required. If Matlab is already installed, installing the package should 
take less than 5 min. The code has been tested on Matlab R2020b.

Running the code:
Analyze the .lif file using the function channel_area_quant_from_lif, which takes the following 
arguments:
lif_file = the .lif file you wish to analyze.
quant_channel_index = the index in the .lif file corresponding to your channel of interest, which you 
would like to quantify.
norm_channel_index = the index in the .lif file corresponding to your normalization channel.
quant_channel_cutoff = the cutoff value above which you define the signal in the quantification channel 
to be “positive.” You can guess at this value initially, but the code will also output a heatmap of your 
data to guide your cutoff value selection.
bitdepth = the bitdepth of your image, i.e. 8-bit images should have a value of 256.
You can anticipate that the code runtime will vary greatly with the size of your .lif file. On my standard 
desktop, the code took roughly 20 sec per GB of .lif file to run.

Running this code will return two things:
1. A table containing: sample names, the fractional area of your normalization channel, the fractional 
positive area of your quantified channel of interest, and the ratio of the positive quantified channel area 
to the  normalization channel area.
2. A plot showing the histograms of the intensities for each image in the .lif. Using this can allow you to 
select a cutoff intensity value where known positive and negative control samples begin to diverge.

An example of this type of analysis can be found in channel_quant_driver.m.

Acknowledgments:
We acknowledge Openmicroscopy for making the bfopen function as part of the bio-formats project. 
This work was supported by the joint efforts of The Michael J. Fox Foundation for Parkinson’s Research 
(MJFF) and the Aligning Science Across Parkinson’s (ASAP) initiative. MJFF administers the grants ASAP-
000282 and ASAP- 024268 on behalf of ASAP and itself.
