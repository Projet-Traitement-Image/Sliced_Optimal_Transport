function HCN = histogramme_cumule (I, histogramme_I, type)
  [~,n] = size(histogramme_I);
  [x,y] = size(I);
  HCN=zeros(1,256);
  sum = 0;
  if type == "normalise"
    for i = 1:n
        HCN(i) = (histogramme_I(i) + sum)/(x*y);
        sum = sum + histogramme_I(i);
    end
   else
    for i = 1:n
        HCN(i) = (histogramme_I(i) + sum);
        sum = sum + histogramme_I(i);
    end
   end
end

