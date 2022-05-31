
function [ nmi ] = calcNormMutualInfo( sig1, sig2 )

  s1 = size( sig1 );
  s2 = size( sig2 );

  if s1(1) ~= s2(1)  ||  s1(2) ~= s2(2)
    error('Incorrect inputs to hist2D');
  end

  jointHist = hist2D( sig1, sig2 );
  sJointHist = size( jointHist );
  
  hist1 = sum( jointHist, 1 );
  hist2 = sum( jointHist, 2 );

  prob1 = hist1 / ( sJointHist(1) );
  entropy1 = calcEntropy( prob1 );

  prob2 = hist2 / ( sJointHist(2) );
  entropy2 = calcEntropy( prob2 );

  jointProb = jointHist / ( sJointHist(1) * sJointHist(2) );
  jointEntropy = calcEntropy( jointProb );

  nmi = ( entropy1 + entropy2 ) / jointEntropy;  
end
