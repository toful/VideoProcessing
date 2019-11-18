
%Loading the video and getting the number of frames
video = VideoReader('data/Robot_pushing red ball.avi');
NFrames = video.NumberOfFrames;

new_video = VideoWriter('result/result.avi'); %create the video object
open(new_video); %open the file for writing
for i = 1:NFrames
    fprintf("Processing frame %d/%d\n", i, NFrames);
    %Read each frame
    I = readFrame(video);
    Img = I(:,:,3);
    %Get the image with the centroids
    I = captureCentroidsImage( I );
    %I = captureCentroidsImage_V2( I, Img );
    %Add image to the new video
    writeVideo( new_video, I ); %write the image to file
end

%close(video);
close(new_video);