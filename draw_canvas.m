function draw_canvas(x_size, y_size)

% ----- prepare canvas for drawing
hold off;
draw_walls(x_size, y_size);
%axis( [-1,x_size+1,-1, y_size+1] );
% xlabel( 'x[m]' );
% ylabel( 'y[m]' );
grid on;
hold on;