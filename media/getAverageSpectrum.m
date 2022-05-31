
function [meanFFTMag,stdDevFFTMag] = getAverageSpectrum( directory, downSample, lengthSig, N )

  energyThresh = 0.95;

  pinFile = [directory,num2str(1),'.wav'];
  [numData, fsPin, nBitsPin] = wavread( pinFile );
  numData = numData';
  numSig = extractSignal( numData, energyThresh);
  numSig = numSig(1:downSample:end);

  specLength = round( lengthSig / 2 );
  
  magfftNumSig = zeros( N, specLength );

  for i=1:N,

    pinFile = [directory,num2str(i),'.wav'];
    [numData] = wavread( pinFile );
    numData = numData';
    numSig = extractSignal( numData, energyThresh);
    numSig = numSig(1:downSample:end);

    tmp = zeros(lengthSig);
    last = min([lengthSig,length(numSig)]);
    tmp(1:last) = numSig(1:last);
    numSig = tmp;

    magFFTSig = abs( fft( numSig ) );

    Energy = sqrt( sum( magFFTSig .* magFFTSig ) );
    magFFTSig = magFFTSig / Energy;

    magfftNumSig(i,:) = magFFTSig(1:specLength);

    %subplot(N+2,1,i), plot( magFFTSig(1:specLength) );
    %title( ['Normalized Spectrum of sound ', num2str(i)] );

  end

  meanFFTMag = mean( magfftNumSig, 1 );
  stdDevFFTMag = std( magfftNumSig, 0, 1 );

  %subplot( N+2, 1, 4), plot( meanFFTMag );
  %title( ['Average Normalized Spectrum of Recordings Shown'] );
  %subplot( N+2, 1, 5), plot( stdDevFFTMag );
  %title( ['Standard Deviation of Normalized Spectrums Shown'] );
  %xlabel( 'Frequency bin' );

end

