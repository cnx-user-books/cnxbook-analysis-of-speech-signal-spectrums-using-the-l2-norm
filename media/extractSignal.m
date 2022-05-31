
function [signal] = extractSignal( data, energyThresh )
  % Find the indices such that the energy in the extracted portion of
  % data is greater than a threshold
  totalEnergy = sum( data.^2 );

  sData = size( data );

  smoothedData = smooth( abs(data), 30 );
  [maxVlu, maxIndx] = max( smoothedData );
  maxIndx = maxIndx - 1;  % convert to 0 based index

  leftIndx = maxIndx-1;
  rightIndx = maxIndx+1;

  energy = sum( data(leftIndx+1:rightIndx+1).^2 );

  while( energy < energyThresh*totalEnergy )
    if leftIndx > 1 && rightIndx < sData(2)-1
      if abs(smoothedData(leftIndx-1)) > abs(smoothedData(rightIndx+1))
        leftIndx = leftIndx - 1;
      else
        rightIndx = rightIndx + 1;
      end
    elseif leftIndx > 1
      leftIndx = leftIndx - 1;
    else
      rightIndx = rightIndx + 1;
    end
    energy = sum( data(leftIndx+1:rightIndx+1).^2 );
  end

  signal = data( leftIndx+1 : rightIndx+1 );
end

