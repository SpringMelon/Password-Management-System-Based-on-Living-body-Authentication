function [c] = junzhilvbo(j,k)%jΪͼ��kΪ����߽�ֵ
%guiyihua�е��ã���ֵ�˲�
[m,n] = size(j);
b = zeros(m+2*k, n+2*k);
b(k+1 : m+k, k+1 : n+k) = double(j(:,:));
c = zeros(m, n);
for i = k+1 : m+k
    for j = k+1 : n+k
        b(i, j) = sum(sum(b(i-k : i+k, j-k : j+k)))/((2*k + 1).^2);
    end
end
c(:, :) = b(k+1 : m+k, k+1 : n+k);