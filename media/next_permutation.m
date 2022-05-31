function [ notDone, nextPerm ] = next_permutation( currentPerm );
  notDone=1;
  nextPerm = currentPerm;
  
  last = numel(currentPerm);
  if last==1
    notDone=0;
    return
  end
  next = last - 1;

  while(1),
    next1 = next;
    next = next - 1;
    if nextPerm(next+1) < nextPerm(next1+1)
      mid = last;
      mid = mid - 1;
      while ~ (nextPerm(next+1) < nextPerm(mid+1))
        mid = mid - 1;
        mid=mid;
      end
      temp = nextPerm(next+1);
      nextPerm(next+1) = nextPerm(mid+1);
      nextPerm(mid+1) = temp;
      nextPerm(next1+1:end) = flipdim( nextPerm(next1+1:end), 2 );
      return
    end

    if next==0
      nextPerm = flipdim(nextPerm, 2);
      notDone=0;
      return
    end
  end
end

