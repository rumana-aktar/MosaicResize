%%%% This program takes mosaic as input, take two points and removes extra black region
%%%% around it; 
%%%% input: mosaic sequence with extra black region
%%%% output: mosaic sequence without extra black region
%%%% for tape1_6, blending type: REP-1,2,5,6,7,8,9,10,12, ADD-3,4,11

clc;
clear all;
warning off;

%% bark, bikes, boat, graf, leuven, trees, ubc, wall



dirname='/Volumes/F/Courses/MesenteryData/Sequence5_fr5_cropped/FeatureMean/Motion';
dirnameOut=sprintf('%s_Paired/', dirname);
if (~isdir(dirnameOut))
    mkdir(dirnameOut);
end

%check if you have enough images
files_xb = dir(fullfile(dirname,'XB*.png'));
if( size(files_xb,1) < 2 )
    disp('at least two images with appropriate format in the directory');
    return;
end;% 

%check if you have enough images
files_yb = dir(fullfile(dirname,'YB*.png'));
files_xa = dir(fullfile(dirname,'XA*.png'));
files_ya = dir(fullfile(dirname,'YA*.png'));




%cut off extra black region    
i=1;
while (i<=size(files_xb,1))
    i
    
    Ixb = imread(fullfile(dirname, files_xb(i).name));
    Iyb = imread(fullfile(dirname, files_yb(i).name));
    Ixa = imread(fullfile(dirname, files_xa(i).name));
    Iya = imread(fullfile(dirname, files_ya(i).name));

    Iout=[Ixb Ixa; Iyb Iya];
    
    
    fname=sprintf('AA_%06d.png', i-1);
    fname_wpath=fullfile(dirnameOut,fname);
    imwrite(Iout,fname_wpath);  
    i=i+1;
end

