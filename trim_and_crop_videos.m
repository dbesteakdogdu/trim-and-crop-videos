%% Deniz Beste Akdogdu
%% dbesteakdogdu@gmail.com

clear all; close all; clc;
y1=[]; % y coordinates to crop the videos
y2=[];
f1=[]; % video frames to trim the videos (if frame rate is 60 per sec, required frame is calculated as 60*second)
f2=[];
%read video info from excel
[num,txt,data] = xlsread('video_info.xlsx');

% takes the columns of the corresponding parameters from the excel file
for j=1:length(txt)
    y1 = data(:,2);
    y2 = data(:,3);
    f1 = data(:,4);
    f2 = data(:,5);
end

rootPath = 'root/path';
videosPathToBeEdited = 'videos/path/to/be/edited';
editedVideosFolderPath = 'edited/videos/folder/path';

videos = dir(videosPathToBeEdited);
cd(fullfile(editedVideosFolderPath));

j=2;
% Reads raw videos; trims, crops and saves it to a new video file
for k=3:length(videos)
    vidName = videos(k).name;
    vidPath = strcat(videosPathToBeEdited, vidName);
    
    v = VideoReader(vidPath);
    
    newVideoFile = VideoWriter(strcat(strrep(vidName,'.avi', ''), '_edited'),'MPEG-4'); 
    newVideoFile.FrameRate = 60; %making sure the frame rate is same as the original video
    open(newVideoFile);
    
    %Read and write each frame.
    for f=cell2mat(f1(j)):cell2mat(f2(j)) %insert start and end frames to trim
        vidFrames = read(v, f);
        cropped=imcrop(vidFrames,[0 cell2mat(y1(j)) 1080 cell2mat(y2(j))]); % crop video borders
        writeVideo(newVideoFile,cropped);
    end
    close(newVideoFile);
    j=j+1;
end
