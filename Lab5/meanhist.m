function out = meanhist(in)
%# operation 'meanhist'
%# returns real 'Mean'
%# param in histogram 'Image'
% 
%
%function out = meanhist(in)
%
% Returns the mean value of a histogram.
%
% --- input ---
%
% in	: histogram  
%
% --- output ---
%
% out	: real value; mean of the input histogram
%
%
%

if min(size(in)) > 1
  error('Ett histogram ska vara endimensionellt');
end;

siz = max(size(in));

x = (0:siz-1);

if size(in, 1) == 1
  out = sum(in .* x) / sum(in);
else
  out = x * in / sum(in);
end;


