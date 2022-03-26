close all;
clc;
warning off;
p=[0 1 2 3 4 5 6 7 8];
t=[0 0.84 0.91 0.14 -0.77 -0.96 -0.28 0.66 0.99];
%建立一个前向网络，隐层为10，输出为1个单元，训练函数为trainlm
net=newff([0 8],[10 1],{'tansig','purelin'},'trainlm');
y1=sim(net,p);
plot(p,t,'o',p,y1,'x');
%设置训练参数
net.trainParam.epochs=50;
net.trainParam.goal=0.01;
%训练网络
net=train(net,p,t);
%仿真
y2=sim(net,p);
%%test
test=6.5;
y3=sim(net,test);
plot(p,t,'o',p,y1,'x',p,y2,'*');





