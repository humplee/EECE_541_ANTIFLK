function SDRFrame=ToneMapping(HDRFrame, BitsPerPixel)

 
 minLum=0.01;
%  maxLum=1000;
 Ldmin=0.1;
 Ldmax=100;
 nBin=256;
 P = 0.70;
 
 
 
%exr
% img=exrread(FileName);


%tiff
% img = imread(HDRFrame);
img=HDRFrame;
img=double(img)./(2^(BitsPerPixel/3)-1);
img(img>=0)=img(img>=0)+0.0001;
img=SMPTE_ST_2084(img,false,10000);


% extract luminance
luminance=0.2627 * img(:,:,1) + 0.6780 * img(:,:,2) + 0.0593 * img(:,:,3);

% set max allowed values
minLum=minLum-0.001;
%maxLum=max(luminance(:))+10;
maxLum=1000;
% make sure that all values of luminance is on the desired range
luminance(luminance>maxLum)=maxLum;
luminance(luminance<minLum)=minLum;

% find the limit values for the 2 domains (HDR, SDR) on PQ space
PQLdMax=SMPTE_ST_2084(Ldmax,true,10000);
PQLdMin=SMPTE_ST_2084(Ldmin,true,10000);
PQLMax = SMPTE_ST_2084(maxLum,true,10000);
PQLMin = SMPTE_ST_2084(minLum,true,10000);

% define the histogram bins
edges = linspace(PQLMin,PQLMax,nBin);

% tranform the linear luminance valus to PQ values for the entire image
PqLum=SMPTE_ST_2084(luminance,true,10000);

%calculate the histogram of the image
freq=histcounts(PqLum,edges);

% calculate the curve 
curve=CurveComputation(freq,Ldmax,Ldmin,edges,PQLdMax,PQLdMin);   


% apply the curve to the luminance of the  entire image by interpolating it
Ld2=interp1(edges,curve,PqLum, 'linear'); 
Ld2 = SMPTE_ST_2084(Ld2,false,10000);    
Ld2(Ld2<Ldmin)=Ldmin;
Ld2(Ld2>Ldmax)=Ldmax;


% update color of the image with the new luminance  (You are not interesting in that)
Ld2=(Ld2-Ldmin)./(Ldmax-Ldmin);
imgOut2=zeros(size(img));  
imgOut2(:,:,1) = Ld2.* ((img(:,:,1) ./  luminance).^ P) ;
imgOut2(:,:,2) = Ld2.* ((img(:,:,2) ./  luminance).^ P) ;
imgOut2(:,:,3) = Ld2.* ((img(:,:,3) ./  luminance).^ P) ;


imgOut2(imgOut2>1)=1;
imgOut2(imgOut2<0)=0;
% convert 2020 to 709 (You are not interesting in that)
imgOut2 = ConvertGamutRGB1(imgOut2, 'BT.2020', 'BT.709', true); 
imgOut2(imgOut2>1)=1;
imgOut2(imgOut2<0)=0;
% apply Gamma (You are not interesting in that)
imgOut2 = GammaTMO(imgOut2,2.2);
% imshow(imgOut2);
% 
SDRFrame=imgOut2;
end
