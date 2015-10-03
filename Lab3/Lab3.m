%% Lab 3 uppgift 1.1

%Open babbon in C1

f = getimg('A1');
g = 2 * f-128;
newimage (g, 'monkey', 2);

%% Lab 3 uppgift 2.5 Ejiri's algorithm

%Open kretskort 1 i A1
%execute('minalgoritm','D1',2)
execute('minalgoritm2','D1',2)
close figure 1

%% Lab 3 uppgift 4

a = getactive;
sum(sum(a))

%% 

a = getimg('H8');
b = getimg('H14');
c = a+b;
newimage(c, 'solved', 2);