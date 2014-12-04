figure;
X=[0 0 0;1 0 0;0 1 0;0 0 1];
FX=convhulln(X);
trisurf(FX,X(:,1),X(:,2),X(:,3));hold on;
X=[0 0 0;-1 0 0;0 1 0;0 0 1];
FX=convhulln(X);
trisurf(FX,X(:,1),X(:,2),X(:,3));hold on;
X=[0 0 0;1 0 0;0 -1 0;0 0 1];
FX=convhulln(X);
trisurf(FX,X(:,1),X(:,2),X(:,3));hold on;
X=[0 0 0;-1 0 0;0 -1 0;0 0 1];
FX=convhulln(X);
trisurf(FX,X(:,1),X(:,2),X(:,3));hold on;
X=[0 0 0;1 0 0;0 1 0;0 0 -1];
FX=convhulln(X);
trisurf(FX,X(:,1),X(:,2),X(:,3));hold on;
X=[0 0 0;-1 0 0;0 1 0;0 0 -1];
FX=convhulln(X);
trisurf(FX,X(:,1),X(:,2),X(:,3));hold on;
X=[0 0 0;1 0 0;0 -1 0;0 0 -1];
FX=convhulln(X);
trisurf(FX,X(:,1),X(:,2),X(:,3));hold on;
X=[0 0 0;-1 0 0;0 -1 0;0 0 -1];
FX=convhulln(X);
trisurf(FX,X(:,1),X(:,2),X(:,3));hold on;
axis equal;

%绘制球体
figure;
delta=pi/400;
theta=0:delta:2*pi; % theta is zenith angle
phi=0:delta:2*pi; % phi is azimuth angle
[t p]=meshgrid(theta,phi);
r=ones(size(t));
[x,y,z]=sph2cart(t,p,r);%球坐标向柱坐标转化
mesh(x,y,z);%球坐标系中进行绘图
axis equal

%绘制椎体
figure;
t = 1: -0.01 : 0;
[X,Y,Z] = cylinder(t,100);
mesh(X,Y,Z);hold on;
t = 0 : 0.01 : 1.0;
[X,Y,Z] = cylinder(t,100);Z=Z-1;
mesh(X,Y,Z);hold on;
axis equal