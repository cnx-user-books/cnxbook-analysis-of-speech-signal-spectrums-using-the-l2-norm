
function [ entropy ] = calcEntropy( probDist )

  sProbDist = size( probDist );
  logProbDist = zeros( sProbDist(1), sProbDist(2) );

  [nonZeroRows,nonZeroCols] = find( probDist > 1e-4 );
  logProbDist(nonZeroRows,nonZeroCols) = log(probDist(nonZeroRows,nonZeroCols));
  
  entropy = - sum( sum( probDist .* logProbDist ) );

end
