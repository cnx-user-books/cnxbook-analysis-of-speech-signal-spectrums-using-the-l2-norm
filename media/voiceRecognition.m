
function [trueMatch] = voiceRecognition( username, pin, thresh, candidateName )
% voice Recognition accepts pin and username as input and returns whether
% or not the pin was stated by the proposed user.
%
% username is a string identifying the user (e.g. nicholas, mjaime)
% pin is an array of four strings representing the four numbers( e.g.
% ['one', 'eight', 'two', 'two']

  %%%%%%%%%%%%%%%%%%%%%%%%%
  %%% Argument Handling %%%
  %%%%%%%%%%%%%%%%%%%%%%%%%

  if nargin < 4
    candidateName = username;
  end

  if nargin < 3
    thresh = 0.48;
  end


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% Preliminary error checking %%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Check to see that 
  sPin = size(pin);
  if sPin(1) ~= 1  ||  sPin(2) ~= 4
    error('Incorrect inputs to voiceRecognition');
  end

  % verify that the username's directory exists
  userDirectory = ['./recordings/person/',username];
  if ~exist( userDirectory )
    error('User does not yet exist');
  end

  % verify that the directory of current recording exists
  currentDirectory = ['./recordings/current/',candidateName];
  if ~exist( currentDirectory )
    error('Current directory does not exist');
  end


  %%%%%%%%%%%%%%%%%%%
  %%%  Main Code  %%%
  %%%%%%%%%%%%%%%%%%%

  % Iterate over the unique values in pin
  metric = zeros( 1, length(pin) );
  
  for i=1:length(pin)
    switch pin(i)
      case 0, num = 'zero';
      case 1, num = 'one';
      case 2, num = 'two';
      case 3, num = 'three';
      case 4, num = 'four';
      case 5, num = 'five';
      case 6, num = 'six';
      case 7, num = 'seven';
      case 8, num = 'eight';
      case 9, num = 'nine';
    end

    metric(i) = compareSignals( num, currentDirectory, userDirectory );
  end

  %%%  See if the candidate is indeed the specified user  %%%
  trueMatch = 1;
  for i=1:length(metric)
    if metric(i) > thresh
      trueMatch = 0;
    end
  end

end




