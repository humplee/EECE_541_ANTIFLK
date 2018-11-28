close all; 
clear all;

global curvebuffer;
curvebuffer=zeros(256);
tiffname='D:\Content\img\';
outVideo='D:\Content\finaltestX.yuv';


filenamecounter=1;
while (true)
    v=imread(['D:\Content\img\',num2str(filenamecounter),'.tif']);
    filenamecounter=filenamecounter+1;       
    SDR=ToneMapping(v,48);
    
    Video_name=outVideo;
    ybr=RGB2YCbCr(SDR,1,'BT.709',false);
    %scale to 10 bits
    ybr_10=ScaleImage2BitDepth(ybr, true, true, 8, 'YCbCr');
    %downsamble chroma to 4:2:0
    [chr1, chr2]=ChromaDownSampling(ybr_10,'420','MPEG');
    %take the luminance
    lumch=ybr_10(:,:,1);
%     lumch = imsharpen(lumch,'Amount',0.8,'Threshold',0);
    WriteFramePlanar(lumch, chr1, chr2, Video_name, 2, 8);         
    if filenamecounter >23
        break;
    end
    
    

    
end

