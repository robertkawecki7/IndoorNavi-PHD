function [ x_new, y_new, w_new ] = resample( x, y, w )



N = length( x );
x_new =     zeros( 1, N );
y_new =     zeros( 1, N );
w_new =     zeros( 1, N );


w_max = max( w );

if w == 0
    w_max = 1;
end


for i=1:N
    w_rnd = rand( 1, 1 ) * w_max;
    while 1
        j = round( rand( 1, 1 ) * (N - 1) ) + 1;
        if( w(j) >= w_rnd )
            x_new(i) =      x(j);
            y_new(i) =      y(j);
            w_new(i) =      w(j);
            break;
        end
    end
end

w_new = ones( 1, N )/N;




