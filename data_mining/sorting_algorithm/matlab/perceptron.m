close all;
clc;
clear all;
% PΪ���������� %TΪĿ������
P=[-0.5 -0.5 0.3 0;
    -0.5 0.5 -0.5 1];
T=[1 1 0 0];
plotpv(P,T) % ������������

%��ʼ��һ������
net=newp([-1 1; 0 1], 1);
net=init(net);
y=sim(net,P);
e=T-y;
w=net.iw{1,1};
b=net.b{1};
%plot(w,b);
while (mae(e)>0.0015)
    dw=learnp(w,P,[],[],[],[],e,[],[],[],[],[]);
    db=learnp(b,ones(1,4),[],[],[],[],e,[],[],[],[],[]);
    %����Ȩֵ�������ֵ����
    w=w+dw;
    b=b+db;
    net.iw{1,1}=w;
    net.b{1}=b;
    plotpc(w,b);
    pause; % �۲���
    y=sim(net,P);
    e=T-y;
end
disp('���н���!')
