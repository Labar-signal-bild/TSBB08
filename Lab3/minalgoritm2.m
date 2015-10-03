function [out1] = minalgoritm2(in, step)
a = threshold (in, 128 , '>');
colimage (a, 'gray', 1,1); %show intermediate result
e = expand (a, 8, step);
f = contract(e,8, step);
a = invert(a);
g = a.*f;
out1 = g;
end
