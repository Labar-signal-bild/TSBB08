function mean = myMean(in,Thres,Flag)

  maxLength = length(in);
  if(Flag == 0)
  lowersum1 = sum(in(1:Thres)*[1:Thres]');
  lowersum2 = sum(in(1:Thres));
  if lowersum2 ~= 0
    mean = lowersum1/lowersum2;
  else
    mean = Thres;
  end;
  else
  uppersum1 = sum(in(Thres+1:maxLength)*[Thres+1:maxLength]');
  uppersum2 = sum(in(Thres+1:maxLength));
  if uppersum2 ~= 0
    mean = uppersum1/uppersum2;
  else
    mean = Thres;
  end;
  end
end

