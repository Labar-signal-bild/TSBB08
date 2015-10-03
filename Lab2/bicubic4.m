function height = bicubic4(distance)

if(distance <= 1)
    height = 2*abs(distance)^3-3*distance^2+1;
else
    error('Distance larger then permited');
end
end

