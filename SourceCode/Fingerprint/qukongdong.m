function shuchu= qukongdong(shuru, area)
%preprocess���ã���侲���ϵ�ȱ��
k = shuru;
kk = k;
% figure,imshow(k);
[g, num] = bwlabel(k, 4);
for i = 1:2
    for j = 1:num
        [r, c] = find(bwlabel(kk) == j);
        area_temp = bwarea(find(bwlabel(kk) == j));
        if area_temp < area
            k(r, c) = 0;
        end
    end
end
shuchu = k;