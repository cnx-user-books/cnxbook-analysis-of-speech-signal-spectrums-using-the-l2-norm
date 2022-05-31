
function [ permutations ] = findAllPermutations( array, subsetSize );

  sArray = numel(array);
  if subsetSize > sArray
    error('Subset size must be smaller than array size')
  end
  
  %  create an output variable for storage
  permutations = zeros(findNumOfPermutations(sArray,subsetSize), subsetSize);

  flagArray = zeros(1,sArray);
  flagArray(sArray-subsetSize+1:end) = 1;

  permutationIndx = 1;
  notDone = 1;

  while(notDone)
    these = find(flagArray);
    % for this given combination, find all permutations
    notDoneInner=1;
    while(notDoneInner)
      permutations(permutationIndx, 1:end) = array(these);
      permutationIndx = permutationIndx + 1;
      [notDoneInner, these] = next_permutation( these );
    end
    
    [notDone, flagArray] = next_permutation( flagArray );
  end
return


function nPk = findNumOfPermutations( n, k );
  nPk = n;
  for i=1:k-1
    nPk = nPk * (n-i);
  end
  return
return


