%% Lab4 

%% Struct


%% Uppgift 1.2 Least Error Method

A = getimg('T1');
H = histogram(A);
T = leastError(H);
D = threshold(A, T,'<');
newimage (D, 'Thresholded', 5);

%% Uppgift 1.3

A = getimg('A4');
H = histogram(A);
T = leastError(H);
D = threshold(A, T,'<');
newimage (D, 'A4', 5);

A = getimg('B4');
H = histogram(A);
T = leastError(H);
D = threshold(A, T,'<');
newimage (D, 'H4', 5);
 
%% Uppgift 2.1

B = getimg('E1');
ocrRecog(B)

%% Uppgift 3
Label = zeros(9,1);

A = getimg('A1');
B = getimg('B1');
C = getimg('C1');
D = getimg('D1');
E = getimg('E1');
F = getimg('F1');
G = getimg('G1');
H = getimg('H1');
I = getimg('I1');

Hist(1) = ocrRecog(A);
Hist(2) = ocrRecog(B);
Hist(3) = ocrRecog(C);
Hist(4) = ocrRecog(D);
Hist(5) = ocrRecog(E);
Hist(6) = ocrRecog(F);
Hist(7) = ocrRecog(G);
Hist(8) = ocrRecog(H);
Hist(9) = ocrRecog(I);
Hist
%newimage (B, 'Thresholded', 5);

%% Uppgift 3.1

Nollb = getimg('B1');

NegLaplace =-ones(25,25);
NegLaplace(13,13) = 624; 

convImage = circconv(Nollb,NegLaplace,625);

convImage = convImage + 128;

newimage(convImage,'hej',5);

ocrRecog(convImage)