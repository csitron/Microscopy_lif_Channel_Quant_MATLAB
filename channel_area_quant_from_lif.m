function [quant_table] = channel_area_quant_from_lif(lif_file,quant_channel_index,norm_channel_index,quant_channel_cutoff,bitdepth)
data = bfopen(lif_file)


normalizing_channel_area_fraction = [];
quantification_channel_area_fraction = [];
channel_ratio = [];
quantification_channel_raw = [];

names = {};
for i = 1:rows(data)
    %read in image
    im = data{i,1};
    
    %get sample names
    split_meta = strsplit(im{1,2},';');
    splname = split_meta{2};
    names{end+1} = splname(1:end);

    
    %quantify area of normalization channel
    im_norm = im{norm_channel_index,1};
    sigma = 1;
    im_norm_filt = imgaussfilt(im_norm, sigma);
    im_norm_bin = imbinarize(im_norm_filt);
    norm_area_frac = sum(im_norm_bin(:))/length(im_norm_bin(:));
    
    %quantify area of channel of interest
    im_quant = im{quant_channel_index,1};
    im_quant_bin = im_quant > quant_channel_cutoff;
    quant_area_frac = sum(im_quant_bin(:))/length(im_quant_bin(:));
    quantification_channel_raw(i,:) = imhist(im_quant,bitdepth);
    
    
    %store data in a table
    normalizing_channel_area_fraction(i,1) = norm_area_frac;
    quantification_channel_area_fraction(i,1) = quant_area_frac;
    channel_ratio(i,1) = norm_area_frac/quant_area_frac;
end

%store results in a table
quant_table = table(string(names'),normalizing_channel_area_fraction, ...
    quantification_channel_area_fraction,channel_ratio);
quant_table.Properties.VariableNames = ["Sample Name","Fractional Area of Normalizing Channel", ...
    "Fractional Area of Quantification Channel", "Quantification Channel : Normalizing Channel Ratio"];

%plot channel of interest intensities to choose a cutoff
imagesc(quantification_channel_raw)
set(gca,'Ytick',1:length(names))
set(gca,'YtickLabel',names)
xlabel('Quantification Channel Intensity')
title('Plot to assist in choosing a quant\_channel\_cutoff')

end