%ȥ��ͼ���Ե�Ķ˵�

function txy=cut(thin,txy)
% thin=thin1;
% txy=txy1;
%����һ��8*8�ľ��� 14,18
s(14,18)=0;
delta(14,18)=0;
n=size(txy,1);
for i=1:14
    for j=1:18
        %����һ�����鼯�� m{1��2}=3   m=[] [3]
%          m{2,5}=6
% 
% m = 
% 
%     [1,2,3]    [3]    []    []     []
%     []     []    []    []    [6]

% ÿ��ȡ31*31 �ȴ��ϵ��� �ٴ����� 20*20
%         mp{i,j}=thin(1+31*(i-1):31+31*(i-1),1+31*(j-1):31+31*(j-1));
%         s(i,j)=sum(sum(mp{i,j}))/(31*31);
        mp{i,j}=thin(1+20*(j-1):20+20*(j-1),1+20*(i-1):20+20*(i-1));
%         s(i,j)=sum(sum(mp{i,j}))/(20*20);
%         fprintf("s=%f,sum=%d\n",s(i,j),sum(sum(mp{i,j})));
%         mp{i,j}=(mp{i,j}-s(i,j)).^2
%         delta(i,j)=sum(sum(mp{i,j}));
%         ��Ե ��ɫ�� ��ɫ��
        s(i,j)=sum(sum(mp{i,j}))
        if s(i,j)>=100
%         if(0)
            for k=1:n
                if (txy(k,1)>=1+20*(i-1)&&txy(k,1)<20+20*(i-1)&&txy(k,2)>=1+20*(j-1)&&txy(k,2)<=20+20*(j-1)&&txy(k,3)==2)
                    txy(k,:)=[0,0,0];
                end
            end
        end
    end
end
% find()��ѯ����Ԫ�����ڵ�λ��
txy=txy(find(txy(:,1)),:);
% plot(txy(:,1),txy(:,2),'ro');
