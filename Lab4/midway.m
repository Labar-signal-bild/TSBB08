function out = midway(in, start)
%# operation 'midway'
%# returns integer 'Threshold'
%# param in histogram 'Histogram'
%# param start integer 'Start'

num = length(in);
t1 = round(start);
t0 = t1+2;

% Calculate the threshold
%------------------------
while abs(t0-t1) > 0.5

  t0 = t1;
  num0 = t0;
    
  % Calculate mean for the lower part of the histogram
  %---------------------------------------------------
  mean0 = myMean(in(1:num0));
  var0  = mvVar(in(1:num0));
  sd0   = sqrt(var0);
    
  % Calculate mean for the upper part of the histogram
  %---------------------------------------------------
  mean1 = myMean(in(num0+1:num));
  var1  = myVar(in(num0+1.num));
  sd1   = sqrt(var1);  
  
  % Calculate new threshold
  %------------------------
  C = ((var1-var0)/(var1*var0));
  A = 2*(-mean0/var0+mean1/var1)/C;
  B = (ln(sd0/sd1)^2+(mean0/sd0)^2-(mean1/sd1)^2)/C;
  t1= -A/2 + sqrt((A/2)^2-B);
end;

out = t1;
