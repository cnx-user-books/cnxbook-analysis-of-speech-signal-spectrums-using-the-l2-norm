
function [metric] = comparisonMetric( magfftNumSig, meanFFTMag, stdDevFFTMag )

  L1 = length( magfftNumSig );
  L2 = length( meanFFTMag );
  L3 = length( stdDevFFTMag );

  if L1 ~= L2  ||  L2 ~= L3
    error('Spectrums must be the same length');
  end
  
  diffSq = (magfftNumSig - meanFFTMag).^2 / (2e-4);
  ratio = diffSq ./ stdDevFFTMag;

  metric = sqrt( sum( ratio ) );

end

