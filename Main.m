%%%% This program takes mosaic as input, take two points and removes extra black region
%%%% around it; 
%%%% input: mosaic sequence with extra black region
%%%% output: mosaic sequence without extra black region
%%%% for tape1_6, blending type: REP-1,2,5,6,7,8,9,10,12, ADD-3,4,11

clc;
clear all;
warning off;

%% bark, bikes, boat, graf, leuven, trees, ubc, wall

dataset='ubc';
features='SURF';

% dirname=sprintf('/Volumes/E/Oxford_dataset/Output/Files/Features/%s/MatchedFeatures', dataset);
% dirnameOut=sprintf('/Volumes/E/Oxford_dataset/Output/Files/Features/%s/MatchedFeatures/', dataset);




dirname='/Volumes/F/Courses/MesenteryData/SFM2_BIP_Output/REP_Motion';
dirnameOut=sprintf('%s/',dirname);
if (~isdir(dirnameOut))
    mkdir(dirnameOut);
end

%
% Extend name with 6 digit number format
%check if you have enough images
files = dir(fullfile(dirname,'*.png'));
if( size(files,1) < 2 )
    disp('at least two images with appropriate format in the directory');
    return;
end;% 



% i=1;
% for j=1:size(S,2)
%     i=S(j);
%     movefile(fullfile(dirname, files(i).name), fullfile(dirnameOut, files(i).name));   
%     
%     i 
%     %ExtendName(files(i).name)
%     %Name=ExtendName(files(i).name)
% %     if strcmp(Name, files(i).name)
% %     else
% %         movefile(fullfile(dirname, files(i).name),sprintf('%s',fullfile(dirname), Name));   
% %     end
%     i=i+1;
% end
% 
% 
% %check if you have enough images
% files = dir(fullfile(dirname,'*.png'));
% if( size(files,1) < 2 )
%     disp('at least two images with appropriate format in the directory');
%     return;
% end;



%open the final mosaic and select area for cut off
I1 = imread(fullfile(dirname, files(size(files,1)).name));
%I1 = imread(fullfile(dirname, files(1).name));

imshow(I1);
[x1,y1] = ginput(1)
if y1<1
    y1=1;
end
[x2,y2] = ginput(1)
x1=round(x1);y1=round(y1);x2=round(x2);y2=round(y2);

%check whether the cut is good
I2 = I1(y1:y2, x1:x2, :);
imshow(I2);

%cut off extra black region    
i=1;
while (i<=size(files,1))
    i
    
    I1 = imread(fullfile(dirname, files(i).name));
    I2 = I1(y1:y2, x1:x2, :);
    %imshow(I2);
    
    
    fname=files(i).name;
    fname_wpath=fullfile(dirnameOut,fname);
    imwrite(I2,fname_wpath);  
    i=i+1;
end

