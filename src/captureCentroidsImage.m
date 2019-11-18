function I = captureCentroidsImage( I )
    
    [H, S, V]= rgb2hsv(I);

    %working with the saturation matrix
    S = imbinarize( S, 0.50 );
    se = strel('disk', 2);
    S = imopen( S, se );
    %se = strel('disk', 3);
    %S = imclose( S, se );

    %working with the V matrix
    V = imcomplement(V);
    V = imbinarize( V, 0.60 );
    V = imclose( V, se );
    se = strel('disk', 10);
    V = imopen( V, se );
    V = imclearborder( V );
    
    %Merging both images
    Img = S + V;
    Img = imbinarize(Img);
    se = strel('disk', 5);
    Img = imopen( Img, se );

    %Getting the centroids of the different objects
    s = regionprops( Img,'centroid' );
    centroids = cat( 1,s.Centroid );
    NCentroids = size(centroids);
    NCentroids = NCentroids(1);
    for i = 1:NCentroids
       I = insertShape(I,'Circle', [centroids(i,:), 2],'LineWidth',5,'Color','blue'); 
    end
    
end