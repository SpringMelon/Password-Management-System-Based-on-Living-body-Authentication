function [minn, maxx] = bianjie(h1)
%guiyihua�е��ã��ӱ߽�ͼ���У�������ȡ�ڱ߽��ֵ
m = [];
[r, c] = find(bwlabel(h1) == 1);
m(1) = max(r);
m(2) = min(r);
[r, c] = find(bwlabel(h1) == 2);
m(3) = max(r);
m(4) = min(r);
if m(1) < m(3)
    minn = m(1);
    maxx = m(4);
else
    minn = m(3);
    maxx = m(2);
end