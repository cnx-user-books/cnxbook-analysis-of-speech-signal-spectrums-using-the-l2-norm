
function [ numSeg ] = getNumSegment( numSig, currentSig )

  sNumSig = size( numSig );
  sCurrentSig = size( currentSig );

  if sNumSig(2) ~= sCurrentSig(2)
    error('Incorrect inputs to getNumSegment');
  end

  xCorrSig = normxcorr2( numSig, currentSig );

  maxSpot = max( xCorrSig );
  currentSig = currentSig(maxSpot-sNumSig(2)-sNumSig(2)/2 : maxSpot-sNumSig(2)/2 );
    % sNumSig(2)/2 used to slide the index to the correct spot in the currentSig

  lastNMI = normMutualInfo( normSig, currentsig );

  for i=0 : sNumSig(2)/100 : maxSpot/2
    nmi = normMutualInfo( normSig(i+1:end), currentSig(i+1:end) )
    if nmi < lastNMI
      break;
    else
      lastNMI = nmi;
    end
  end
  end

end


