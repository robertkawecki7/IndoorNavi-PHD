function returnSource = adjust_source(TFromS)
Source = TFromS;

y = size(Source,1);
x = size(Source,2);

newTFromS = [];
for i=1:x-96
    for j=1:y
    
        newTFromS(i,j) = Source(i+96,j);
        
    end
end

returnSource = newTFromS;
%figure(669);imagesc(Source3);
%figure(670);imagesc(TFromS1);
%figure(671);imagesc(newTFromS);