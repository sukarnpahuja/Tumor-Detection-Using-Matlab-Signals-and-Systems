close all;
clear all;
clc;
image=imread('2.jpg');
b_w=im2bw(image,0.7);
label=bwlabel(b_w);
stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.2;
max_area=max(area(high_dense_area));
if(max_area<0.1)
 print('No tumor detected');
end
if (max_area>=0.1)
 tumor_label=find(area==max_area);
 tumor=ismember(label,tumor_label);
 se=strel('square',5);
 tumor=imdilate(tumor,se);
 figure(2);
 subplot(1,3,1);
 imshow(image,[]);
 title('Brain');
 subplot(1,3,2);
 imshow(tumor,[]);
 title('Tumor');
 [B,L]=bwboundaries(tumor,'noholes');
 subplot(1,3,3);
 imshow(image,[]);
 hold on
for i=1:length(B)
 plot(B{i}(:,2),B{i}(:,1), 'y' ,'linewidth',1.45);
 end
title('Detected Tumor');
hold off;
end
