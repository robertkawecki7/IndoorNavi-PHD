function x = show_sources(x_P, y_P,x_est,y_est,src1, src2, src3, src4, t, y_lvl, w_upweig, Source1, Source2, Source3, Source4,E_uniq, MASK, MASK2,dirpath,last, TFromS1,TFromS2,TFromS3,TFromS4)
x = 1;
    %echo on

[YMAX, XMAX] = size(Source1);
    new1 = Source1;
    new2 = Source2;
    new3 = Source3;
    new4 = Source4;
%{
    for i = 1 : size(src1,1)
        x = src1(i,1);
        y = src1(i,2);
        new1(y,x) = MASK;
    end    
    for i = 1 : size(src2,1)
        x = src2(i,1);
        y = src2(i,2);    
        new2(y,x) = MASK;
    end 
    for i = 1 : size(src3,1)
        x = src3(i,1);
        y = src3(i,2);
        new3(y,x) = MASK;
    end
    
	for i = 1 : size(src4,1)
        x = src4(i,1);
        y = src4(i,2);
        new4(y,x) = MASK;
    end
    
        %global i;
    sizeE = size(E_uniq);
    for i = 1 : sizeE(1)
        x = E_uniq(i,1);
        y = E_uniq(i,2);
        new1(y,x) = MASK2;
        new2(y,x) = MASK2;
        new3(y,x) = MASK2;
        new4(y,x) = MASK2;
    end
    %}
    x_P_white = [];
    y_P_white = [];
    
	x_P_black = [];
    y_P_black = [];
    
    for n=1:length(w_upweig)
        if (w_upweig(n) == 1)
            x_P_white = [x_P_white x_P(n)];
            y_P_white = [y_P_white y_P(n)];
        else
            x_P_black = [x_P_black x_P(n)];
            y_P_black = [y_P_black y_P(n)];
        end
    end
    

    
    [x,y]=meshgrid(1:1:size(Source1,2) , 1:1:size(Source1,1));
    fig = figure(1); pcolor(x,y,new1); shading interp; hold on; plot( x_est,y_est, '.g','MarkerSize',15 ); plot( t, y_lvl, '.m','MarkerSize',15); plot( x_P_black, y_P_black, '.w' ); plot( x_P_white, y_P_white, '.k' );  hold off;
    title(['Source1']);
    colorbar;

    %axis equal
    %axis([1 XMAX 1 XMAX])
    
    [x,y]=meshgrid(1:1:size(Source2,2) , 1:1:size(Source2,1));
    fig2 = figure(2); pcolor(x,y,new2); shading interp; hold on; plot( x_est,y_est, '.g','MarkerSize',15 ); plot( t, y_lvl, '.m','MarkerSize',15); plot( x_P_black, y_P_black, '.w' ); plot( x_P_white, y_P_white, '.k' );  hold off;
    title(['Source2']);
    colorbar;%axis([1 XMAX 1 XMAX])

    %axis equal
    [x,y]=meshgrid(1:1:size(Source3,2) , 1:1:size(Source3,1));
    fig3 = figure(3); pcolor(x,y,new3); shading interp; hold on; plot( x_est,y_est, '.g','MarkerSize',15 ); plot( t, y_lvl, '.m','MarkerSize',15); plot( x_P_black, y_P_black, '.w' ); plot( x_P_white, y_P_white, '.k' );  hold off;
    title(['Source3']);
    colorbar;%axis([1 XMAX 1 XMAX])
 
    %axis equal
	[x,y]=meshgrid(1:1:size(Source4,2) , 1:1:size(Source4,1));
     fig4 = figure(4); pcolor(x,y,new4); shading interp; hold on; plot( x_est,y_est, '.g','MarkerSize',15 ); plot( t, y_lvl, '.m','MarkerSize',15); plot( x_P_black, y_P_black, '.w' ); plot( x_P_white, y_P_white, '.k' );  hold off;
    title(['Source4']);
     colorbar;%axis([1 XMAX 1 XMAX])

    %%%%%%%%% END OF SCRIPT. Sufficient for now. %%%%%%%%%%
    return
    
        [x,y]=meshgrid(1:1:size(TFromS3,2) , 1:1:size(TFromS3,1));
    fig = figure(100); 

    size(TFromS3)
    pcolor(y,x,TFromS3); 
    shading interp; hold on; 
    plot( x_est,y_est, '.g','MarkerSize',15 ); 
    plot( t, y_lvl, '.m','MarkerSize',15); 
    plot( x_P_black, y_P_black, '.w' ); 
    plot( x_P_white, y_P_white, '.k' );  
    hold off;
    colorbar;
    
        [x,y]=meshgrid(1:1:size(TFromS4,2) , 1:1:size(TFromS4,1));
    fig = figure(200); pcolor(x,y,TFromS4); shading interp; hold on; plot( x_est,y_est, '.g','MarkerSize',15 ); plot( t, y_lvl, '.m','MarkerSize',15); plot( x_P_black, y_P_black, '.w' ); plot( x_P_white, y_P_white, '.k' );  hold off;
    colorbar;
    
        [x,y]=meshgrid(1:1:size(TFromS1,2) , 1:1:size(TFromS1,1));
    fig = figure(300); pcolor(x,y,TFromS1); shading interp; hold on; plot( x_est,y_est, '.g','MarkerSize',15 ); plot( t, y_lvl, '.m','MarkerSize',15); plot( x_P_black, y_P_black, '.w' ); plot( x_P_white, y_P_white, '.k' );  hold off;
    colorbar;
    
        [x,y]=meshgrid(1:1:size(TFromS2,2) , 1:1:size(TFromS2,1));
    fig = figure(400); pcolor(x,y,TFromS2); shading interp; hold on; plot( x_est,y_est, '.g','MarkerSize',15 ); plot( t, y_lvl, '.m','MarkerSize',15); plot( x_P_black, y_P_black, '.w' ); plot( x_P_white, y_P_white, '.k' );  hold off;
    colorbar;
    %{
    if (last ==1)
        saveas(fig,strcat(dirpath ,'src1.png'));
        saveas(fig2,strcat(dirpath ,'src2.png'));
        saveas(fig3,strcat(dirpath ,'src3.png'));
        saveas(fig4,strcat(dirpath ,'src4.png'));
    end
    %}
    %axis equal