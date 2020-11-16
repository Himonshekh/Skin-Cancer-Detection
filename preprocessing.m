clc;  % Clear command window.
clear;  % Delete all variables.
clearvars;
close all;  % Close all figure windows except those created by imtool.
imtool close all;  % Close all figure windows created by imtool.
workspace;  % Make sure the workspace panel is showing.
fontSize = 15;
% Read in a standard MATLAB demo image.
folder = fullfile(matlabroot, 'H:\0.PUST\Thesis');
baseFileName = '3.jpg';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
  % Didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
original = imread(fullFileName);
grayImage=rgb2gray(original);
%[rows columns numberOfColorBands] = size(grayImage);
subplot(2, 2, 1);
imshow(grayImage);
title('Original Gray Scale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Position', get(0,'Screensize')); 


% Generate a noisy image with salt and pepper noise.
noisyImage = imnoise(grayImage,'salt & pepper', 0.05);
subplot(2, 2, 2);
imshow(noisyImage);
title('Image with Salt and Pepper Noise', 'FontSize', fontSize);


% Median Filter the image:
medianFilteredImage = medfilt2(noisyImage, [3 3]);
% Find the noise.  It will have a gray level of either 0 or 255.
noiseImage = (noisyImage == 0 | noisyImage == 255);
% Get rid of the noise by replacing with median.
noiseFreeImage = noisyImage; % Initialize
noiseFreeImage(noiseImage) = medianFilteredImage(noiseImage); % Replace.
% Display the image.
subplot(2, 2, 3);
imshow(noiseFreeImage);
title('Restored Image', 'FontSize', fontSize);

enhanced=histeq(noiseFreeImage);
subplot(2, 2, 4);
imshow(enhanced);
title('contrast Image', 'FontSize', fontSize);


ab=enhanced;
%ab = double(enhanced);
[rows, columns, numberOfColorChannels] = size(ab);
ab = reshape(ab, rows*columns, numberOfColorChannels);
%nrows = size(ab,1);
%ncols = size(ab,2);

%ab = reshape(ab,nrows*ncols,1);

nColors = 8;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', 'Replicates', 3);

pixel_labels = reshape(cluster_idx,rows,columns);
figure;
imshow(pixel_labels,[]);

%%function feature extraction using dwt

%%funciton image classification and result
