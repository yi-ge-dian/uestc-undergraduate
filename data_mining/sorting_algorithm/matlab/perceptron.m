close all;
clc;
clear all;
% P为输入向量； %T为目标向量
P=[-0.5 -0.5 0.3 0;
    -0.5 0.5 -0.5 1];
T=[1 1 0 0];
plotpv(P,T) % 绘制输入向量

%初始化一个网络
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
    %调整权值矩阵和阈值矩阵
    w=w+dw;
    b=b+db;
    net.iw{1,1}=w;
    net.b{1}=b;
    plotpc(w,b);
    pause; % 观察结果
    y=sim(net,P);
    e=T-y;
end
disp('运行结束!')
