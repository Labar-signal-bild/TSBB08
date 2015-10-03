function out = leastError(in,start)
%# operation 'midway'
%# returns integer 'Threshold'
%# param in histogram 'Histogram'
%# param start integer 'Start'


num   = length(in);
t1    = round(start);
t0    = t1+2;

% Calculate the threshold
%------------------------
while abs(t0-t1) > 0.5

  t0 = t1;
  num0 = t0;
    
  % Calculate mean for the lower part of the histogram
  %---------------------------------------------------
  mean0 = myMean(in,num0,0);
  var0  = myVar(in,num0,0);
  sd0   = sqrt(var0);
  
    
  %Calculate P0
  %---------------------------------------------------
  P0 = sum(in(1:num0));
  
    
  % Calculate mean for the upper part of the histogram
  %---------------------------------------------------
  mean1 = myMean(in,num0,1);
  var1  = myVar(in,num0,1);
  sd1   = sqrt(var1);  
  
    
  %Calculate P1
  %---------------------------------------------------
  P1 = sum(in(num0+1:num));
   
  
  % Calculate new threshold
  %------------------------
  C = ((var1-var0)/(var1*var0));
  A = 2*(-mean0/var0+mean1/var1)/C;
  B = (log(var0/var1)+(mean0/sd0)^2-(mean1/sd1)^2-2*log(P0/P1))/C;
  temp1 = -A/2 - sqrt((A/2)^2-B);
  temp2 = -A/2 + sqrt((A/2)^2-B);
  if(abs(t0-temp1)<abs(t0-temp2))
          t1=floor(temp1);
  else
          t1=ceil(temp2);
  end
  
end;

out = t1-1;
end
