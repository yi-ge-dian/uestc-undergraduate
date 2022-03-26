RGBImage=imread('lena.bmp');%����ͼƬ
figure;
imshow(RGBImage);title('ԭͼ');%չʾͼƬѹ��֮ǰ��ͼƬ
Image=double(RGBImage);%image��Ϊdouble�͵������Լ���
%��ȡͼƬ���������������Ա㴦������ͼƬ����8���������
R = Image(:,:,1);
G = Image(:,:,2);
B = Image(:,:,3);
%RGBת��ΪYCbCr��ʽ
yuv(:,:,1) = 0.299.*R + 0.587.*G + 0.114.*B;
yuv(:,:,2) = - 0.1687.*R - 0.3313.*G + 0.5.*B + 128;
yuv(:,:,3) = 0.5.*R - 0.4187.*G - 0.0813.*B + 128;
Processedimage=yuv;
SubImage=Processedimage-128;%��Ϊdct�任����������Ϊ-128��+127���������ݼ�ȥ128
[m,n]=size(SubImage);
Y=SubImage(:,:,1);%��ȡ���Ⱦ���
Cb=SubImage(:,:,2);%��ȡCbɫ�ȣ���������
Cr=SubImage(:,:,3);%��ȡCrɫ�ȣ��죩����
row8times=m/8; a=mod(m,8); 
    Y_last_Z=0;
    Cb_last_Z=0;
    Cr_last_Z=0;
if(a~=0)
    row8times=row8times+1;
    SubImage=combine(SubImage,zeros(row8times*8-m,n/3));
end
column8times=n/24;b=mod(n,8);
if(b~=0)
    column8times=column8times+1;
    SubImage=[column8times zeros(row8times*8,column8times*8-m)];
end  %������������8�ı���������
     %����zigzag����ֵ
 Zigzag=[1,2,9,17,10,3,4,11,18,25,33,26,19,12,5,6,...
       13,20,27,34,41,49,42,35,28,21,14,7,8,15,22,29,...
       36,43,50,57,58,51,44,37,30,23,16,24,31,38,45,52,...
       59,60,53,46,39,32,40,47,54,61,62,55,48,36,63,64];
   %���ط�zigzag����ֵ
 i_ZigZag=[1,2,6,7,15,16,28,29,3,5,8,14,17,27,30,43,...
         4,9,13,18,26,31,42,44,10,12,19,25,32,41,45,54,...
         11,20,24,33,40,46,53,55,21,23,34,39,47,52,56,61,...
         22,35,38,48,51,57,60,62,36,37,49,50,58,59,63,64];
   %��������
for i_r=1:1:column8times
  for i_c=1:1:row8times
     Y_8_8=Y(i_r*8-7:i_r*8,i_c*8-7:i_c*8);%ȡ��һ��8*8�Ŀ�
     Y_dct=dct2(Y_8_8);%ʹ��matlab��dct2��������dct�任
     %����������
     LQyT=[16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 101 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];%��׼����������
     %��ʼ��������
     Y_dct_Qy=round(Y_dct./LQyT);
     %z������
      Y_dct_Qy_z=Y_dct_Qy(Zigzag);
      %��AC��DCϵ�����б���
      DCH_Y=DC_Huffman(Y_dct_Qy_z(1),Y_last_Z,1);
      ACH_Y=AC_Huffman(Y_dct_Qy_z(2:end),1);
      %DC���н���
      DC_decode=huffmandeco_DC(DCH_Y,1);
      i_Y_dct_Qy_z(1)= Y_last_Z+DC_decode;
      Y_last_Z=Y_dct_Qy_z(1);
     %AC���н���
       AC_decode=huffmandeco_AC(ACH_Y,1);
     %DC��AC���ӳ�һ��һ��64�еľ���
       i_Y_dct_Qy_z=[i_Y_dct_Qy_z(1) AC_decode];
      %��Zig_Zagɨ��
      i_Y_dct_Qy=i_Y_dct_Qy_z(i_ZigZag);
      %������Ϊ8*8
      i_Y_dct(1,1:8)=i_Y_dct_Qy(1:8);
      i_Y_dct(2,1:8)=i_Y_dct_Qy(9:16);
      i_Y_dct(3,1:8)=i_Y_dct_Qy(17:24);
      i_Y_dct(4,1:8)=i_Y_dct_Qy(25:32);
      i_Y_dct(5,1:8)=i_Y_dct_Qy(33:40);
      i_Y_dct(6,1:8)=i_Y_dct_Qy(41:48);
      i_Y_dct(7,1:8)=i_Y_dct_Qy(49:56);
      i_Y_dct(8,1:8)=i_Y_dct_Qy(57:64);
      %��������ȡ��
      i_Ydct=i_Y_dct.*LQyT;
      %��DCT�任�������ʼ��ȥ��128���и�ԭ
      I_Y_8_8=idct2(i_Ydct)+128;
      %��һ��8*8��Ż�Y��
     I_Y(i_r*8-7:i_r*8,i_c*8-7:i_c*8)=I_Y_8_8;
   end
end
%����Cb��Crͬ��
 for i_r=1:1:column8times
  for i_c=1:1:row8times
     Cr_8_8=Cr(i_r*8-7:i_r*8,i_c*8-7:i_c*8);%ȡ��һ��8*8�Ŀ�
     Cr_dct=dct2(Cr_8_8);%ʹ��matlab��dct2��������dct�任
     %����������
     LQcT=[17 18 24 47 99 99 99 99;
     18 21 26 66 99 99 99 99;
     24 26 56 99 99 99 99 99;
     47 66 99 99 99 99 99 99;
      99 99 99 99 99 99 99 99;
      99 99 99 99 99 99 99 99;
      99 99 99 99 99 99 99 99;
     99 99 99 99 99 99 99 99];%��׼����������
     %��ʼ��������
     Cr_dct_Qc=round(Cr_dct./LQcT);
     %z������
     Cr_dct_Qc_z=Cr_dct_Qc(Zigzag);
      %��AC��DCϵ�����б���
      DCH_Cr=DC_Huffman(Cr_dct_Qc_z(1),Cr_last_Z,2);
      ACH_Cr=AC_Huffman(Cr_dct_Qc_z(2:end),2);
      %DC���н���
      DC_decode=huffmandeco_DC(DCH_Cr,2);
     i_Cr_dct_Qc_z(1)= Cr_last_Z+DC_decode;
     Cr_last_Z=Cr_dct_Qc_z(1);
     %AC���н���
       AC_decode=huffmandeco_AC(ACH_Cr,2);
     %DC��AC���ӳ�һ��һ��64�еľ���
       i_Cr_dct_Qc_z=[i_Cr_dct_Qc_z(1) AC_decode];
      %��Zig_Zagɨ��
      i_Cr_dct_Qc=i_Cr_dct_Qc_z(i_ZigZag);
      %������Ϊ8*8
      i_Cr_dct(1,1:8)=i_Cr_dct_Qc(1:8);
      i_Cr_dct(2,1:8)=i_Cr_dct_Qc(9:16);
      i_Cr_dct(3,1:8)=i_Cr_dct_Qc(17:24);
      i_Cr_dct(4,1:8)=i_Cr_dct_Qc(25:32);
      i_Cr_dct(5,1:8)=i_Cr_dct_Qc(33:40);
      i_Cr_dct(6,1:8)=i_Cr_dct_Qc(41:48);
      i_Cr_dct(7,1:8)=i_Cr_dct_Qc(49:56);
      i_Cr_dct(8,1:8)=i_Cr_dct_Qc(57:64);
      %��������ȡ��
      i_Crdct=i_Cr_dct.*LQcT;
      %��DCT�任�������ʼ��ȥ��128���и�ԭ
      I_Cr_8_8=idct2(i_Crdct)+128;
      %��һ��8*8��Ż�Y��
     I_Cr(i_r*8-7:i_r*8,i_c*8-7:i_c*8)=I_Cr_8_8;
   end
 end     
for i_r=1:1:column8times
  for i_c=1:1:row8times
     Cb_8_8=Cb(i_r*8-7:i_r*8,i_c*8-7:i_c*8);%ȡ��һ��8*8�Ŀ�
     Cb_dct=dct2(Cb_8_8);%ʹ��matlab��dct2��������dct�任
     %����������
     LQcT=[17 18 24 47 99 99 99 99;
     18 21 26 66 99 99 99 99;
     24 26 56 99 99 99 99 99;
     47 66 99 99 99 99 99 99;
     99 99 99 99 99 99 99 99;
     99 99 99 99 99 99 99 99;
     99 99 99 99 99 99 99 99;
     99 99 99 99 99 99 99 99];%��׼����������
     %��ʼ��������
     Cb_dct_Qc=round(Cb_dct./LQcT);
     %z������
     Cb_dct_Qc_z=Cb_dct_Qc(Zigzag);
      %��AC��DCϵ�����б���
      DCH_Cb=DC_Huffman(Cb_dct_Qc_z(1),Cb_last_Z,2);
      ACH_Cb=AC_Huffman(Cb_dct_Qc_z(2:end),2);
      %DC���н���
      DC_decode=huffmandeco_DC(DCH_Cb,2);
     i_Cb_dct_Qc_z(1)= Cb_last_Z+DC_decode;
     Cb_last_Z=Cb_dct_Qc_z(1);
     %AC���н���
       AC_decode=huffmandeco_AC(ACH_Cb,2);
     %DC��AC���ӳ�һ��һ��64�еľ���
       i_Cb_dct_Qc_z=[i_Cb_dct_Qc_z(1) AC_decode];
      %��Zig_Zagɨ��
      i_Cb_dct_Qc=i_Cb_dct_Qc_z(i_ZigZag);
      %������Ϊ8*8
      i_Cb_dct(1,1:8)=i_Cb_dct_Qc(1:8);
      i_Cb_dct(2,1:8)=i_Cb_dct_Qc(9:16);
      i_Cb_dct(3,1:8)=i_Cb_dct_Qc(17:24);
      i_Cb_dct(4,1:8)=i_Cb_dct_Qc(25:32);
      i_Cb_dct(5,1:8)=i_Cb_dct_Qc(33:40);
      i_Cb_dct(6,1:8)=i_Cb_dct_Qc(41:48);
      i_Cb_dct(7,1:8)=i_Cb_dct_Qc(49:56);
      i_Cb_dct(8,1:8)=i_Cb_dct_Qc(57:64);
      %��������ȡ��
      i_Cbdct=i_Cb_dct.*LQcT;
      %��DCT�任�������ʼ��ȥ��128���и�ԭ
      I_Cb_8_8=idct2(i_Cbdct)+128;
      %��һ��8*8��Ż�Y��
     I_Cb(i_r*8-7:i_r*8,i_c*8-7:i_c*8)=I_Cb_8_8;
   end
end  
%����
NewR = I_Y + 1.402.*(I_Cr-128);
NewG= I_Y - 0.34414.*(I_Cb-128) - 0.71414.*(I_Cr-128);
NewB= I_Y + 1.772.*(I_Cb-128);
rgb(:,:,1) = NewR;
rgb(:,:,2) = NewG;
rgb(:,:,3) = NewB;
figure;
NewImage=uint8(rgb);
imshow(NewImage);
title('��ͼ');%չʾͼƬѹ��֮���ͼƬ
 
 
 
 
 
 
 
 
 
 
 
 

