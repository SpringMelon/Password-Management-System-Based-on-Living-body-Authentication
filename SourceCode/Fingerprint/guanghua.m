function [w,pxy]=guanghua(thin,txy)
%���߹⻬����.ԭ���ҵ�ÿ���˵㣬ʹ���������ߵķ����ƶ�6�����أ������5������֮����������㣬����Ϊ�˶˵�Ϊë�̣���ȥ���˵�
for j=1:5
    txy=point(thin);
    %txy������Ϊ2�ı�Ϊ1 �����Ϊ0
    pxy=txy(find(txy(:,3)==2),:);
    %��ȡ����
    n=size(pxy,1);
    for i=1:n
        error=walk(thin,pxy(i,1),pxy(i,2),6);
        if error==1
            thin(pxy(i,2),pxy(i,1))=0;
%             fprintf('%d %d\n',pxy(i,1),pxy(i,2));%pxy(,1) --x,2--y
        end
    end
end
w=thin;
imshow(w);