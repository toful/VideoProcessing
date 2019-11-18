%Loading the video and getting the number of frames
video = VideoReader('data/Robot_pushing red ball.avi');
NFrames = video.NumberOfFrames;

for i = 1:42
    I = readFrame(video);
end

%figure,imshow( I(:,:,1) );
%figure,imshow( I(:,:,2) );
%figure,imshow( I(:,:,3) );
[H, S, V]= rgb2hsv(I);
%figure,imshow(H);
%figure,imshow(S);
%figure,imshow(V);

%working with the saturation matrix
S = imbinarize( S, 0.50 );
%figure,imshow(S);
se = strel('disk', 2);
S = imopen( S, se );
%figure,imshow(S);

%working with the V matrix
V = imcomplement(V);
%figure,imshow(V);
V = imbinarize( V, 0.60 );
%figure,imshow(V);
V = imclose( V, se );
se = strel('disk', 10);
%figure,imshow(V);
V = imopen( V, se );
%figure,imshow(V);
V = imclearborder( V );
%figure,imshow(V);

%Merging the images
Img = S + V;
Img = imbinarize(Img);
%figure,imshow(Img);
se = strel('disk', 5);
Img = imopen( Img, se );
%figure,imshow(Img);

s = regionprops( Img, 'centroid' );
centroids = cat( 1, s.Centroid );
figure, imshow( Img );
hold on 
    plot(centroids(:,1),centroids(:,2),'b*') 
hold off

NCentroids = size(centroids);
NCentroids = NCentroids(1);
for i = 1:NCentroids
   I = insertShape(I,'Circle', [centroids(i,:), 2],'LineWidth',5,'Color','blue'); 
end
figure, imshow( I );