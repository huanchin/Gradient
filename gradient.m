rgb1 = imread('1-30-(2).jpg');
rgb2 = imread('1-30.jpg');

img1 = imresize(rgb1,0.09);
img2 = imresize(rgb2,0.09);

Width = size(img1,2);
Height = size(img1,1);

im1 = rgb2gray(img1);
im2 = rgb2gray(img2);

[Gx1, Gy1] = imgradientxy(im1,'prewitt');
[Gx2, Gy2] = imgradientxy(im2,'prewitt');
[Gmag1, Gdir1] = imgradient(Gx1, Gy1);
[Gmag2, Gdir2] = imgradient(Gx2, Gy2);

un_Visibiliy = abs(Gmag2-Gmag1);
angle1 = atan2(Gy1,Gx1);
angle2 = atan2(Gy2,Gx2);
un_Consistancy = abs(angle2 - angle1);

vis_thres = (max(max(Gmag1))- min(min(Gmag1)))/2;
vis_out = find(un_Visibiliy > vis_thres);
consis_out = find(un_Consistancy > 3.14);
out_pos = union(vis_out , consis_out);

img2 = reshape(img2,[124416,3]);
for i = 1:size(out_pos)
    img2(out_pos(i),:) = [255,0,0];
end
img2 = reshape(img2,[Height,Width,3]);

figure;
imshow(img2);

return;