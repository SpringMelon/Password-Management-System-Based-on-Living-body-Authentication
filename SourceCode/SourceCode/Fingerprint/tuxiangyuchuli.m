 %clc,clear,close all;
 function [w,Icc_out]=tuxiangyuchuli(image)
f=imread(image);
% f=imresize(f,[363,312]);%311,362 original
f=imresize(f,[360,280]); %280,360
% f=imresize(f,[257,257]); %256,256
figure;imshow(f);
title('original');
% gray=double(rgb2gray(f));
gray=double(mat2gray(f));
figure;imshow(gray);
title('original gray');
[m,n]=size(gray);
%��һ�����Ҷ�ֵ������ĳһ��Χ
M=0;var=0;
%��ֵ
for x=1:m
    for y=1:n
        M=M+gray(x,y);
    end
end
M1=M/(m*n);
%����
for x=1:m
    for y=1:n
        var=var+(gray(x,y)-M1).^2;
    end
end
var1=var/(m*n);
% print var1;
for x=1:m
    for y=1:n
        if gray(x,y)>M1
            gray(x,y)=150+sqrt(2000*(gray(x,y)-M1)/var1);
        else 
            gray(x,y)=150-sqrt(2000*(M1-gray(x,y))/var1);
        end
    end
end
figure;imshow(uint8(gray));
title('gray ��һ��');

%�ָ� �ֳɶ��3*3�Ŀ��С
M=3;
H=floor(m/M);L=floor(n/M);
aveg1=zeros(H,L);
var1=zeros(H,L);
%����ÿһ���ƽ��ֵ
for x=1:H
    for y=1:L
        aveg=0;var=0;
        %ÿһ��ľ�ֵ
        for i=1:M
            for j=1:M
                aveg=gray(i+(x-1)*M,j+(y-1)*M)+aveg;
            end
        end
          aveg1(x,y)=aveg/(M*M);
          %ÿһ��ķ���ֵ
          for i=1:M
            for j=1:M
                var=(gray(i+(x-1)*M,j+(y-1)*M)-aveg1(x,y)).^2+var;
            end
          end
          var1(x,y)=var/(M*M);
    end
end
%���п��ƽ��ֵ�ͷ���
Gmean=0;Vmean=0;
for x=1:H
    for y=1:L
        Gmean=Gmean+aveg1(x,y);
        Vmean=Vmean+var1(x,y);
    end
end
Gmean1=Gmean/(H*L);
Vmean1=Vmean/(H*L);

%ÿһС���������ȣ��ٴ����ֵ����
% ǰ������ɫ��
gtemp=0;gtotal=0;vtotal=0;vtemp=0;
for x=1:H
    for y=1:L
        if Gmean1>aveg1(x,y)
            
            gtemp=gtemp+1;
            gtotal=gtotal+aveg1(x,y);
        end
        if Vmean1<var1(x,y)
            vtemp=vtemp+1;
            vtotal=vtotal+var1(x,y);
        end
    end
end
% ǰ����ֵ
G1=gtotal/gtemp;
% ǰ������
V1=vtotal/vtemp;

%�ٴ���ող�����ֵ���
% ��ñ�������ɫ����ֵ���� ���ӿɿ���
gtemp1=0;gtotal1=0;vtotal1=0;vtemp1=0;
for x=1:H
    for y=1:L
        if G1<aveg1(x,y)
            gtemp1=gtemp1+1;
            gtotal1=gtotal1+aveg1(x,y);
        end
        if 0<var1(x,y)<V1
            vtemp1=vtemp1+1;
            vtotal1=vtotal1+var1(x,y);
        end
    end
end
% ������ֵ

G2=gtotal1/gtemp1;
% ��������
V2=vtotal1/vtemp1;

%��������H*L��
e=zeros(H,L);
for x=1:H
    for y=1:L
        if aveg1(x,y)>G2 && var1(x,y)<V2
%             ����
            e(x,y)=1;
        end
%         ǰ���еĸ��ӽ���ɫ�ı�Ϊ��ɫ
        if aveg1(x,y)<(G1-100) && var1(x,y)<V2
           e(x,y)=1;
        end
    end
end
%  disp(aveg1(1,1)<G1-100);
%  disp(G1);
%  disp(G2);



%�õ������С����Ϊ0
for x=2:H-1
    for y=2:L-1
        if e(x,y)==1
            if e(x-1,y) + e(x,y+1)+e(x+1,y+1)+e(x-1,y+1)+e(x+1,y)+e(x+1,y-1)+e(x,y-1)+e(x-1,y-1) <=4
                e(x,y)=0;
            end
        end
    end
end

%����m*n���� 
Icc=ones(m,n);
for x=1:H
    for y=1:L
        if e(x,y)==1
            for i=1:M
                for j=1:M
                    gray(i+(x-1)*M,j+(y-1)*M)=G1;
                    Icc(i+(x-1)*M,j+(y-1)*M)=0;
                end
            end
        end
    end
end
figure,imshow(uint8(gray));
title('gray ��һ��');
figure,imshow(Icc);
title('icc original');
Icc_out=Icc;
Icc_out=qukongdong(Icc_out,1000);
Icc_out=medfilt2(Icc_out);
figure,imshow(Icc_out);
title('icc out');
%��ָ�Ƽ��߷��򲢶�ֵ��

temp=(1/9)*[1,1,1;1,1,1;1,1,1];%ģ��ϵ��  ��ֵ�˲�
Im=gray;
In=zeros(m,n);
for a=2:m-1
    for b=2:n-1
       In(a,b)=Im(a-1,b-1)*temp(1,1)+Im(a-1,b)*temp(1,2)+Im(a-1,b+1)*temp(1,3)+Im(a,b-1)*temp(2,1)...
           +Im(a,b)*temp(2,2)+Im(a,b+1)*temp(2,3)+Im(a+1,b-1)*temp(3,1)+Im(a+1,b)*temp(3,2)+Im(a+1,b+1)*temp(3,3);
    end
end
gray=In;
Im=zeros(m,n);
% figure,imshow(uint8(gray));
% title('gray In');
%��˸�����ÿ������ĺ�
for x=5:m-5
    for y=5:n-5
        %0-7����ĺ�
        sum1=gray(x,y-4)+gray(x,y-2)+gray(x,y+2)+gray(x,y+4);
        sum2=gray(x-2,y+4)+gray(x-1,y+2)+gray(x+1,y-2)+gray(x+2,y-4);
        sum3=gray(x-2,y+2)+gray(x-4,y+4)+gray(x+2,y-2)+gray(x+4,y-4);
        sum4=gray(x-2,y+1)+gray(x-4,y+2)+gray(x+2,y-1)+gray(x+4,y-2);
        sum5=gray(x-2,y)+gray(x-4,y)+gray(x+2,y)+gray(x+4,y);
        sum6=gray(x-4,y-2)+gray(x-2,y-1)+gray(x+2,y+1)+gray(x+4,y+2);
        sum7=gray(x-4,y-4)+gray(x-2,y-2)+gray(x+2,y+2)+gray(x+4,y+4);
        sum8=gray(x-2,y-4)+gray(x-1,y-2)+gray(x+1,y+2)+gray(x+2,y+4);
        sumi=[sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8];
        %���ֵ
        summax=max(sumi);
        %��Сֵ
        summin=min(sumi);
        %�� &&ƽ��ֵ
        summ=sum(sumi);
        b=summ/8;
        
        if(summax+summin+4*gray(x,y))> (3*b)
            sumf=summin;
        else
            sumf=summax;
        end
        
        if sumf>b
            Im(x,y)=128;
        else
            Im(x,y)=255;
        end
    end
end
imshow(Im),title('Im');


%���������� 
for i=1:m
    for j=1:n
        Icc(i,j)=Icc(i,j)*Im(i,j);
    end
end

%ת��Ϊ��ֵͼ
for i=1:m
    for j=1:n
        if (Icc(i,j)==128)
            Icc(i,j)=0;
        else
            Icc(i,j)=1;
        end
    end
end
figure;imshow(double(Icc));
title('Icc');

%ȥ���ն���ë��
u=Icc;
% for index=1:5
% for x=2:m-1
%     for y=2:n-1
%         if u(x,y)==0
%             %�úڵ��4����㣨�������ң� ������������϶��ǰ׵㣨1����õ�Ϊë��
%             if u(x,y-1)+u(x-1,y)+u(x,y+1)+u(x+1,y)>=3
%                 u(x,y)=1;
%             end
%         else
%             u(x,y)=u(x,y);
%         end
%     end
% end
% % end
% figure;imshow(u);
% title('ȥ��ë��');
% %ȥ���ն�
% for index=1:10
% for a=2:m-1
%     for b=2:n-1
%         if u(a,b)==1
%             %Ѱ�Ҷ˵�
%             if abs(u(a,b+1)-u(a-1,b+1))+abs(u(a-1,b+1)-u(a-1,b))+abs(u(a-1,b)-u(a-1,b-1))...
%                     +abs(u(a-1,b-1)-u(a,b-1))+(abs(u(a,b-1)-u(a+1,b-1)))+abs(u(a+1,b-1)-u(a+1,b))...
%                     +abs(u(a+1,b)-u(a+1,b+1))+abs(u(a+1,b+1)-u(a,b+1))~=1
%                 if (u(a,b+1)+u(a-1,b+1)+u(a-1,b))*(u(a,b-1)+u(a+1,b-1)+u(a+1,b))+(u(a-1,b)+u(a-1,b-1)+u(a,b-1))...
%                         *(u(a+1,b)+u(a+1,b+1)+u(a,b+1))==0
%                     %ȥ���ն�
%                     u(a,b)=0;
%                 end
%             end
%         end
%     end
% end
% end

u=medfilt2(u);
figure;imshow(u);
title('��ά��ֵ�˲�'); %Ĭ��3*3����

u=qukongdong(u,10);
figure;imshow(u);
title('ȥ���ն�');
%ͼ��ϸ��
v=~u;
v=qukongdong(v,30);
figure;imshow(~v);
title('ȥ������');
% figure;imshow(v);
% se=strel('square',3);
% %��ͼ����п��ղ���
% fo=imopen(v,se);
% figure;imshow(fo);
% % % �ȸ�ʴ�����ͣ������ǣ�����ʹ�߽�ƽ��������ϸС�ļ�̣��Ͽ�խС������,���������С����
% title('������')
% v=imclose(fo,se);
% figure;imshow(v);
% title('������');
w=bwmorph(v,'thin',Inf);%��ͼ�����ϸ��
figure;imshow(~w),title('ϸ��ͼ');



% imshow(Icc)
