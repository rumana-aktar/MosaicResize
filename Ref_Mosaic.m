%%%% This program takes mosaic as input, take two points and removes extra black region
%%%% around it; 
%%%% input: mosaic sequence with extra black region
%%%% output: mosaic sequence without extra black region
%%%% for tape1_6, blending type: REP-1,2,5,6,7,8,9,10,12, ADD-3,4,11

clc;
clear all;
warning off;

%input and output directory
dirname='/D/Fall18/TEST_DATA/Test_ShotDetection/REF_Mosaic/shot6/';
dirnameOut='/D/Fall18/TEST_DATA/Test_ShotDetection/REF_Mosaic/shot6_REFM';
if (~isdir(dirnameOut))
    mkdir(dirnameOut);
end

%check if you have enough images
files = dir(fullfile(dirname,'*.png'));
if( size(files,1) < 2 )
    disp('at least two images with appropriate format in the directory');
    return;
end;








param.paddingsize = 1/3;%1/3;
I1 = imread(fullfile(dirname, files(1).name));
[M, N, ch] = size(I1);
hPad=floor(M*param.paddingsize); 
wPad=floor(N*param.paddingsize);

Iwp_color=zeros(M+2*hPad, N+2*wPad,3);

param.trim_up=3;
param.trim_down=3;
param.trim_left=13;
param.trim_right=11;


%add the path of other code files
addpath(genpath('./libraries'));
addpath(genpath('./RegistrationPart1'));
REF_List=dlmread('/D/NGA/Output1.3/VIRAT2_8/Files/Homographies/6_ReferenceList.txt'); 
Cur_to_Ref_List=dlmread('/D/NGA/Output1.3/VIRAT2_8/Files/Homographies/6_Cur_to_Ref.txt'); 
REF_List=REF_List-REF_List(1,1)+1;    
    


i=1;
while (i<=size(files,1)) %400
    
    i

    % Get the next image
    I2 = imread( fullfile(dirname, files(i).name) );
    I2_color=I2(param.trim_up:size(I2,1)-param.trim_down,param.trim_left:size(I2,2)-param.trim_right,:);
    Ap=[Cur_to_Ref_List(i, 1:3);Cur_to_Ref_List(i, 4:6);Cur_to_Ref_List(i, 7:9)];
     
    %preparing imtranform
    tProj=maketform('projective', Ap);    
    black = 0;
    I22=ones(size(I2_color(:,:,1)));
    R = makeresampler({'cubic','nearest'},'bound');
    
    %for transforming color_image
    [Ir_color, newX, newY] = imtransform(I2_color,tProj,R,'FillValues',black);
    
    %I22 is for generating mask
    %[mask1, newX1, newY1] = imtransform(I22,tProj, R,'FillValues',black);
   
      
    x=round(newX(1));
    y=round(newY(1));
    
    [M1, N1, ~]=size(Ir_color);       
    
    
    %update Iwp_color and Iwp2 for frames and masks
    Iwp_color(:,:,:)=0;
    Iwp_color(hPad+1+y:M1+hPad+y, wPad+1+x:N1+wPad+x,:)=Ir_color;
        
		
		
		%write the current mask
		%fname=sprintf('%s%s',dirnameOut,files(i).name);
		fname_wpath=fullfile(dirnameOut,files(i).name);
		imwrite(uint8(Iwp_color),fname_wpath);          
			
        %keep the counts
		%frame_count=frame_count+1;
        i=i+1;
	end

