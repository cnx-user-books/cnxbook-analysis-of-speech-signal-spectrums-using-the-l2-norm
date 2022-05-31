
function [ outHist ] = hist2D( sig1, sig2 )

  s1 = size( sig1 );
  s2 = size( sig2 );

  if s1(1) ~= s2(1)  ||  s1(2) ~= s2(2)
    error('Incorrect inputs to hist2D');
  end

  outHist = zeros( 256, 256);

  for i=0:s2(1)-1
    for j=0:s2(2)-1
      indx1 = round( sig1(i+1,j+1) );
      indx2 = round( sig2(i+1,j+1) );

      outHist( indx1+1, indx2+1 ) = outHist( indx1+1, indx2+1 ) + 1;
    end
  end

end

