
function classTutorial

  file1 = 'C:\Users\nicholas\Documents\My Stuff\My School\CSUN\Math480\project\recordings\person\nicholas\two1.wav';
  file2 = 'C:\Users\nicholas\Documents\My Stuff\My School\CSUN\Math480\project\recordings\person\nicholas\two2.wav';

  [data1, fsPin, nBitsPin] = wavread( file1 );  data1 = data1'; 
  [data2, fsPin, nBitsPin] = wavread( file2 );  data2 = data2'; 

  norm1 = norm(data1);
  norm2 = norm(data2);

  %specgram(data1);
  
  diff12 = data1 - data2;
  normDiff12 = norm( diff12 );

  data3 = data1 * 5;
  diff13 = data1 - data3;
  

  disp('Stop here');
end


