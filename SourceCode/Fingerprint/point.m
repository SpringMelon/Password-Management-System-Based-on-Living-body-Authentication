%�ҳ�ϸ����ͼ������ж˵�
%��һ����İ˸������������������ȡ����ֵ���������н����ӣ���ϸ��ͼ���������˵
%��Ϊ2ʱΪ�˵� ��Ϊ6ʱΪ�����
function txy=point(thin)
count=1;
txy(count,:)=[0,0,0];
% %ȡ��������������Сֵ
% siz=min(size(thin,1),size(thin,2));
for x=45:size(thin,2)-45 %���߲�ȡ
    for y=45:size(thin,1)-45
        if(thin(y,x))
%             CN=0;
%             for i=1:8
%                 CN=CN+abs(p(thin,y,x,i)-p(thin,y,x,i+1));
                CN = (p(thin,y,x,2)~=p(thin,y,x,1)) +(p(thin,y,x,3)~=p(thin,y,x,2)) + (p(thin,y,x,4)~=p(thin,y,x,3)) +...
                    +(p(thin,y,x,5)~=p(thin,y,x,4)) + (p(thin,y,x,6)~=p(thin,y,x,5)) + (p(thin,y,x,7)~=p(thin,y,x,6)) +...
                    +(p(thin,y,x,8)~=p(thin,y,x,7)) + (p(thin,y,x,1)~=p(thin,y,x,8));
%             end
            if (CN==2)
                txy(count,:)=[x,y,2];
                count=count+1;
            elseif(CN==6)
                txy(count,:)=[x,y,6];
                count=count+1;
            end
        end
    end
end

for i=1:count-1
    x(i)=txy(i,1);
    y(i)=txy(i,2);
end
imshow(double(thin));
% hold on ֪ͨ���潫Ҫ��ͼ
hold on;
plot(x,y,'.');