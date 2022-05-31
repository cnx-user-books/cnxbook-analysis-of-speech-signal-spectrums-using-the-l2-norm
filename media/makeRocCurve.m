
function [pD, pFA] = makeRocCurve()

  userDirectory = './recordings/person/';
  currentDirectory = './recordings/current/';

  dirResults = dir( userDirectory );
  nDirs = length(dirResults);
  users = cell( nDirs-2 );
  for i=3:nDirs
    users{i-2} = char( dirResults(i).name ); 
  end

  pins = findAllPermutations( [0 1 2 3 4 5 6 7 8 9], 4 );
  sPins = size( pins );  nPins = sPins(1);

  startThresh=0.1;  stopThresh=1;  threshStep=0.05;

  thresh=startThresh:threshStep:stopThresh;
  nThresh = (stopThresh - startThresh) / threshStep;
  pD=zeros(1,nThresh); pFA=zeros(1,nThresh);

  nTrueMatches=0;   nTrueMatchesAttempted=0;
  nFalseMatches=0;  nFalseMatchesAttempted=0;

  for threshIndx=0:nThresh-1
    thisThresh = startThresh + (threshStep*threshIndx);

    for userIndx = 1:length(users)
      username = char( users(userIndx) );

      disp( ['User ', username, ' with thresh ', num2str(thisThresh)] );
      
      for pinIndx=1:1000:length(pins)
        disp(['Pin ', num2str(pinIndx), ' of ', num2str(length(pins))]);
        
        pin = pins(pinIndx,:);
        
        % find the probabilities of false alarm
        nTrueMatchesAttempted = nTrueMatchesAttempted + 1;
        trueMatch = voiceRecognition( username, pin, thisThresh );
        if trueMatch
          nTrueMatches = nTrueMatches + 1;
        end

        % find the probabilities of detection
        for falseUserIndx=1:length(users)
          if falseUserIndx == userIndx
            continue
          end
          falseUser = char( users(falseUserIndx) );
          nFalseMatchesAttempted = nFalseMatchesAttempted + 1;
          falseMatch = voiceRecognition( username, pin, thisThresh, falseUser );
          if falseMatch
            nFalseMatches = nFalseMatches + 1;
          end
        end

      end % pinIndx
    end %userIndx

    pD(threshIndx+1)  = 1 - (nFalseMatches / nFalseMatchesAttempted);
    pFA(threshIndx+1) = (nTrueMatchesAttempted - nTrueMatches) / nTrueMatchesAttempted;

  end %thresh

end


