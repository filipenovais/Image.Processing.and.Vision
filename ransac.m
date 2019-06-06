function [normal,xyz] = ransac(img,K)
good_indx = find(img);
xyz = get_xyz_asus(img(:),size(img),good_indx,K,1,0);

%InlierNum = 0; Número de inliers para o vector normal encontrado
ThrsDist = 0.05;
InlierRatio = 0.01;
BestInNum = 0;

set_size = 20000;
subset = randi([1 307200],set_size,1);

iter = 2000;
for i = 1:iter
    pnt = randperm(set_size,3);
    vec1 = xyz(subset(pnt(2)),:)-xyz(subset(pnt(1)),:);
    vec2 = xyz(subset(pnt(3)),:)-xyz(subset(pnt(1)),:);
    vec3 = cross(vec1,vec2);
    vec3 = vec3/norm(vec3);
    distance = vec3*(xyz(subset(:),:) - repmat(xyz(subset(pnt(1)),:),set_size,1))';
    InlierIdx = find(abs(distance)<ThrsDist);
    InlierNum = length(InlierIdx);
    if InlierNum>=round(InlierRatio*set_size) && InlierNum>BestInNum
        BestInNum = InlierNum;
        BestIdx = InlierIdx;
    end
end

xyz_Idx = subset(BestIdx);

temp = xyz(xyz_Idx,:);
temp = horzcat(temp,ones(size(temp,1),1));

[A,~] = eig(temp'*temp);

normal = A(:,1)/sqrt(A(1,1)^2 + A(2,1)^2 + A(3,1)^2);

%O programa consegue encontrar sempre um vector muito parecido ao melhor do
%Ransac
%Falta selecionar este vector ver o angulo em relação á vertical, fazer o
%produto externo com a vertical e aplicar a fórmula de rodriguez.

figure; showPointCloud(xyz(xyz_Idx,:));
end




