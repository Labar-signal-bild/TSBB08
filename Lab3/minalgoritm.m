function [out1] = minalgoritm(in, step)
a = threshold (in, 128 , '>');
colimage (a, 'gray', 1,1); %show intermediate result
b = contract(a,8, step);
c = expand (b, 8, step);
d = a - c;
out1 = d;
end

