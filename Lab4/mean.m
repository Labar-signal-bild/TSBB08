function mean = myMean(in)

  lowersum1 = sum(in*[1:length(in)]');
  lowersum2 = sum(in);
  if lowersum2 ~= 0
    mean = lowersum1/lowersum2;
  else
    mean = num0;
  end;

end

