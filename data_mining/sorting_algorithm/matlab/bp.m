close all;
clc;
warning off;
p=[0 1 2 3 4 5 6 7 8];
t=[0 0.84 0.91 0.14 -0.77 -0.96 -0.28 0.66 0.99];
%����һ��ǰ�����磬����Ϊ10�����Ϊ1����Ԫ��ѵ������Ϊtrainlm
net=newff([0 8],[10 1],{'tansig','purelin'},'trainlm');
y1=sim(net,p);
plot(p,t,'o',p,y1,'x');
%����ѵ������
net.trainParam.epochs=50;
net.trainParam.goal=0.01;
%ѵ������
net=train(net,p,t);
%����
y2=sim(net,p);
%%test
test=6.5;
y3=sim(net,test);
plot(p,t,'o',p,y1,'x',p,y2,'*');





