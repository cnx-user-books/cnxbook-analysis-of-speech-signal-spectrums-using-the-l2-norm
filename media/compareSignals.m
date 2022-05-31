
function [metric] = compareSignals( num, currentDirectory, userDirectory )

  N = 7;  % Number of recordings
  downSamp = 20;  % Amount to downsample recordings
  energyThresh = 0.95;

  currentFile = [currentDirectory,'/',num,'.wav'];
  [currentData, fsCurrent, nbitsCurrent] = wavread( currentFile );
  currentData = currentData';
  currentSig = extractSignal( currentData, energyThresh);

  currentSig = currentSig(1:downSamp:end);

  magFFTSig = abs( fft( currentSig ) );
  Energy = sqrt( sum( magFFTSig .* magFFTSig ) );
  magFFTSig = magFFTSig / Energy;

  lengthSig = length( magFFTSig );

  magFFTSig = magFFTSig( 1 : round(lengthSig/2) );

  %figure( 'Name', ['Spectrums of ', num]) ;
  [meanFFTMag,stdDevFFTMag] = getAverageSpectrum( [userDirectory,'/',num], downSamp, lengthSig, N );

  %metric = comparisonMetric( magFFTSig, meanFFTMag, stdDevFFTMag );
  metric = norm( magFFTSig - meanFFTMag );

  %figure( 'Name', ['Comparison Spectrums of ', num] );
  %subplot(3,1,1), plot( magFFTSig ), title('Current Spectrum');
  %subplot(3,1,2), plot( meanFFTMag ), title('Mean Spectrum');
  %subplot(3,1,3), plot( sqrt( (magFFTSig - meanFFTMag) .* (magFFTSig - meanFFTMag ) ) );
end



