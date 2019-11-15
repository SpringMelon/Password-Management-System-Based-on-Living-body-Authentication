function shuchu = guiyihua(shuru)
%preprocess�е��ã���ֵ�˲�����������������ȡ��һ���Կ���Ϊ�߽磬�Ҷȹ�һ������������ָΪ�߽磬�ߴ��һ��
shuru = rgb2gray(shuru);
%figure, imshow(shuru);
shuru = im2double(shuru);

shuru = shuru(80:380, 150:450);

%��ֵ�˲�
%h=fspecial('average');
%shuru1 = filter2(h, shuru)
shuru1 = junzhilvbo(shuru,1);
%figure, imshow(shuru1);

%��Ե��⣬sobel���ӣ�������
[BW2, tv] = edge(shuru1, 'sobel', 'horizontal');
%figure, imshow(BW2);
%���ɱ��������ӣ�Բ���Σ��뾶2
se1 = strel('disk', 3);
%������
%BW2 = imclose(BW2, se);
%Dilate = [0 0 1 0 0;0 1 1 1 0;1 1 1 1 1 ;0 1 1 1 0;0 0 1 0 0];
BW2 = imdilate(BW2, se1);
se2 = strel('disk', 2);
BW2 = imerode(BW2, se2);
%figure, imshow(BW2);
%������
%BW2 = bwmorph(BW2, 'thin', Inf);
%figure, imshow(BW2);

%�����˲�m�ļ�
BW2 = lvboo(BW2, 290, 10, 150);
%figure, imshow(BW2);

%���ñ߽�m�ļ�
[min1 max1] = bianjie(BW2);
k = shuru(min1:max1, :);
%figure, imshow(k);
[m,n] = size(k);

%�Ҷȹ�һ��,˫���Բ�ֵ��
p = max(max(k(:,:))) - min(min(k(:,:)));
y = double(1/double(p));
k(:,:) = double((double(y) * double((k(:,:) - min(min(k(:,:)))))));
%figure, imshow(k);

%���βü�
[min2 max2]=ercicaijian(k, m, n, se1, se2);
k = k(min2:max2, :);
%figure, imshow(k);
[m,n] = size(k);

%�ߴ�Ҷȹ�һ��
%�ߴ��һ�������˲���
s = [double(96/n) 0 0; 0 double(64/m) 0; 0 0 1];
%�����˲���
tform = maketform('affine', double(s));
k = imtransform(k, tform, 'XData', [1 96], 'YData', [1 64], 'FillValue', 0);
[m,n] = size(k);
%figure, imshow(k);

shuchu = k;
%imshow(shuchu);
