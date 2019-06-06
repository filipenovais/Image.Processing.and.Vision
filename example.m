load images00000001
load CalibrationData
rgb=rgb_array;
d=depth_array;
xyz=get_xyz_asus(d(:), [480 640], find(d(:)~=0), Depth_cam.K, 1, 0);
rgbd=get_rgbd(xyz, rgb, R_d_to_rgb, T_d_to_rgb, RGB_cam.K);

figure;
imshow(rgbd)

rgbdv=reshape(rgbd, 480*640, 3);
%rgbdv=rgbdv(find(d(:)>0), :);


ind=find(d(:)>0);

p=pointCloud(xyz(ind, :), 'Color', rgbdv(ind, :));

figure;
showPointCloud(p)
%end pcloud

[normal,xyz] = ransac(d, Depth_cam.K);
figure; showPointCloud(xyz); 

[teta,axis,rot_pnt] = angulo(xyz,normal);

xyz_rot = rodrigues(xyz, axis, teta);

ind=find(d(:)>0);
final=pointCloud(xyz_rot(ind, :), 'Color', rgbdv(ind, :));
figure; showPointCloud(final);