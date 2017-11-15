% Inclass11
%GB comments
1) 100
2) 100
3) 100
4) 100
overall: 100

% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0
% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels.
cell = ('011917-wntDose-esi017-RI_f0016.tif');
reader = bfGetReader(cell);
size_X = reader.getSizeX
size_y = reader.getSizeY
slice_z = reader.getSizeZ
time_points = reader.getSizeT
channels = reader.getSizeC
% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.
chan_1 = 1;
time = 30;
iplane_1 = reader.getIndex(slice_z-1,chan_1-1,time-1)+1;
img_1 = bfGetPlane(reader,iplane_1);
figure(1)
imshow(imadjust(img_1));

chan_2 = 2;
iplane_2 = reader.getIndex(slice_z-1,chan_2-1,time-1)+1;
img_2 = bfGetPlane(reader,iplane_2);
figure(2)
imshow(imadjust(img_2));

img2show=cat(3, imadjust(img_1), imadjust(img_2), zeros(size(img_1)));
figure(3)
imshow(img2show)
% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 
img_bw = img_1>1000;
img_br = uint16(img_bw)*1000;
img2show_mask = cat(3,imadjust(img_br),imadjust(img_2),zeros(size(img_1)));
figure(4)
imshow(img2show_mask)
figure(5)
imshow(imadjust(img_br))
% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.
figure(6)
imshow(imerode(img_bw,strel('disk',3)));
%every pixel within distance of 3 pixels of a black pixel is converted to
%black pixel
figure(8)
imshow(imdilate(img_bw,strel('disk',3)));
%every pixel within distance of 3 pixels of a white pixel is converted to a
%white pixel
