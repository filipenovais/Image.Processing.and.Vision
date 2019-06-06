load depth_10
load CalibrationData
rgb=imread('rgb_image_10.png');
d=depth_array;
xyz=get_xyz_asus(d(:), [480 640], find(d(:)~=0), Depth_cam.K, 1, 0);
rgbd=get_rgbd(xyz, rgb, R_d_to_rgb, T_d_to_rgb, RGB_cam.K);

figure(1)
imshow(rgbd)
figure(2)
imshow(rgb)

rgbdv=reshape(rgbd, 480*640, 3);
%rgbdv=rgbdv(find(d(:)>0), :);

figure(3)
showPointCloud(rgbdv)

ind=find(d(:)>0);

p=pointCloud(xyz(ind, :), 'Color', rgbdv(ind, :));

figure(4)
showPointCloud(p)

