
direc=dir('*.mat');
med=zeros(480,640,150); 
for i=1:150,
    
    load(direc(i).name);
    im=depth_array;
    %imagesc(im);
    med(:,:,i)=im;
    %pause(0.1);
end
medim=median(med,3);
imagesc(medim);
fgh=get_xyz_asus(medim(:), [480 640], find(medim(:)~=0), Depth_cam.K, 1, 0);
showPointCloud(fgh);
load images00000125
load CalibrationData
rgb=rgb_array;
d=depth_array;
xyz=get_xyz_asus(d(:), [480 640], find(d(:)~=0), Depth_cam.K, 1, 0);

%mov=cell(1,150);

%for i=1:150,
    asdf=abs(xyz-fgh)>500;  %tudo o que estiver a mais de 0.5m do background e movimento
 %   imshow(mov{i})
%    pause(0.1)
%end

showPointCloud(asdf);


