function xyz_rot = rodrigues(xyz, axis, teta)
    K=[0 axis(3) axis(2); -axis(3) 0 -axis(1); -axis(2) axis(1) 0];
    I=[1 0 0; 0 1 0; 0 0 1];
    R=I + (sin(teta))*K + (1-cos(teta))*K*K;
    xyz_rot=R*(xyz)';
    xyz_rot=xyz_rot';
    figure; 
    showPointCloud(xyz_rot);
    zlabel('eixo z');
    ylabel('eixo y');
    xlabel('eixo x');
   
end