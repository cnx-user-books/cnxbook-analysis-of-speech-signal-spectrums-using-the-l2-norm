
function [ mutualInfo ] = calcMutualInfo( sig1, sig2 )

  s1 = size( sig1 );
  s2 = size( sig2 );

  if s1(1) ~= s2(1)  ||  s1(2) ~= s2(2)
    error('Incorrect inputs to hist2D');
  end

  jointHist = hist2D( sig1, sig2 );
  
  hist1 = sum( jointHist, 1 );
  hist2 = sum( jointHist, 2 );

  prob1 = hist1 / ( s1(1) * s1(2) );
  prob2 = hist2 / ( s2(1) * s2(2) );
  
  entropy1 = calcEntropy( prob1 );
  entropy2 = calcEntropy( prob2 );

  jointEntropy = calcEntropy( jointHist );

  mutualInfo = entropy1 + entropy2 - jointEntropy;
  
end
