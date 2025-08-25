function [B]=SW_cloud_gen(nxx,nyy,cover,type)
%%    仿真云图像
%     2023.08.16
%     sunwen
%%    输入
%     nxx x像素值
%     nyy y像素个数
%     cover云的覆盖率
%     type 种类

%     [B]=SW_cloud_gen(500,500,0.5,1)

%%  多尺度叠加算法
switch type
    case 1
        H=0.8;R=[20,15];k1=0;k2=5; %
    case 2
        H=0.7;R=[30,30];k1=0;k2=4; 
    case 3
        H=0.8;R=[50,10];k1=0;k2=4; %
    case 4
        H=0.8;R=[3,5];k1=0;k2=10;  % 
end
%%
L=100;
[u,v]=meshgrid(1:1:L,1:1:L);
[xi,yi]=meshgrid(nxx/10+0.1:0.1:2*nxx/10,nyy/10+0.1:0.1:2*nyy/10);
r=2;
A=normrnd(0,1,L,L);
V=0;
for k=k1:k2
    S=interp2(u,v,A,r^k/R(1,1)*xi,r^k/R(1,2)*yi,'cubic');
    S(isnan(S)) = 0;
    V=1/(r^(k*H))*S+V;
end
B=1/2.*(1+erf(V./(sqrt(2))));
[w1,w2]=size(B);
thresh=(w1*w2*(1-cover));
SD=reshape(B,[],1);
SD=sort(SD);
B(B<=SD(round(thresh)))=0;
