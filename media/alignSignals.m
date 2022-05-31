
function [alignedTemplate, alignedSignal] = alignSignals( template, signal, energyThresh )

  sTemplate = size( template );
  sSig = size( signal );

  % Align the signals temporally
  corr = normxcorr2( template, signal );
  [ maxCorr, maxIndx ] = max( corr );
  lowIndx = round( maxIndx-sTemplate(2) );
  highIndx = maxIndx - 1;
  subSignal = signal(lowIndx+1:highIndx+1);

  % Now that we've aligned the signals, extract the relevant portions of
  % the signal out of the data

%     % Byte scale the signals
%     meanData = mean2([ template, subSignal ]);
%     maxData = max([ template, subSignal ]);
%     minData = min([ template, subSignal ]);
%     scaledTemplate = round( (template - minData)/(maxData-minData) * 255 );
%     scaledSignal = round( (subSignal - minData)/(maxData-minData) * 255 );

  % Find the indices such that the energy in the extracted portion of
  % data is greater than a threshold
  totalEnergy = sum( subSignal.^2 );
  midIndx = round( sTemplate(2)/2 );
  leftIndx = midIndx-1;
  rightIndx = midIndx+1;

  energy = sum( subSignal(leftIndx+1:rightIndx+1).^2 );
  %energyThresh = 0.999;
  while( energy < energyThresh*totalEnergy )
    if leftIndx > 0 && rightIndx < sTemplate(2)-1
      if subSignal(leftIndx-1) > subSignal(rightIndx+1)
        leftIndx = leftIndx - 1;
      else
        rightIndx = rightIndx + 1;
      end
    elseif leftIndx > 0
      leftIndx = leftIndx - 1;
    else
      rightIndx = rightIndx + 1;
    end
    energy = sum( subSignal(leftIndx+1:rightIndx+1).^2 );
  end

%   subplot(2,1,1), plot(subSignal);
%   title('Original Signal');
%   xlabel('Time'), ylabel('Wav Intensity');
%   subSignal(1:leftIndx) = 0;
%   subplot(2,1,2), plot(subSignal);
%   title('Thresholded Signal: 99%');
%   xlabel('Time'), ylabel('Wav Intensity');


  alignedTemplate = template(leftIndx+1:rightIndx+1);
  %alignedSignal   = subSignal(leftIndx+1:rightIndx+1);
  alignedSignal = subSignal;
  alignedSignal(1:leftIndx) = 0;
  alignedSignal(rightIndx:end) = 0;

end


