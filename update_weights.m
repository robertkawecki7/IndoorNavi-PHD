function w = update_weights(x,y,xS1,yS1,xS2,yS2,xS3,yS3, range)

N = length( x );

w = ones( 1, N );

%range = 3;
for n=1:N
   
    
    k = find(xS1 <= x(n)+ range  & xS1 >= x(n)- range);
    l = find(yS1 <= y(n)+ range  & yS1 >= y(n)- range);
    
    s1_c = length(intersect(k,l));
    
    k = find(xS2 <= x(n)+ range  & xS2 >= x(n)- range);
    l = find(yS2 <= y(n)+ range  & yS2 >= y(n)- range);    
    
    s2_c = length(intersect(k,l));
    
    if s1_c == 0 && s2_c == 0
        w(n) = 0;
        continue;
    end
    
    if s1_c > 1 && s2_c > 1
        continue;
    end
    
    
    k = find(xS3 <= x(n)+ range  & xS3 >= x(n)- range);
    l = find(yS3 <= y(n)+ range  & yS3 >= y(n)- range);    
    
    s3_c = length(intersect(k,l));   
    
    if (s1_c == 0 && s3_c == 0) || (s2_c == 0 && s3_c == 0) || (s1_c == 0 && s3_c == 1) || (s2_c == 0 && s3_c == 1)
        w(n) = 0;
        continue;
    end


    
end


