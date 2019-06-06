function [teta,axis,rot_pnt] = angulo(xyz,normal)
ThrsDist = 0.05;

xyz_hom = horzcat(xyz,(ones(size(xyz,1),1)));

distance = xyz_hom * normal;

plane_idx = find(abs(distance)<ThrsDist);

rot_pnt = mean(xyz(plane_idx,:));

%showPointCloud(xyz(plane_idx,:));

teta = acos([0 0 1]*normal(1:3));
axis = cross(normal(1:3),[0,0,1]);
axis = axis/norm(axis);
end