 %{
 clear;
 clc;
 close all;
 
 if ~exist('n_of_simulations')
     % third parameter does not exist, so default it to something
     hold off;
     clear;
     clc;
     n_of_simulations = 1;
     hold on; 
     %disp(['START']);
 else
     clearvars -except n_of_simulations
     clc;
     close all;
 end
%}
%1 - po prostej, 2 - po przekatnej, 3 - po kwadracie., 
%4 - dla rzeczywistych
%5 - dla rzeczywistych pomiarow, symulowanych rozkladow
%6 - dla rzeczywistych pomiarow, symulowanych rozkladow nie po prostej
%7 - Ipin2016Dataset
%8 - Ipin2016Dataset - real data, simulated reference dataset
%9 - Ipin2016Dataset - sciezka przejscia po korytarzach

scenario = 1;
%scenario = 8;

%1 - rozklad liniowy, 2 - logarytmiczny z zanikami, 
%3 - rzeczywisty.
%4 - rozklad wygenerowany z XFDTD
%5 - glasswalls
%6 - brickwalls
%7 - insite1
%8 - glass_increased_transmissions
%9 - brick_increased_transmissions
%10- drywallmore
%11- WIFI measurements
%12- test_data
%13- Grid0_25
%14- Grid0_50

%15- Test_1
%16- Test_2
%17- Test_3
%18- Test_4

%wyniki_share_APG5
%19- Test_1
%20- Test_2
%21- Test_3
%22- Test_4

%19- Grid0_25 y = 40
%20- Grid0_50 y = 20
%21- Grid0_75 y = 15
%22- Grid1_00 y = 11
%23- Grid1_50 y = 8
%24- Grid2_00 y = 7

%25- Grid0_25 y = 40
%26- Grid0_50 y = 20
%27- Grid0_75 y = 15
%28- Grid1_00 y = 11
%29- Grid1_50 y = 8
%30- Grid2_00 y = 7
%31- D:\Robert\Robert\Doktorat\Artyku³y-uporz¹dkowane\Articles\Articles_10_2020\Datasets\Ipin2016Dataset
%definicja stalych
%32 Insite Robert
%35 pomiar zatoka sportu
move_shift = 1;       %wartosc przeskoku w symulacji. 
N= 500;               %liczba czasteczek
data_type = 27 ;

if(data_type == 25) Y_LVL = 40;  end %Grid0_25
if(data_type == 26) Y_LVL = 20;  end %Grid0_25
if(data_type == 27) Y_LVL = 15;  end   %Grid0_50
if(data_type == 28) Y_LVL = 11;  end   %Grid0_75
if(data_type == 29) Y_LVL = 8;  end   %Grid1_00
if(data_type == 30) Y_LVL = 7;  end   %Grid1_50
if(data_type == 31) Y_LVL = 54;  %Y_LVL = 348;
    end
if(data_type == 32) Y_LVL = 354;
end   
    if(data_type == 33) Y_LVL = 13;
    end   
    if(data_type == 34) Y_LVL = 13;
    end 
    
   if(data_type == 35) Y_LVL = 4;
    end 
start_from = 1;
x_est = 1;         %estymacja poczatkowa x
y_est = 1;%6;         %estymacja poczatkowa y 
    %rozpocznij symulacje od n-tej próbki

%MASK2 = 80;
realSize_x = 35; %35.3;
realSize_y = 17;  %17.2;
%realSize = [realSize_x, realSize_y];

%%%%%%%%%%%%%%%%%
debug_mode = 1;
first = 1;
n_of_simulations = 1;
for simulation = 1 : n_of_simulations
 
if(debug_mode == 1)

end
  
 if (simulation > 1)
    close all;
 end
 

%SIGMA_A =   5;       %rozrzut czasteczek
SIGMA_X = 7;
SIGMA_Y = 7;
G_THR =   1;%0.8;     %degeneration threshold
dx_max = 10;        %maksymalne przesuniêcie kolejnej estymaty w osi x
dy_max = 10;        %maksymalne przesuniêcie kolejnej estymaty w osi y

RSSI_range = 4;      %zakres dla poszukiwania lokalizacji na mapie rozkladu dla zmierzonej wartosci RSSI 
RSSI_range_default = RSSI_range;
RSSI_range_max = 9;  %maksymalny rozrzut RSSI +- wartoœci zmierzonej (uzuty w algorytmie, którego celem jest zwiekszenie tolerancji poszukiwan.
noise = 0;         %szum pomiaru (dodawany szum gaussa, lub o rozkladzie normalnym do kazdej probki)
w_upweig_range = 2;
use_magnet = 0;    %skorzystaj z magnetometru 1 - TAK, 0 - NIE.
repeats = 1;
simulate_person_stopped = 0; %mozna zasymulowac zatrzymanie sie czlowieka. kazda kolejny pomiar to ostatnia probka +- noise
steps_stopped = 40;          %ile iteracji ma stac zanim wystartuje dalej
stop_from_step = 40;         %zatrzymanie sie uzytkownika w danym kroku symulacji
add_noise_standing = 1;      %wartosc szumu dla stojacego uzytkownika
%adjust_rss_range = 1;
adjust_rss_range_enable =0;  %w razie gdy nie znaleziono wartosci zblizonych pomiarowi +- RSSI_range w danym obszarze, mozna zwiekszac tolerancje RSSI_range
limit_range = 0;
dx_max_uniq = 5;           %maksymalne obszar poszukiwan wartosci zblizonej pomiarowi w osi x
dy_max_uniq = 5;           %maksymalne obszar poszukiwan wartosci zblizonej pomiarowi w osi y
limit_similar_meas = 0;
use_track_offset = 1;

%1 - w_upweig = update_weights(x_P, y_P, X_S1, Y_S1, X_S2, Y_S2, X_S3, Y_S3, w_upweig_range);     
%2 - w_upweig = update_weights3(x_P, y_P, E_uniq, w_upweig_range );
w_upweig_method = 1;

MASK = -100;
MASK2 = -100;

date = datestr(now,30);
result_dir = strcat(num2str(data_type),'_',date);
filename = strcat('wyniki_30062019_1/','/test_data.txt');
dirpath = strcat('wyniki_30062019_1/',result_dir,'/data',num2str(data_type),'/');

if ~exist(dirpath,'dir') mkdir(dirpath); end
%if ~exist(dirpath,'dir') mkdir(strcat('wyniki/',result_dir,'/data',num2str(data_type),'/')); end

yshift = dy_max;
xshift = dx_max;
data = {};
%%%%%%%%%%%%%%%%%
if(scenario == 5 || scenario == 6)
    [Source1, Source2, Source3, Source4] = load_source(3);
 else
    [Source1, Source2, Source3, Source4] = load_source(data_type);
end

TFromS1=[];
TFromS2=[];
TFromS3=[];
TFromS4=[];

TRACK = [];

%{
Source1 = change_antenna_characteristics(Source1,1);
Source2 = change_antenna_characteristics(Source2,2);
Source3 = change_antenna_characteristics(Source3,3);
Source4 = change_antenna_characteristics(Source4,4);
%}

%for real-vs-simulated test - load Sources again
if(scenario == 5 || scenario == 6)
    %TRACK(1,s) = X;
    %TRACK(2,s) = Y;
    %TRACK(3,s) = SRC1;
    %TRACK(4,s) = SRC2;
    %TRACK(5,s) = SRC3;
    
    %TRACK(6,s) = SRC4;
    %TRACK(7,s) = magnet direction;
    [TRACK,TFromS1,TFromS2,TFromS3,TFromS4]  = movement_scenario(scenario, Source1, Source2, Source3, Source4, 20, noise);
    [Source1, Source2, Source3, Source4] = load_source(data_type);
    LENGTH = size(Source1,2);
    LENGTH_Y = size(Source1,1);
else
    [TRACK,TFromS1,TFromS2,TFromS3,TFromS4]  = movement_scenario(scenario, Source1, Source2, Source3, Source4, Y_LVL, noise);
    LENGTH = size(Source1,2);
    LENGTH_Y = size(Source1,1);
        
    %{
    Source1 = Source1 - diff_for_source(3);
    Source2 = Source2 - diff_for_source(4);
    Source3 = Source3 - diff_for_source(1);
    Source4 = Source4 - diff_for_source(2);
    %}
    
    
    Source1 = Source1 - 40;
    Source2 = Source2 - 30;
    Source3 = Source3 - 50;
    Source4 = Source4 - 20;
    
    Source1(Source1 <= -100) = -100;
    Source2(Source2 <= -100) = -100;
    Source3(Source3 <= -100) = -100;
    Source4(Source4 <= -100) = -100;
    
    TFromS1=adjust_source(TFromS1);
    TFromS2=adjust_source(TFromS2);
    TFromS3=adjust_source(TFromS3);
    TFromS4=adjust_source(TFromS4);
    
    %figure(21); plot(TRACK(3,:));
    %figure(22); plot(TRACK(4,:));
    %figure(23); plot(TRACK(5,:));
    %figure(24); plot(TRACK(6,:));
    
end

%return
[YMAX, XMAX] = size(Source1);
realSize = [36.6, 36.6];

real_x = 0:realSize(1)/LENGTH:realSize(1);
real_y = 0:realSize(2)/LENGTH_Y:realSize(2);

% plot_track();
% plot_sources();

%inicjalizacja wetorow
%T = size(TRACK,2);   %ilosc iteracji rowna wektorowi pomiarow

%T = XMAX;   %ilosc iteracji rowna wektorowi pomiarow

%x_P = rand( 1, N ) * XMAX;    %losowo wygenerowae wspolzedne x polozenia
%y_P = rand( 1, N ) * YMAX;   %losowo wygenerowae wspolzedne y polozenia

 
 x_P = rand( 1, N ) * 5 + (x_est);     %losowo wygenerowae wspolzedne x polozenia
 y_P = rand( 1, N ) * 5 + (y_est);   %losowo wygenerowae wspolzedne y polozenia

x_median = 0;
y_median = 0;
w = ones(1,N) * 1/N;          %wektor wag dla czasteczek
Y_S = [0];
X_S = [0];

if(debug_mode == 1)
    %t³o do wizualizacji
    %figure(2)
    %draw_canvas(XMAX, YMAX);
    %draw_canvas(realSize(1), realSize(2));
    %hold on;
    %p2 = plot( x_P, y_P, '.' );
    %hold on;
end
xy_no_pf=[];
xy_est=[];
%%%%%%%%simulate person stopped
if(simulate_person_stopped == 1)
    TRACK = add_standing_steps(TRACK, steps_stopped, stop_from_step, add_noise_standing, Y_LVL, noise);
end

s = start_from;
error_max_x = 0;
error_max_y = 0;

%plot_track();

 %TRACK(3,:) = plot_real_vs_sim_track('Source1', 11, dirpath, Y_LVL, getTrackFromSource(Source1, TRACK), TRACK(3,:), use_track_offset, realSize, LENGTH, LENGTH_Y, noise);
% %break;
 %TRACK(4,:) = plot_real_vs_sim_track('Source2', 12, dirpath, Y_LVL, getTrackFromSource(Source2, TRACK), TRACK(4,:), use_track_offset, realSize, LENGTH, LENGTH_Y, noise);
 %TRACK(5,:) = plot_real_vs_sim_track('Source3', 13, dirpath, Y_LVL, getTrackFromSource(Source3, TRACK), TRACK(5,:), use_track_offset, realSize, LENGTH, LENGTH_Y, noise);
 %TRACK(6,:) = plot_real_vs_sim_track('Source4', 14, dirpath, Y_LVL, getTrackFromSource(Source4, TRACK), TRACK(6,:), use_track_offset, realSize, LENGTH, LENGTH_Y, noise);

%plot_track();
%plot_sources();
%return
%SetFigPosition()
tic

%uit = table_with_variables();
%table_prev = get(uit, 'data');


while s < length(TRACK(1,:))
    
    tStart = tic;  % TIC, pair 2  
    %Test z magnetometrem
    % 1 przod
    % 2 tyl
    % 3 lewo
    % 4 prawo
    
    t = TRACK(1,s);
    y_lvl = TRACK(2,s);

    dx_max_r    = dx_max;
    dx_max_l    = dx_max;
    dy_max_up   = dy_max;
    dy_max_down = dy_max;

    %get magnet direction
    info = 'brak';
    if(use_magnet == 1)
        [dx_max_r, dx_max_l, dy_max_up, dy_max_down, info] = magnet_get_direction(TRACK(7,s),dx_max,dy_max);    
    end

%     %disp([
%         Source1(y_lvl,t),TRACK(3,s);
%         Source2(y_lvl,t),TRACK(4,s);
%         Source3(y_lvl,t),TRACK(5,s)]);

    % ----- get measurement
    Y_S = [];
    X_S = [];
    %znajdz w maciezy rozkladow punkty odpowiadajace wartosci zmiezonej z
    %zakresu -+ RSSI_range
    %{
    disp(['S1: ', num2str(Source1(t,y_lvl)), ', T1: ', num2str(TRACK(3,s))]);
    disp(['S2: ', num2str(Source2(t,y_lvl)), ', T2: ', num2str(TRACK(4,s))]);
    disp(['S3: ', num2str(Source3(t,y_lvl)), ', T3: ', num2str(TRACK(5,s))]);
    disp(['S4: ', num2str(Source4(t,y_lvl)), ', T4: ', num2str(TRACK(6,s))]);
    disp(['--']);
    %}
    [Y_S1, X_S1] = find(Source1 <= TRACK(3,s)+ RSSI_range & Source1 >= TRACK(3,s)- RSSI_range);
    [Y_S2, X_S2] = find(Source2 <= TRACK(4,s)+ RSSI_range & Source2 >= TRACK(4,s)- RSSI_range);
    [Y_S3, X_S3] = find(Source3 <= TRACK(5,s)+ RSSI_range & Source3 >= TRACK(5,s)- RSSI_range);
    [Y_S4, X_S4] = find(Source4 <= TRACK(6,s)+ RSSI_range & Source4 >= TRACK(6,s)- RSSI_range);
    
    if(limit_similar_meas == 1)
        X_S11 = (X_S1 >= x_est-dx_max_l & X_S1 < x_est+dx_max_r); 
        Y_S11 = (Y_S1 >= y_est-dy_max_down & Y_S1 < y_est+dy_max_up); 

        X_S22 = (X_S2 >= x_est-dx_max_l & X_S2 < x_est+dx_max_r); 
        Y_S22 = (Y_S2 >= y_est-dy_max_down & Y_S2 < y_est+dy_max_up); 

        X_S33 = (X_S3 >= x_est-dx_max_l & X_S3 < x_est+dx_max_r); 
        Y_S33 = (Y_S3 >= y_est-dy_max_down & Y_S3 < y_est+dy_max_up); 

        X_S44 = (X_S4 >= x_est-dx_max_l & X_S4 < x_est+dx_max_r); 
        Y_S44 = (Y_S4 >= y_est-dy_max_down & Y_S4 < y_est+dy_max_up); 

        X_S1 = X_S1(X_S11);
        X_S2 = X_S2(X_S22);
        X_S3 = X_S3(X_S33);
        X_S4 = X_S4(X_S44);

        Y_S1 = Y_S1(X_S11);
        Y_S2 = Y_S2(X_S22);
        Y_S3 = Y_S3(X_S33);
        Y_S4 = Y_S4(X_S44);
    end
    src1 = [X_S1,Y_S1];
    src2 = [X_S2,Y_S2];
    src3 = [X_S3,Y_S3];
    src4 = [X_S4,Y_S4];

    A = [X_S Y_S];
    B = [X_S1'; Y_S1']';
    C = [X_S2'; Y_S2']';
    D = [X_S3'; Y_S3']';
    E = [X_S4'; Y_S4']';
    try
       E_uniq = find_common(B,C,D,E, x_est, y_est, dx_max_uniq, dy_max_uniq, limit_range); 
    catch
       E_uniq = [];
       %%disp('Exception: E_uniq empty')
    end
    if(adjust_rss_range_enable == 1)
        RSSI_range = adjust_rss_range(RSSI_range, E_uniq, repeats, dx_max, dy_max, RSSI_range_default,debug_mode);
    end
     if(isempty(E_uniq))
         if(debug_mode == 1)
            %%disp('E_uniq empty')
         end
        Y_S = [Y_S Y_S1' Y_S2' Y_S3' Y_S4'];
        X_S = [X_S X_S1' X_S2' X_S3' X_S4'];
        if(adjust_rss_range_enable == 1)
            if(RSSI_range < RSSI_range_max)
                RSSI_range = RSSI_range + 1;
                if(debug_mode == 1)
                    %%disp(['2.RSSI_range++:',num2str(RSSI_range)]);
                end
            end
        end
     else
        if(adjust_rss_range_enable == 1)
            if(RSSI_range > RSSI_range_default)
                RSSI_range = RSSI_range - 1;
                if(debug_mode == 1)
                    %%disp(['2.RSSI_range--:',num2str(RSSI_range)]);
                end
            end
        end
        
        Y_S_prv = Y_S;
        X_S_prv = X_S;

        Y_S = E_uniq(:,2);%[Y_S Y_S1' Y_S2' Y_S3'];    
        X_S = E_uniq(:,1);%[X_S X_S1' X_S2' X_S3'];
        length(E_uniq(:,1));
     end

    x_delta = median(X_S)- x_est + SIGMA_X * randn( 1, N );
    if(abs(median(X_S)- x_est)>xshift) 
        %%disp(['x > x_delta_max',num2str(x_delta)]);
        x_delta = xshift;
        if((median(X_S)- x_est) < 0)
            x_delta = -xshift;
        end
    end
    y_delta = median(Y_S)- y_est + SIGMA_Y * randn( 1, N );
    if(abs(median(Y_S)- y_est)>yshift)
        if(debug_mode == 1)
            %%disp(['y > y_delta_max:',num2str(y_delta)]);
        end
        y_delta = yshift;
        if((median(Y_S)- y_est) < 0)
            y_delta = -yshift;
        end
    end


    x_P = x_P + x_delta;
    y_P = y_P + y_delta;

%    if(repeats > 10)
%        %disp(['rozrzut..']);
%         x_P = rand( 1, N ) * XMAX;    %losowo wygenerowae wspolzedne x polozenia
%         y_P = rand( 1, N ) * YMAX;   %losowo wygenerowae wspolzedne y polozenia
%         repeats = 0;

%         x_est = 10;
%         y_est = 20;
%     end

%     x_P(x_P > 100) = 100;
%     y_P(y_P > 100) = 100;
%     
%     x_P(x_P < 1) = 1;
%     y_P(y_P < 1) = 1;

    x_no_pf = median(X_S);
    y_no_pf = median(Y_S);
    
     
    %fig = figure(123);
    fig5 = figure(5);
    fig5=plot((x_no_pf* realSize(1) / LENGTH),(y_no_pf* realSize(2) / LENGTH_Y),  '.-k','linewidth',10);
    %disp(['x_no_pf=',num2str(x_no_pf * realSize(1) / LENGTH),' y_no_pf=',num2str(y_no_pf * realSize(2) / LENGTH_Y)]);
    ORIENT_F = {};
    % update weights9
    if (w_upweig_method == 1 )
        w_upweig = update_weights(x_P, y_P, X_S1, Y_S1, X_S2, Y_S2, X_S3, Y_S3, w_upweig_range);
    else
        w_upweig = update_weights3(x_P, y_P, E_uniq, w_upweig_range );
    end
 
    if(debug_mode == 1)
        if(s < length(TRACK(1,:))-1)
            %show_sources(x_P, y_P,x_est,y_est,src1, src2, src3, src4, t, y_lvl, w_upweig, Source1, Source2, Source3, Source4, E_uniq, MASK, MASK2,dirpath,0,TFromS1,TFromS2,TFromS3,TFromS4);
        else
            %show_sources(x_P, y_P,x_est,y_est,src1, src2, src3, src4, t, y_lvl, w_upweig, Source1, Source2, Source3, Source4, E_uniq, MASK, MASK2,dirpath,1,TFromS1,TFromS2,TFromS3,TFromS4);
        end
    end
    w = w.*w_upweig;
    %w = w.*update_weights2(x_P, y_P, TRACK, t, Source1, Source2, Source3, RSSI_range);

     if(debug_mode == 1)
         % draw particles
         fig5 = figure(5);
         hold off;
         fig5 = plot( x_P, y_P, '*' );
         
     end
    
    % ----- normalize weights
    w = w ./ sum( w );
    
    % ----- resampling
    g = 1 ./ ( N * sum( w.* w ));
    if isnan(g)
      g = 0;
      w = ones(length(w));
      w = w./length(w);
    end
    
    if( g < G_THR )
        if(debug_mode == 1)
            %disp(['t=',num2str(t),' g=',num2str(g),' resampling..']);
        end
        [x_P,y_P,w] = resample(x_P,y_P,w);
    else
        if(debug_mode == 1)
            %disp([' g=',num2str(g)]);
        end
    end

    x_est_prv = x_est;
    y_est_prv = y_est;

    % ----- calculate estimated position
    x_est = mean( x_P );
    y_est = mean( y_P );
    
    %%disp(['x=',num2str(t),' y=',num2str(y_lvl),' x_est=',num2str(x_est),' y_est=',num2str(y_est)]);
    
%     if(abs(x_est - x_est_prv) > xshift)
%         if(abs(x_est - x_est_prv)) >= 0
%             x_est = x_est_prv + xshift;
%         else
%             x_est = x_est_prv - xshift;
%         end
%     end
%     
%     if(abs(y_est - y_est_prv) > yshift)
%         if(abs(y_est - y_est_prv)) >= 0
%             y_est = y_est_prv + yshift;
%         else
%             y_est = y_est_prv - yshift;
%         end
%     end

    %xy_est = [xy_est;[x_est y_est]];
    % draw estimated location
    
    if(debug_mode == 1)
    %fig = figure(123);
%     if(first == 1)
%         %disp(['sleep...']);
%         pause(20);
%         %disp(['end...']);
%        first = 0; 
%     end
    
    x_P_real = x_P * realSize(1) / LENGTH;
    y_P_real = y_P * realSize(2) / LENGTH_Y;
    fig4 = plot( x_P_real, y_P_real, '.b' );
    fig5 = plot( x_P_real, y_P_real, '.b' );
    hold on;
    plot( x_est,y_est, '.g','MarkerSize',15 );
    hold on;
    %delete(p3);
    x_est_real = x_est * realSize(1) / LENGTH;
    y_est_real = y_est * realSize(2) / LENGTH_Y;
    
    fig5 = plot(x_est_real,y_est_real,  '.-g','linewidth',15);
    
    xx = real_x(t);
    y_lvl_real = y_lvl * realSize(2) / LENGTH_Y;
    %axis equal
    axis([0 realSize(1) 0 realSize(2)]);
    fig5 = plot( xx, y_lvl_real, '.m','linewidth',15);
    %legend('real position','estimated position','particles','Location','best');
    %axis equal
    hold on;   
    end

    error_x  = abs(x_est - t);
    error_y  = abs(y_est - y_lvl);
    XY = [x_est,y_est;t,y_lvl];
    error_xy = pdist(XY,'euclidean');
    if(error_max_x < error_x) error_max_x = error_x; end
    if(error_max_y < error_y) error_max_y = error_y; end

    error_x_no_pf  = abs(x_est - x_no_pf);
    error_y_no_pf  = abs(y_est - y_no_pf);
    XY_no_pf = [x_est,y_est;x_no_pf,y_no_pf];
    error_xy_no_pf = pdist(XY_no_pf,'euclidean');
    
    error_x_real = error_x * realSize(1) / LENGTH;
    error_y_real = error_y * realSize(2) / LENGTH_Y;

    t_real = t * realSize(1) / LENGTH;
    y_lvl_real = y_lvl_real * realSize(2) / LENGTH_Y;

    x_est_real = x_est * realSize(1) / LENGTH;
    y_est_real = y_est * realSize(2) / LENGTH_Y;
    %disp([num2str(t_real),' ', num2str(y_lvl_real),' ', num2str(x_est_real),' ', num2str(y_est_real)]);
    
    XY_real = [x_est_real, y_est_real; t_real, y_lvl_real];
    
    error_XY_real = pdist(XY_real,'euclidean');
    
    tElapsed = toc(tStart);  % TOC, pair 2  
    %disp(['tElapsed: ', num2str(tElapsed)]);

        data = [data; t, t, x_est, y_est, error_x, error_y, error_xy,error_x_no_pf,error_y_no_pf,error_xy_no_pf,error_XY_real,tElapsed];
    data_arr = cell2mat(data);

    if(debug_mode == 1)
%         title({
%         ['Error x: ',num2str(error_x,3),' y:',num2str(error_y,3)
%         ],['Max error x: ',num2str(error_max_x,3),' y:',num2str(error_max_y,3)
%         %,', dist: ',num2str(error_xy,4)...
%         ],...
%         ['Mean error x:',num2str(mean(data_arr(:,5)),3),' y:',num2str(mean(data_arr(:,6)),3)],...
%         ['Mean error x[m]:',num2str(mean(data_arr(:,5)),3),' y[m]:',num2str(mean(data_arr(:,6)),3)],...
%         ['Max error x[m]:',num2str(((mean(data_arr(:,5)) * realSize(1)) / LENGTH),3),' y[m]:',num2str(((max(data_arr(:,5)) * realSize(1)) / LENGTH),3)],...
%         ['Dominant error x:',num2str(mode(uint8(data_arr(:,5))),3),' y:',num2str(mode(uint8(data_arr(:,6))),3)
%         ],['Kierunek: ',info]
%         });


        %title({
        %['Error x[m]: ',num2str(error_x_real,3),', y[m]:',num2str(error_y_real,3)],...
        %['Mean error x[m]:',num2str(((mean(data_arr(:,5)) * realSize(1)) / LENGTH),3),', y[m]:',num2str(((mean(data_arr(:,6)) * realSize(2)) / LENGTH_Y),3)],...
        %['Max error x[m]:',num2str(((max(data_arr(:,5)) * realSize(1)) / LENGTH),3),', y[m]:',num2str(((max(data_arr(:,6)) * realSize(2)) / LENGTH_Y),3)],...
        %['Kierunek: ',info]...
        %});
    
        % draw true location
        draw_canvas(XMAX, XMAX);
        %draw_canvas(realSize(1), realSize(2));
        drawnow;  

    end
    e_x = sqrt( ( x_est - t ).^2 );
    e_y = sqrt( ( y_est - y_lvl ).^2 );

    s = s + move_shift;

    end
    
print_and_save_results();
    end    
%figure(6)
% hold on;
% subplot(3,1,1)
% plot(data_array(:,1),data_array(:,8), '-r' );
% title(['Error x']);
% subplot(3,1,2)
% plot(data_array(:,1),data_array(:,9), '-r' );
% title(['Error y']);
% subplot(3,1,3)
% plot(data_array(:,1),data_array(:,10), '-r' );
% title(['Error dist']);
