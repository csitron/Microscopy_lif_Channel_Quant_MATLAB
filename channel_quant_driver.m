%define inputs
lif_file = 'microscopy_quant_example_data.lif';
quant_channel_index = 2;
norm_channel_index = 4;
quant_channel_cutoff = 23;
bitdepth = 256;

%run code
[quant_table] = channel_area_quant_from_lif(lif_file,quant_channel_index,norm_channel_index,quant_channel_cutoff,bitdepth)