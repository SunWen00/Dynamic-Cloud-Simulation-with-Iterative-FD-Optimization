function [B,HH,w1,w2]=SW_cloud_3D_gen(~,~,~,~,~,Hmax,Hmin,resx,resy,~,~,~)
%% 生成云海三维场景
% 输入
%
% hb云底高度km，ht云顶高度km，t时间s,
% 2023.08.16
% sunwen
% SW_cloud_sea_gen(500,500,0.5,1,10,6,20,20,10,45,0.8);

[B]=SW_cloud_gen(nxx,nyy,cover,type);
% [B,w1,w2,cover] = SW_cloud_load();

% [B,nxx,nyy,cover]=SW_cloud_load(satellite,nxx,nyy,cover,type);


[w1,w2]=size(B);
Bmax=max(max(B));
Bmin=min(min(B));
HH=zeros(w1,w2);
for i=1:w1
    for j=1:w2
        if (B(i,j)~=0)
            HH(i,j)=(Hmax-Hmin)*(B(i,j)-Bmin)/(Bmax-Bmin);
        end
    end
end
x=0:w1-1;
y=0:w2-1;
x=x*resx;
y=y*resy;
HH(HH==0)=nan;
figure
surf(y,x,HH,'FaceAlpha',0.8,'EdgeColor','none','FaceColor',[1 1 1],'FaceLighting','flat');
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ztick',[],'zticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'xcolor','none');
set(gca,'ycolor','none');
set(gca,'zcolor','none');
view(180,88);
set(gca,'Color',[135/255 206/255 235/255]);  % 设置figure板颜色
% hold on

%% 海面
figure
[sea_Z,~,~]=SW_PM_sea(nxx,nyy,resx,resy,windspeed,wavedirection,scale);

mesh(x,y,sea_Z);


hold on