%simple function in order to normalize the histogram of the input image

function i_normalized = normalize_image(i)
    %Normalizing the image:
    Min = min( min( i ) );
    Max = max( max( i ) );
    i_normalized = uint8( double( i - Min ) / double( Max - Min ) * 255 );
end


