function ImgOut = ClipImage(ImgIn, Min, Max)
%ClipImage - Scale an image to the targetted bit-depth
%
% Syntax:  ImgOut = ClipImage(ImgIn, Min, Max)
%
% Inputs:
%    -ImgIn: input image
%    -Min: minimum value
%    -Max: maximum value
%
% Outputs:
%    -ImgOut: output image
%
% Example:
%    ImgOut = ClipImage(ImgIn, 0, 1)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: 
% References:
%
% Author: Ronan Boitard
% University of British Columbia, Vancouver, Canada
% email: rboitard.w@gmail.com
% Website: http://http://www.ece.ubc.ca/~rboitard/
% Created: 15-Mar-2012; Last revision: 26-Oct-2015

%---------------------------- BEGIN CODE ----------------------------------
ImgOut = ImgIn;
ImgOut(ImgIn > Max) = Max;
ImgOut(ImgIn < Min) = Min;
end
%--------------------------- END OF CODE ----------------------------------
% Header generated using two templates:
% - 4908-m-file-header-template
% - 27865-creating-function-files-with-a-header-template