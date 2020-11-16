
brainImg = imread('1.jpg');

%% preprocessing
[m n c] = size(brainImg);
brainImg  = rgb2gray(brainImg);
subplot(232);imshow(brainImg);title('preprocessed image','FontSize',20);
%% Convert To Binary
img2 = im2bw(brainImg);
%% Feature Extraction
signal1 = img2(:,:);
    [cA1,cH1,cV1,cD1] = dwt2(signal1,'db4');
    [cA2,cH2,cV2,cD2] = dwt2(cA1,'db4');
    [cA3,cH3,cV3,cD3] = dwt2(cA2,'db4');

    DWT_feat = [cA3,cH3,cV3,cD3];
    G = pca(DWT_feat);
    whos DWT_feat
    whos G
    g = graycomatrix(G);
    stats = graycoprops(g,'Contrast Correlation Energy Homogeneity');
    Contrast = stats.Contrast;
    Correlation = stats.Correlation;
    Energy = stats.Energy;
    Homogeneity = stats.Homogeneity;
    Mean = mean2(G);
    Standard_Deviation = std2(G);
    Entropy = entropy(G);
    RMS = mean2(rms(G));
    %Skewness = skewness(img)
    Variance = mean2(var(double(G)));
    a = sum(double(G(:)));
    Smoothness = 1-(1/(1+a));
    Kurtosis = kurtosis(double(G(:)));
    Skewness = skewness(double(G(:)));