function ImgOut = ConvertGamutRGB1(ImgIn, InputGamut, OutputGamut, MPEG)
%RGB2YCbCr - convert from one gamut to another
%
% Syntax:  ImgOut = ConvertGamutRGB(ImgIn, InputGamut, OutputGamut)
%
% Inputs:
%    -ImgIn: RGB input image in container InputGamut
%    -InputGamut: gamut of the source
%    -OutputGamut: targetted gamut
%    -MPEG: use the MPEG approximate matrix
%
% Outputs:
%    -ImgOut: output imagein targetted container
%
% Example:
%    ImgOut = ConvertGamutRGB(ImgIn, 'BT.709', 'BT.2020', true)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: 
% References:
%    -International Telecommunication Union, “Parameter Values for the HDTV
%    Standard for Production and International Programme Exchange,” in
%    Recommendation ITU-R BT.709, 1998.
%    -International Telecommunication Union, “Parameter values for
%    ultra-high definition television systems for production and
%    international programme exchange,” in Recommendation ITU-R BT.2020,
%    2012.
%    -Society of Motion Picture & Television Engineers, RP 431-2:2011 :
%    D-Cinema Quality — Reference Projector and Environment, vol. 10607,
%    no. 914. The Society of Motion Picture and Television Engineers, 2011.
%    -A. Luthra, E. Francois, and W. Husak, “Call for Evidence (CfE) for
%    HDR and WCG Video Coding,” in ISO/IEC JTC1/SC29/WG11 MPEG2014/N15083,
%    2015.
%
% Author: Ronan Boitard
% University of British Columbia, Vancouver, Canada
% email: rboitard.w@gmail.com
% Website: http://http://www.ece.ubc.ca/~rboitard/
% Created: 15-Mar-2012; Last revision: 26-Oct-2015

%---------------------------- BEGIN CODE ----------------------------------
if MPEG
    if strcmp(InputGamut, 'BT.709')
        switch OutputGamut
            case 'BT.2020'
                ImgOut(:,:,1) = ClipImage( 0.627404078626 * ImgIn(:,:,1) + 0.329282097415 * ImgIn(:,:,2) + 0.043313797587 * ImgIn(:,:,3), 0, 1);
                ImgOut(:,:,2) = ClipImage( 0.069097233123 * ImgIn(:,:,1) + 0.919541035593 * ImgIn(:,:,2) + 0.011361189924 * ImgIn(:,:,3), 0, 1);
                ImgOut(:,:,3) = ClipImage( 0.016391587664 * ImgIn(:,:,1) + 0.088013255546 * ImgIn(:,:,2) + 0.895595009604 * ImgIn(:,:,3), 0, 1);
            case 'P3D65'
                warning('Conversion not available in the CfE conditions');
        end
    elseif strcmp(InputGamut, 'P3D65')
        switch OutputGamut
            case 'BT.2020'
%                 X = 0.486571 * ImgIn(:,:,1) + 0.265668  * ImgIn(:,:,2) + 0.198217  * ImgIn(:,:,3);
%                 Y = 0.228975  * ImgIn(:,:,1) + 0.691739  * ImgIn(:,:,2) + 0.079287  * ImgIn(:,:,3);
%                 Z = 0.000000 * ImgIn(:,:,1) + 0.045113  * ImgIn(:,:,2) + 1.043944  * ImgIn(:,:,3);
%                 
%                 ImgOut(:,:,1) = 1.716651  * X - 0.355671  * Y - 0.253366  * Z;
%                 ImgOut(:,:,2) = -0.666684  * X + 1.616481  * Y + 0.015768  * Z;
%                 ImgOut(:,:,3) = 0.017640  * X - 0.042771  * Y + 0.942103  * Z;                     
%                 
                ImgOut(:,:,1) = ClipImage( 0.753832826496 * ImgIn(:,:,1) + 0.198597635641 * ImgIn(:,:,2) + 0.047569409186 * ImgIn(:,:,3), 0, 1);
                ImgOut(:,:,2) = ClipImage( 0.045744636411 * ImgIn(:,:,1) + 0.941777687331 * ImgIn(:,:,2) + 0.012478735611 * ImgIn(:,:,3), 0, 1);
                ImgOut(:,:,3) = ClipImage(-0.001210377285 * ImgIn(:,:,1) + 0.017601107390 * ImgIn(:,:,2) + 0.983608137835 * ImgIn(:,:,3), 0, 1);
            case 'BT.709'
%                 X = 0.486571 * ImgIn(:,:,1) + 0.265668  * ImgIn(:,:,2) + 0.198217  * ImgIn(:,:,3);
%                 Y = 0.228975  * ImgIn(:,:,1) + 0.691739  * ImgIn(:,:,2) + 0.079287  * ImgIn(:,:,3);
%                 Z = 0.000000 * ImgIn(:,:,1) + 0.045113  * ImgIn(:,:,2) + 1.043944  * ImgIn(:,:,3);             
                
                ImgOut(:,:,1) = ClipImage( 0.627404078626 * ImgIn(:,:,1) + 0.329282097415 * ImgIn(:,:,2) + 0.011361189924 * ImgIn(:,:,3), 0, 1);
                ImgOut(:,:,2) = ClipImage( 0.069097233123 * ImgIn(:,:,1) + 0.919541035593 * ImgIn(:,:,2) + 0.011361189924 * ImgIn(:,:,3), 0, 1);
                ImgOut(:,:,3) = ClipImage( 0.016391587664 * ImgIn(:,:,1) + 0.088013255546 * ImgIn(:,:,2) + 0.895595009604 * ImgIn(:,:,3), 0, 1);
        end
    elseif strcmp(InputGamut, 'BT.2020')
        switch OutputGamut
            case 'BT.709'
                % 2020 to XYZ
%                 X = 0.636958 * ImgIn(:,:,1) + 0.144617 * ImgIn(:,:,2) + 0.168881 * ImgIn(:,:,3);
%                 Y = 0.262700 * ImgIn(:,:,1) + 0.677998 * ImgIn(:,:,2) + 0.059302 * ImgIn(:,:,3);
%                 Z = 0.000000 * ImgIn(:,:,1) + 0.028073 * ImgIn(:,:,2) + 1.060985 * ImgIn(:,:,3);
%                 
%                 %from XYZ to 709
%                 ImgOut(:,:,1) = 3.240970 * X - 1.537383 * Y - 0.498611 * Z;
%                 ImgOut(:,:,2) = -0.969244 * X + 1.875968 * Y + 0.041555 * Z;
%                 ImgOut(:,:,3) = 0.055630 * X - 0.203977 * Y + 1.056972 * Z;

                ImgOut(:,:,1) = ClipImage( 1.660490254890140 * ImgIn(:,:,1) + -0.587638564717282 * ImgIn(:,:,2) + -0.072851975229213 * ImgIn(:,:,3), 0, 1);
                ImgOut(:,:,2) = ClipImage( -0.124550248621850 * ImgIn(:,:,1) + 1.132898753013895 * ImgIn(:,:,2) + -0.008347895599309 * ImgIn(:,:,3), 0, 1);
                ImgOut(:,:,3) = ClipImage( -0.018151059958635 * ImgIn(:,:,1) + -0.100578696221493 * ImgIn(:,:,2) + 1.118729865913540 * ImgIn(:,:,3), 0, 1);

                
                
            case 'P3D65'
                warning('Conversion not available in the CfE conditions');
        end
    end
else
    ImgOut = RGB2XYZ(ImgIn , true , InputGamut);
    ImgOut = RGB2XYZ(ImgOut, false, OutputGamut);
end
end
%--------------------------- END OF CODE ----------------------------------
% Header generated using two templates:
% - 4908-m-file-header-template
% - 27865-creating-function-files-with-a-header-template
