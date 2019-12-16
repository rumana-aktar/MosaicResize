%%%% This program takes mosaic as input, take two points and removes extra black region
%%%% around it; 
%%%% input: mosaic sequence with extra black region
%%%% output: mosaic sequence without extra black region
%%%% for tape1_6, blending type: REP-1,2,5,6,7,8,9,10,12, ADD-3,4,11

clc;
clear all;
warning off;

dirname='/Volumes/F/Comparison_CUDA_NCC/Files/BlockCoord_TestCase2_Lewis/NCC/Files/Image';
dirnameOut='/Volumes/F/Comparison_CUDA_NCC/Files/BlockCoord_TestCase2_Lewis/NCC/Files/Image2/';
if (~isdir(dirnameOut))
    mkdir(dirnameOut);
end

%
% Extend name with 6 digit number format
%check if you have enough images
files = dir(fullfile(dirname,'Ref*.png'));
if( size(files,1) < 2 )
    disp('at least two images with appropriate format in the directory');
    return;
end;


%% read all image and find maxM and maxN    
i=1; maxM=0; maxN=0;
while (i<=size(files,1))
    i
    
    I1 = imread(fullfile(dirname, files(i).name));
    [m,n,~]=size(I1);
    
    if m>maxM; maxM=m; end;    
    if n>maxN; maxN=n; end;
    
    i=i+1;
end


%% read all image resize to maxM and maxN  
i=1; 
while (i<=size(files,1))
    i
    
    I1 = imread(fullfile(dirname, files(i).name));
    [m,n,~]=size(I1);
    
    I1(m+1:maxM,:)=255;I1(:, n+1:maxN)=255;
    
    fname=files(i).name;
    fname_wpath=fullfile(dirnameOut,fname);
    imwrite(I1,fname_wpath);  
    i=i+1;
end
