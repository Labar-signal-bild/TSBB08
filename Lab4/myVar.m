function var = myVar(in,Thres,Flag)

  lowersum1 = sum(in*[1:length(in)].^2');
  lowersum2 = sum(in);
  if lowersum2 ~= 0
    var = lowersum1/lowersum2-myMean(in,Thres,Flag)^2;
  else
    var = 0;
  end;

  maxLength = length(in);
  if(Flag == 0)
  lowersum1 = sum(in(1:Thres)*[1:Thres].^2');
  lowersum2 = sum(in(1:Thres));
  if lowersum2 ~= 0
    var = lowersum1/lowersum2-myMean(in,Thres,Flag)^2;
  else
    var = Thres;
  end;
  else
  uppersum1 = sum(in(Thres+1:maxLength)*[Thres+1:maxLength].^2');
  uppersum2 = sum(in(Thres+1:maxLength));
  if lowersum2 ~= 0
    var = uppersum1/uppersum2-myMean(in,Thres,Flag)^2;
  else
    var = Thres;
  end;
  end
  
end

