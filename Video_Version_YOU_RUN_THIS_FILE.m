close all; 
clear all;

global curvebuffer;
curvebuffer=zeros(256);
filename='D:\Content\LG.ts';

outVideo='D:\Content\testsecondround3.yuv';

v = VideoReader(filename),'RGB48';
counter=0;
while (hasFrame(v))
    
    counter=counter+1;
    nextFrame = readFrame(v);
    if counter <86
        continue;
    end
    SDR=ToneMapping(nextFrame,v.BitsPerPixel);
    
    
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
    
    
    

    
end

