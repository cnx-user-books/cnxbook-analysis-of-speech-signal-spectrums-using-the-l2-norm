function oneSpectralComparison(  )

  file1 = 'C:\Users\nicholas\Documents\My Stuff\My School\CSUN\Math480\project\recordings\person\nicholas\one1.wav';
  file2 = 'C:\Users\nicholas\Documents\My Stuff\My School\CSUN\Math480\project\recordings\person\nicholas\one2.wav';
  
  [data1, fsPin, nBitsPin] = wavread( file1 );  data1=data1';
  [data2, fsPin, nBitsPin] = wavread( file2 );  data2=data2';

  downSample = 20;
  data1 = data1(1:downSample:end);   fsPin = fsPin/downSample;
  data2 = data2(1:downSample:end);
  
  length1 = length(data1);
  length2 = length(data2);
  Nmax = max([length1,length2]);

  % zero pad the signals
  if length1 > length2
    zpData1=data1;  zpData2=data1;
  else
    zpData1=data2;  zpData2=data2;
  end

  zpData1(:) = 0;   zpData1(1:length1)=data1;   fft1 = fft(zpData1);
  zpData2(:) = 0;   zpData2(1:length2)=data2;   fft2 = fft(zpData2);

  subplot(2,1,1),  plot(abs(fft1)), title('Magnitude of Spectrum of one1');
  subplot(2,1,2),  plot(abs(fft2)), title('Magnitude of Spectrum of one2');
  xlabel('Frequency bin');

  figure;
  magFFT1 = abs(fft1);  magFFT2 = abs(fft2);
  subplot(4,1,1),  plot(magFFT1), title('Magnitude of Spectrum of one1');
  subplot(4,1,2),  plot(magFFT2), title('Magnitude of Spectrum of one2');
  subplot(4,1,3),  plot(magFFT1(1:400)), title('Magnitude of Spectrum of one1');
  subplot(4,1,4),  plot(magFFT2(1:400)), title('Magnitude of Spectrum of one2');
  xlabel('Frequency bin');
  
  nFFT1 = norm( fft1 );   fft1 = fft1 / nFFT1;
  nFFT2 = norm( fft2 );   fft2 = fft2 / nFFT2;
  magFFT1 = abs(fft1);  magFFT2 = abs(fft2);

  figure;
  subplot(2,1,1),  plot(abs(fft1)), title('Magnitude of Normalized Spectrum of one1');
  subplot(2,1,2),  plot(abs(fft2)), title('Magnitude of Normalized Spectrum of one2');
  xlabel('Frequency bin');

  fileTwo = 'C:\Users\nicholas\Documents\My Stuff\My School\CSUN\Math480\project\recordings\person\nicholas\two1.wav';
  [dataTwo, fsPin, nBitsPin] = wavread( fileTwo );  dataTwo=dataTwo';
  fftTwo = fft( dataTwo );
  dataTwo = dataTwo(1:downSample:end);
  nFFTTwo = norm( fftTwo );  fftTwo = fftTwo / nFFTTwo;
  magFFTTwo = abs(fftTwo);
  figure;
  subplot(3,1,1), plot( magFFT1(1:800) ), title('Magnitufe of Normalized Spectrum of one1');
  subplot(3,1,2), plot( magFFT2(1:800) ), title('Magnitufe of Normalized Spectrum of one2');
  subplot(3,1,3), plot( magFFTTwo(1:800) ), title('Magnitufe of Normalized Spectrum of two1');;
  xlabel('Frequency bin');

  E1 = sqrt( sum( magFFT1.*magFFT1 ) );
  E2 = sqrt( sum( magFFT2.*magFFT2 ) );


  %equalized2 = fft2 * sqrt(E1) / sqrt(E2);
  %subplot(2,1,1),  plot(abs(fft1)), title('Magnitude of Normalized Spectrum of two1');
  %subplot(2,1,2),  plot(abs(equalized2)), title('Magnitude of Equalized Spectrum of two2');
  %xlabel('Frequency bin');

  diffFFT = fft1 - fft2;
  nDiff = norm( diffFFT );

  disp( ['Energy1: ', num2Str( E1 ) ] );
  disp( ['Energy2: ', num2Str( E2 ) ] );
  disp( ['Norm of Diff: ', num2str(nDiff)] );

  disp('Stop here');
end










