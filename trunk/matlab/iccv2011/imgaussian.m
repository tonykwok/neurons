function I=imgaussian(I,sigma,hsize)
% IMGAUSSIAN filters an 1D, 2D color/greyscale or 3D image with an 
% Gaussian filter. This function uses for filtering IMFILTER or if 
% compiled the fast  mex code imgaussian.c . Instead of using a 
% multidimensional gaussian kernel, it uses the fact that a Gaussian 
% filter can be separated in 1D gaussian kernels.
%
% J=IMGAUSSIAN(I,SIGMA,SIZE)
%
% inputs,
%   I: The 1D, 2D greyscale/color, or 3D input image with 
%           data type Single or Double
%   SIGMA: The sigma used for the Gaussian kernel
%   SIZE: Kernel size (single value) (default: sigma*6)
% 
% outputs,
%   J: The gaussian filtered image
%
% note, compile the code with: mex imgaussian.c -v
%
% example,
%   I = im2double(imread('peppers.png'));
%   figure, imshow(imgaussian(I,10));
% 
% Function is written by D.Kroon University of Twente (September 2009)

%cls = class(I);
I = double(I);
if sigma <= .5
    hsize = [3 3];
else
    hsize = [round(5*sigma + 1) 1];
end
H = fspecial('gaussian',hsize, sigma);

%keyboard;

if(ndims(I)==1)
    I = imfilter(I,H,'same', 'replicate');
    %I = imfilter(I,H,'same', 'symmetric');
elseif(ndims(I) ==2)
    Hx = H';
    Hy = H;
    %I=imfilter(imfilter(I,Hy, 'replicate', 'conv'),Hx, 'replicate', 'conv');
    %I=imfilter(imfilter(I,Hy, 'replicate'),Hx, 'replicate');
    I=imfilter(imfilter(I,Hy, 'replicate'),Hx, 'replicate');
end
