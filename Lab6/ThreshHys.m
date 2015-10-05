function [ B ] = ThreshHys( Im,T1,T2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

B = Im>T1; 
%newimage (B, 'BThreshold', 5);

C = Im>T2; 
%newimage (C, 'CThreshold', 5);

E = B.*0;

while sum(sum(E))~=sum(sum(B))
E = B;
D = bwmorph(B,'dilate',1);
B = D.*C;
end

end

