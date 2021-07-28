function [Source1, Source2, Source3, Source4]  = load_source(data_type)  
%%%%%%%%%%%%--linear--%%%%%%%%%%%%%%%%
if(data_type == 1)
    A=[1:1:100];
    B=A';

    Source1=B*A;
    Source1 = Source1 ./ 100;
    Source2 =rot90(Source1);
    Source3 =rot90(Source2);
    Source4 =rot90(Source3);

elseif (data_type == 2)
    %%%%%%%%%%%%--log--%%%%%%%%%%%%%%%%
    %LENGTH = 50;
    LENGTH = 100;
    a=1;
    f=1;
    tx = linspace (0, 10, LENGTH)';
    ty = linspace (0, 10, LENGTH)';
    [x,y]=meshgrid(tx , ty);
    r = sqrt (x .^ 2 + y .^ 2) + 2*eps;
    tz = 1./exp(r).*((cos(r.^f)))./(exp(r.^a));
    tzz=tz.^2;
    Source1 =10*((log(tzz))+80 ) / 8;%wynik wyglada jak by byl w dB
    Source2 =rot90(Source1);
    Source3 =rot90(Source2);
    Source4 =rot90(Source3);
elseif(data_type == 3)
    %%%%%%%%%%%%--real--%%%%%%%%%%%%%%%%
    %% podmiana Ÿróde³ 3 i 4 %%
    A = load('source/DlaPawlaS1.mat');
    B = load('source/DlaPawlaS2.mat');
    C = load('source/DlaPawlaS3.mat');
    D = load('source/DlaPawlaS4.mat');
    E = load('source/WektorX_Y_RSSI1_2_3_4PrzejsiceNaWprost.mat');

    Source1 = flipud(A.RSSIdlaPawlaS1+0);
    Source2 = (B.RSSIdlaPawlaS1+0);
    Source4 = (C.RSSIdlaPawlaS1+0);
    Source3 = (D.RSSIdlaPawlaS1+0);
%     TRACK1 = E.WektorStatywprzejscieNaWprost;
%     TRACK1(3,:) = TRACK1(3,:)+120;
%     TRACK1(4,:) = TRACK1(4,:)+120;
%     TRACK1(5,:) = TRACK1(5,:)+120;
%     TRACK1(6,:) = TRACK1(6,:)+120;
	
elseif(data_type == 4)
	gridFile = fopen('source/MultiPoint_Surface_Sensor_0_geom.bin');
	GRID_I = fread(gridFile,'int32');
	grid_size = size(GRID_I,1);
	n_rows = GRID_I(grid_size-1,1)-GRID_I(2,1)+1
	n_columns = GRID_I(grid_size-2,1)-GRID_I(1,1)+1

	[x,y]=meshgrid(GRID_I(1,1):1:(n_columns+GRID_I(1,1)-1) , GRID_I(2,1):1:(n_rows+GRID_I(2,1)-1));

 
	EzrFile = fopen('source/MultiPoint_Surface_Sensor_0_steady_Ezr_total_freq0.bin');
	EZ_R = fread(EzrFile,[n_rows,n_columns], 'single');
	EziFile = fopen('source/MultiPoint_Surface_Sensor_0_steady_Ezi_total_freq0.bin');
	EZ_I = fread(EziFile,[n_rows,n_columns], 'single');

	for r=1:n_rows
		for c=1:n_columns
			Source1(r,c) =20*log10(sqrt(((EZ_R(r,c)/1.057)^2)+((EZ_I(r,c)/1.057)^2)));
			if(Source1(r,c)<-90)
				Source1(r,c)=-90;
			end
		end
	end
	
	Source2 =rot90(Source1);
    Source3 =rot90(Source2);
    Source4 =rot90(Source3);

elseif(data_type == 5)
    %t001_08 Source1  
    %t001_12 Source2  
    %t001_13 Source4  
    %t001_15 Source3  

    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\glasswalls\lodex3pBT.power.t001_08.r007.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\glasswalls\lodex3pBT.power.t001_12.r007.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\glasswalls\lodex3pBT.power.t001_15.r007.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\glasswalls\lodex3pBT.power.t001_13.r007.p2m');
    Source4 =  Z';
elseif(data_type == 6)
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\brickwalls\lodex3pBT.power.t001_08.r007.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\brickwalls\lodex3pBT.power.t001_12.r007.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\brickwalls\lodex3pBT.power.t001_15.r007.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\brickwalls\lodex3pBT.power.t001_13.r007.p2m');
    Source4 =  Z';
elseif(data_type == 7)
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\insite1\lodex3pBT.power.t001_08.r007.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\insite1\lodex3pBT.power.t001_12.r007.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\insite1\lodex3pBT.power.t001_15.r007.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\insite1\lodex3pBT.power.t001_13.r007.p2m');
    Source4 =  Z';
    
elseif(data_type == 8)
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\glass_increased_transmissions\lodex3pBT.power.t001_08.r007.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\glass_increased_transmissions\lodex3pBT.power.t001_13.r007.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\glass_increased_transmissions\lodex3pBT.power.t001_15.r007.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\glass_increased_transmissions\lodex3pBT.power.t001_12.r007.p2m');
    Source4 =  Z';
    
elseif(data_type == 9)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\brick_increased_transmissions\lodex3pBT.power.t001_08.r007.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\brick_increased_transmissions\lodex3pBT.power.t001_13.r007.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\brick_increased_transmissions\lodex3pBT.power.t001_15.r007.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\brick_increased_transmissions\lodex3pBT.power.t001_12.r007.p2m');
    Source4 =  Z';
    
elseif(data_type == 10)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\drywallmore\lodex3pBT.power.t001_08.r007.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\drywallmore\lodex3pBT.power.t001_13.r007.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\drywallmore\lodex3pBT.power.t001_15.r007.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\drywallmore\lodex3pBT.power.t001_12.r007.p2m');
    Source4 =  Z';    
elseif(data_type == 11)
    %file1 = '00_21_27_e6_a2_12_KolejneWiFi.txt';
    file2 = 'data_one_imei_00_19_e0_15_4f_20.txt';
    file3 = 'data_one_imei_00_23_eb_e3_54_b0.txt';
    file4 = 'data_one_imei_00_22_6b_61_3f_1f.txt';
    file5 = 'data_one_imei_00_26_99_71_4b_8f.txt';
    filenames = [file5; file2; file3; file4];
    
    size(filenames);
    data_to_save = [];

    %for j=1 : size(filenames,1)
    for j=size(filenames,1):-1 :1 
    currentFolder = pwd;
    file = tdfread([currentFolder,'\SkryptyLOKKOM\dane\gotowe\',filenames(j,:)],'\t');
    %file = tdfread(['dane/gotowe2/',filenames(j).name],';');
    
    %file = tdfread(['/dane/gotowe/',filenames(j,:)],';');
    %filenames(j).name;
    matrix = struct2cell(file);
    Z = cellfun(@(x)reshape(x,1,[]),matrix,'un',0);
    out = cell2mat(Z);

    % max_rssi = max(out(1,:));
    % min_rssi = min(out(1,:));
    % 
    max_x = max(out(2,:));
    min_x = min(out(2,:));

    max_y = max(out(3,:));
    min_y = min(out(3,:));

    %[x,y]=meshgrid(min_x*100:5:max_x*100 , min_y*100:5:max_y*100);

    %z = zeros(size(x,1),size(x,2));
    %z = ones(17,86)* -100;

    %[x,y]=meshgrid(1:0.25:max_x , 1:0.25:max_y);
    [x,y]=meshgrid(min_x:0.25:max_x , min_y:0.25:max_y);
    %[x,y]=meshgrid(min_x*100:5:max_x*100 , min_y*100:5:max_y*100);

    z = ones(size(x,1),size(x,2)) * -100;

    for i=1:1:size(out(2,:),2)

        rss = out(1,i);
        y1  = (out(2,i) - min_x ) * 4.0 + 1.0;
        x1  = (out(3,i) - min_y ) * 4.0 + 1.0;

        z(x1,y1) = rss;

    end
    
    if (j == 1)
        Source1 = z;
    elseif(j == 2)
        Source2 = z;
    elseif(j == 3)
        Source3 = z;
    elseif(j == 4)
        Source4 = z;
    end

%     %src = repmat(zeros(x,y),x,y);
%     f = figure(j);
%     pcolor(x,y,z);% shading interp;
%     nOfMeasurements = size(z(z(:) < 0),1);
%     colorbar
%     axis([30 88 0 18])
%     %f_name = ['dane/gotowe2_zmienne/variable',filenames(j).name,'.mat'];
%     f_name = ['dane/gotowe2_zmienne/variable',filenames(j,:),'.mat'];
%     save(f_name,'z');
%     %saveas(f,['dane/gotowe2_wykresy/plot',filenames(j).name,'.png']);
%     saveas(f,['dane/gotowe2_wykresy/plot',filenames(j,:),'.png']);
% 
%     %disp([num2str(nOfMeasurements),' measurements_in_filD: ',filenames(j).name]);
%     disp([num2str(nOfMeasurements),' measurements_in_filD: ',filenames(j,:)]);
%     %%%%%%%%%%%%%%%%%%%%%
%     % figure(3);
%     % [m,n] = size(z);
%     % [yy,xx] = ndgrid(0:m-1,0:n-1);
%     % t = ~isnan(z);
%     % F = scatteredInterpolant(xx(t),yy(t),z(t),'natural','linear');
%     % [X,Y] = ndgrid(0:.1:m-1,0:.1:n-1);
%     % mesh(X,Y,F(X,Y));
% 
    end
elseif(data_type == 12)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\high_density\lodex3p.power.t001_01.r005.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\high_density\lodex3p.power.t001_02.r005.p2m');
    Source2 =  fliplr(Z');
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\high_density\lodex3p.power.t001_03.r005.p2m');
    Source3 =  flipud(Z');
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\high_density\lodex3p.power.t001_04.r005.p2m');
    Source4 =  Z';
elseif(data_type == 13)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grid0_25\lodex3pBT.power.t001_08.r005.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grid0_25\lodex3pBT.power.t001_13.r005.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grid0_25\lodex3pBT.power.t001_15.r005.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grid0_25\lodex3pBT.power.t001_12.r005.p2m');
    Source4 =  Z';
elseif(data_type == 14)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grid0_50\lodex3pBT.power.t001_08.r008.p2m');
    Source1 =  fliplr(Z');
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grid0_50\lodex3pBT.power.t001_13.r008.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grid0_50\lodex3pBT.power.t001_15.r008.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grid0_50\lodex3pBT.power.t001_12.r008.p2m');
    Source4 =  Z';
elseif(data_type == 15)
    %29.09.2018 
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\1\lodex3pBT.power.t001_09.r005.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\1\lodex3pBT.power.t001_13.r005.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\1\lodex3pBT.power.t001_15.r005.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\1\lodex3pBT.power.t001_12.r005.p2m');
    Source4 =  Z';    
elseif(data_type == 16)
    %29.09.2018 
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\2\lodex3pBT.power.t001_09.r008.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\2\lodex3pBT.power.t001_13.r008.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\2\lodex3pBT.power.t001_15.r008.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\2\lodex3pBT.power.t001_12.r008.p2m');
    Source4 =  Z';        
elseif(data_type == 17)
    %29.09.2018 
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\3\lodex3pBT.power.t001_09.r010.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\3\lodex3pBT.power.t001_13.r010.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\3\lodex3pBT.power.t001_15.r010.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\3\lodex3pBT.power.t001_12.r010.p2m');
    Source4 =  Z';        
elseif(data_type == 18)
    %wyniki_share_APG5
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\4\lodex3pBT.power.t001_09.r011.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\4\lodex3pBT.power.t001_13.r011.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\4\lodex3pBT.power.t001_15.r011.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Grids\4\lodex3pBT.power.t001_12.r011.p2m');
    Source4 =  Z';        
elseif(data_type == 19)
    %wyniki_share_APG5
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\1\lodex3pBT.power.t001_09.r005.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\1\lodex3pBT.power.t001_13.r005.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\1\lodex3pBT.power.t001_15.r005.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\1\lodex3pBT.power.t001_12.r005.p2m');
    Source4 =  Z';    
elseif(data_type == 20)
    %wyniki_share_APG5
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\2\lodex3pBT.power.t001_09.r008.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\2\lodex3pBT.power.t001_13.r008.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\2\lodex3pBT.power.t001_15.r008.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\2\lodex3pBT.power.t001_12.r008.p2m');
    Source4 =  Z';        
elseif(data_type == 21)
    %wyniki_share_APG5
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\3\lodex3pBT.power.t001_09.r010.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\3\lodex3pBT.power.t001_13.r010.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\3\lodex3pBT.power.t001_15.r010.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\3\lodex3pBT.power.t001_12.r010.p2m');
    Source4 =  Z';        
elseif(data_type == 22)
    %wyniki_share_APG5
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_09.r011.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_13.r011.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_15.r011.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_12.r011.p2m');
    Source4 =  Z';  
elseif(data_type == 23)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_09.r011.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_13.r011.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_15.r011.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_12.r011.p2m');
    Source4 =  Z';  
elseif(data_type == 24)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_09.r011.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_13.r011.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_15.r011.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share_APG5\4\lodex3pBT.power.t001_12.r011.p2m');
    Source4 =  Z';    
%end
elseif(data_type == 25)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\1\lodex3pBT.power.t001_09.r005.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\1\lodex3pBT.power.t001_13.r005.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\1\lodex3pBT.power.t001_15.r005.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\1\lodex3pBT.power.t001_12.r005.p2m');
    Source4 =  Z';         
elseif(data_type == 26)
 	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\2\lodex3pBT.power.t001_09.r008.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\2\lodex3pBT.power.t001_13.r008.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\2\lodex3pBT.power.t001_15.r008.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\2\lodex3pBT.power.t001_12.r008.p2m');
    Source4 =  Z';        
elseif(data_type == 27)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\3\lodex3pBT.power.t001_09.r010.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\3\lodex3pBT.power.t001_13.r010.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\3\lodex3pBT.power.t001_15.r010.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\3\lodex3pBT.power.t001_12.r010.p2m');
    Source4 =  Z';         
elseif(data_type == 28)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\4\lodex3pBT.power.t001_09.r011.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\4\lodex3pBT.power.t001_13.r011.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\4\lodex3pBT.power.t001_15.r011.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\4\lodex3pBT.power.t001_12.r011.p2m');
    Source4 =  Z';          
elseif(data_type == 29)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\5\lodex3pBT.power.t001_09.r020.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\5\lodex3pBT.power.t001_13.r020.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\5\lodex3pBT.power.t001_15.r020.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\5\lodex3pBT.power.t001_12.r020.p2m');
    Source4 =  Z';        
elseif(data_type == 30)
	[X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\6\lodex3pBT.power.t001_09.r021.p2m');
    Source1 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\6\lodex3pBT.power.t001_13.r021.p2m');
    Source2 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\6\lodex3pBT.power.t001_15.r021.p2m');
    Source3 =  Z';
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\wyniki_share\6\lodex3pBT.power.t001_12.r021.p2m');
    Source4 =  Z';    
elseif(data_type == 32)
    %D:\Robert\Robert\Doktorat\InSite\Projekt-artykul\StudyArea
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Insite\MySecondProject.power.t001_01.r006.p2m');
    Source1 =  (Z');
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Insite\MySecondProject.power.t001_02.r006.p2m');
    Source2 =  (Z');
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Insite\MySecondProject.power.t001_03.r006.p2m');
    Source3 =  (Z');
    [X, Y, Z] = getPower('D:\Robert\Projekty\doktorat_kod_matlab\source\Insite\MySecondProject.power.t001_04.r006.p2m');
    Source4 =  (Z');  

elseif(data_type == 31)
    
    T = readtable('D:\Robert\Robert\Doktorat\Artyku³y-uporz¹dkowane\Articles\Articles_10_2020\Datasets\Ipin2016Dataset\x_y_measure1_smartphone_wifi.csv');
    tmpSource1 = [];
    tmpSource2 = [];
    tmpSource3 = [];
    tmpSource4 = [];
    x = table2array(T(:,4));
    y = (table2array(T(:,5)));
    
    src_num = 1;

    group = [7, 8, 16, 22];
    for rss = group
    rssi = table2array(T(:,rss));

    rssi = abs(rssi);

    %imagesc(x,y,rssi);

    xa = (ones(1,365)) * -120;
    ya = (ones(1,365)) * -120;

    arr = meshgrid(xa,ya);

    for i = 1 : 325
        arr(x(i),y(i)) = rssi(i);
        
        for j = 1 : 5
            arr(x(i)+j,y(i)) = (rssi(i) - 1);
            arr(x(i)-j,y(i)) = (rssi(i) - 1);
            
            arr(x(i),y(i)-j) = (rssi(i) - 1);
            arr(x(i),y(i)+j) = (rssi(i) - 1);
            
            arr(x(i)-j,y(i)+j) = (rssi(i) - 1);
            arr(x(i)+j,y(i)+j) = (rssi(i) - 1);
            
            arr(x(i)-j,y(i)-j) = (rssi(i) - 1);
            arr(x(i)+j,y(i)-j) = (rssi(i) - 1);
        end
        
    end
    %f = figure(rss)
    %imagesc(arr)
    
    switch src_num
        case 1
            Source1 = rot90(arr');
        case 2
            Source2 = rot90(arr');
        case 3
            Source3 = rot90(arr');
        case 4
            Source4 = rot90(arr');
    end
    src_num = src_num + 1;
    end
    
    %imagesc(Source1)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SHIFT
    
elseif(data_type == 33)
    %D:\Robert\Robert\Doktorat\InSite\Projekt-artykul\StudyArea
    [X, Y, Z] = getPower('D:\Robert\Robert\Doktorat\InSite\Projekt-artykul\StudyArea\Project5.power.t001_01.r005.p2m');
    Source1 =  rot90(Z,1);%flipud(rot90(rot90(fliplr(Z'))));
    [X, Y, Z] = getPower('D:\Robert\Robert\Doktorat\InSite\Projekt-artykul\StudyArea\Project5.power.t001_02.r005.p2m');
    Source2 =  rot90(Z,1);%flipud(rot90(rot90(fliplr(Z'))));
    [X, Y, Z] = getPower('D:\Robert\Robert\Doktorat\InSite\Projekt-artykul\StudyArea\Project5.power.t001_03.r005.p2m');
    Source3 =  rot90(Z,1);%flipud(rot90(rot90(fliplr(Z'))));
    [X, Y, Z] = getPower('D:\Robert\Robert\Doktorat\InSite\Projekt-artykul\StudyArea\Project5.power.t001_04.r005.p2m');
    Source4 =  rot90(Z,1);%flipud(rot90(rot90(fliplr(Z'))));
    %
    
    %figure(20);imagesc(Source1);
    %figure(21);imagesc(Source2);
    %figure(22);imagesc(Source3);
    %figure(23);imagesc(Source4);

elseif(data_type == 34)
    Source1 =  datFileReader('D:\Robert\Robert\Doktorat\Artyku³y-uporz¹dkowane\Articles\Sensors2020\IPINDATA_WHIPP_Tool\output-coveragedata_6_AP1.dat');
    Source2 =  datFileReader('D:\Robert\Robert\Doktorat\Artyku³y-uporz¹dkowane\Articles\Sensors2020\IPINDATA_WHIPP_Tool\output-coveragedata_6_AP2.dat');
    Source3 =  datFileReader('D:\Robert\Robert\Doktorat\Artyku³y-uporz¹dkowane\Articles\Sensors2020\IPINDATA_WHIPP_Tool\output-coveragedata_6_AP3.dat');
    Source4 =  datFileReader('D:\Robert\Robert\Doktorat\Artyku³y-uporz¹dkowane\Articles\Sensors2020\IPINDATA_WHIPP_Tool\output-coveragedata_6_AP4.dat');

elseif(data_type == 35)
    SRC = readCSV();
    Source1 = SRC(:,:,1);
    Source2 = SRC(:,:,2);
    Source3 = SRC(:,:,3);
    Source4 = SRC(:,:,4);
end
end
%%%%%%%%%%%%%%%%%