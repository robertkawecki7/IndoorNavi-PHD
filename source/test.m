clear;
%{
A=[0:1:100];
B=A';

Source1=B*A;
%surf(Source1);
%hold on;

Source2 =rot90(Source1);
%surf(Source2);
%hold on;

Source3 =rot90(Source2);
%surf(Source3);
%hold on;

Source4 =rot90(Source3);
%surf(Source4);
%hold on;


%Plot electric field for all sources
[x,y]=meshgrid(1:1:101 , 1:1:101);
figure(2)
pcolor(x,y, Source1); shading interp;
figure(3)
 pcolor(x,y, Source2); shading interp;
figure(4)
 pcolor(x,y, Source3); shading interp;
figure(5)
 pcolor(x,y, Source4); shading interp;
 hold on;
%}
disp('Contents of particle_e_x.mat:')
whos('-file','particle_e_x.mat')
X = load('particle_e_x.mat');
Y = load('particle_e_y.mat');
E_X = X.e_x;
E_Y = Y.e_y;
figure(2)
plot(E_X);
figure(3)
plot(E_Y);