

function audacityAssignment()

  file1 = 'Put the first *.wav file here';
  file2 = 'Put the second *.wav file here';

  file1 = ['./ND_zeroOneTwo/', zeroOneTwo_08000 ];
  file2 = ['./ND_zeroOneTwo/', zeroOneTwo_16000 ];
  file3 = ['./ND_zeroOneTwo/', zeroOneTwo_44100 ];

  [data1, fs1, nbits1] = wavread( file1 );
  [data2, fs2, nbits2] = wavread( file2 );
  [data3, fs2, nbits2] = wavread( file2 );

  lengthData1 = length(data1);
  lengthData2 = length(data2);
  minLength = min(lengthData1,lengthData2);

  data1 = data1(1:minLength);
  data2 = data2(1:minLength);

  normData = max( data1 - data2 );
  disp( ['Norm of Data: ', normData] );

  fftData1 = fft( data1 );
  magFFTData1 = abs( fftData1 );

  fftData2 = fft( data2 );
  magFFTData2 = abs( fftData2 );

  normMagFFT = max( magFFTData1 - magFFTData2 );
  disp( ['Norm of Spectrum: ', normData] );

end

