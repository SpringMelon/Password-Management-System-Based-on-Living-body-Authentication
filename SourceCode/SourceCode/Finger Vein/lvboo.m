function hh = lvboo(h1, a, b, d)
%��һ���е��ã���ȡ�߽�ʱ���˵�������Ҫ��ı߽�
for j = 1:30
    [g, num]=bwlabel(h1, 8);
    for i = 1:num
        [r, c] = find(bwlabel(h1) == i);
        if max(r) > a | min(r) < b | (max(c) - min(c)) < d  %
            h1(r,c) = 0;
            %(max(c) - min(c))
        end
    end
    %num
    if num == 2
        break;
    end
end


hh = h1;