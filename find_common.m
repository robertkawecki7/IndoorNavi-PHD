    function E_uniq = find_common(B,C,D,E, x_est, y_est, dx_max_uniq, dy_max_uniq, limit_range)

    E = intersect(B,C,'rows');
    E_uniq_prv_0 = intersect(E,D,'rows');
    E_uniq_prv = intersect(E_uniq_prv_0,E,'rows');
    
    %{
    if(limit_range == 1)
        E_uniq = [];
        for i = 1 : length(E_uniq_prv)
            if((E_uniq_prv(i,1) <= x_est + dx_max_uniq && E_uniq_prv(i,1) >= x_est - dx_max_uniq)...
                &&...
                (E_uniq_prv(i,2) <= y_est + dy_max_uniq && E_uniq_prv(i,2) >= y_est - dy_max_uniq))

                E_uniq = [E_uniq;[E_uniq_prv(i,1),E_uniq_prv(i,2) ]];
                %E_uniq = [E_uniq E_uniq_prv(i,2)];
            end
        end
    else
       E_uniq = E_uniq_prv;
    end
    
     status = 1;
     status_c = 0 ;
     status_d = 0 ;
 
    for j = 1 : length(B)
         a_x = B(j,1);
         a_y = B(j,2);
 
         if((a_x - DIFF <= b_x && a_x + DIFF >= b_x) && ...
            (a_y - DIFF <= b_y && a_y + DIFF >= b_y))
           status_b = 1 ;
           break;
         end
 
    for j = 1 : length(C)
         b_x = C(j,1);
         b_y = C(j,2);
         if((a_x - DIFF <= b_x && a_x + DIFF >= b_x) && ...
            (a_y - DIFF <= b_y && a_y + DIFF >= b_y))
           status_c = 1 ;
           break;
         end
    end
    for j = 1 : length(D)
         b_x = D(j,1);
         b_y = D(j,2);
         if((a_x - DIFF <= b_x && a_x + DIFF >= b_x) && ...
            (a_y - DIFF <= b_y && a_y + DIFF >= b_y))
           status_d = 1 ;
           break;
         end
    end
 
   status = status_c && status_d;
 
   if(status == 1)
     E = [E; [a_x a_y]];  
   end
 end
     %}
     size(E);
     
     E_uniq = unique(E,'rows');
    %{
     E = intersect(A,B);
     F = intersect(A,C);
     G = intersect(A,D);
     
     H = intersect(E,F);
     I = intersect(E,G);
     J = intersect(H,I);
     %}