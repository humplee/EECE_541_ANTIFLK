function ImgOut = ClipImageAndWarn(ImgInp, LowestValue, HighestValues, Filename)
%ClipImageAndWarn - Clip image from weird values and warn about it
%
% Syntax:  ClipImageAndWarn(ImgInp, LowestValue, HighestValues, Filename)
%
% Inputs:
%    -ImgInp: Input image
%    -LowestValue: lowest value considered before clipping
%    -HighestValues: highest value considered before clipping
%    -Filename: name of the file calling this function
%
% Outputs:
%    -ImgOut: clipped image
%
% Example:
%    ImgOut = ClipImageAndWarn(Img, LowestValue, HighestValues, mfilename())
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
% Created: 16-Nov-2016; Last revision: 16-Nov-2016

%---------------------------- BEGIN CODE ----------------------------------
ImgOut = ImgInp;
%Remove values that can have issues
Idx=find(isnan(ImgInp)|isinf(ImgInp));
if Idx
    ImgOut(Idx) = HighestValues;
    Mge = [num2str(length(Idx)) ' NaN or Inf values found and replaced by '             num2str(HighestValues) ' during ' Filename];
    warning(Mge);
end
Idx = find(ImgInp > HighestValues);
if Idx
    ImgOut(Idx) = HighestValues;
    Mge = [num2str(length(Idx)) ' values were above the highest value and replaced by ' num2str(HighestValues) ' during : ' Filename];
    warning(Mge);
end
Idx = find(ImgInp < LowestValue);
if Idx
    ImgOut(Idx) = LowestValue;
    Mge = [num2str(length(Idx)) ' values were below the lowest value ' num2str(LowestValue) ' in image during : ' Filename];
    warning(Mge);
end
end
%--------------------------- END OF CODE ----------------------------------
% Header generated using two templates:
% - 4908-m-file-header-template
% - 27865-creating-function-files-with-a-header-template