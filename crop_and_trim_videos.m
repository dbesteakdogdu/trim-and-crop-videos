%plz credit- Deniz Beste Akdogdu mailto:dbesteakdogdu@gmail.com 09.2020
clear all; close all; clc;
y1=[]; %struct of y coordinates to crop the videos
y2=[];
f1=[]; %struct of video frames to trim the videos (in this case, frame rate is 60 per sec, so required frame=60*second
f2=[];
%read video info from excel
a = xlsread('video_info.xlsx','(B2:F9)');  % Load the video information data,
[~,txtData]  = xlsread('video_info.xlsx','A2:A9'); %reads the strings in the first column of the excel (a)
for j=2:(length(txtData)+1)
    y1=  a(:,2);  % takes the 2nd column from the described excel borders (a)
    y2 = a(:,3);
    f1 = a(:,4);
    f2 = a(:,5);
end

rootPath = 'project/path/';
videosPathToBeEdited = rootPath + 'videos/path';
editedVideosDirName = 'editedVideosDirName';
editedVideosPath = rootPath + editedVideosDirname;

%directory of the videos to be edited
videos =dir(videosPathToBeEdited);
%create a new folder for the edited result videos
mkdir (rootPath, editedVideosDirName);
%set path to the new created folder
cd editedVideosPath
%edit and save (cropped and trimmed) the videos to this folder
i=1;
for k=3:length(videos)
    vidName = videos(k).name;
    v = VideoReader(vidName);
    trimVideo = VideoWriter(strcat(vidName, '_trimmed'),'MPEG-4'); %name the new video
    trimVideo.FrameRate = 60; %making sure the frame rate is same as the original video
    open(trimVideo);
    %Read and write each frame.
    for f=f1(i):f2(i) %insert start and end frames to trim
        vidFrames = read(v,f);
        cropped=imcrop(vidFrames,[0 y1(i) 1080 y2(i)]); %crop video borders
        writeVideo(trimVideo,cropped);
    end
    close(trimVideo);
    i=i+1;
    
end




