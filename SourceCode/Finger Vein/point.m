%�ҳ�ϸ����ͼ������ж˵�
%��һ����İ˸������������������ȡ����ֵ���������н����ӣ���ϸ��ͼ���������˵
%��Ϊ2ʱΪ�˵� ��Ϊ6ʱΪ�����
function txy=point(thin)
count=1;
txy(count,:)=[0,0,0];
%ȡ��������������Сֵ
%siz=min(size(thin,1),size(thin,2));
[m,n] = size(thin);
thin_pad = zeros(m+2,n+2);
thin_pad(2:m+1,2:n+1) = thin(:,:);
% for x=40:siz-40
%     for y=40:siz-40
for x=1:m
    for y=1:n
        if(thin_pad(x,y)) % x,y����˳��
            CN=0;
            for i=1:8
                CN=CN+abs(p(thin_pad,x,y,i)-p(thin_pad,x,y,i+1));
            end
            if (CN == 2)
                txy(count,:)=[x,y,2];
                count=count+1;
            end
            if(CN >= 6)
                txy(count,:)=[x,y,6];
                count=count+1;
            end
        end
    end
end
j = 1;
k = 1;
for i=1:count-1
    if (txy(i,3) == 2)
        duan_y(j)=txy(i,1);
        duan_x(j)=txy(i,2);
        j=j+1;
    end
    if (txy(i,3) >= 6)
        fencha_y(k)=txy(i,1);
        fencha_x(k)=txy(i,2);
        k=k+1;
    end
end
imshow(double(thin_pad));
% hold on ֪ͨ���潫Ҫ��ͼ
hold on;
plot(fencha_x,fencha_y,'go');
plot(duan_x,duan_y,'ro');
