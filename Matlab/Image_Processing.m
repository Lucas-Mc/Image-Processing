% Lucas McCullum
% Image-Processing
clear all
clc

%% Types of Techniques Used
% 1. Original Image
% 2. Spatial Lowpass
% 3. Spatial Highpass
% 4. Fourier Representation
% 5. Fourier Lowpass
% 6. Fourier Highpass

%% 1.Original Image
file_name = 'Lenna.png';
temp_image = imread(file_name);
figure(1)
imshow(temp_image)
image = im2double(temp_image);

%% 2. Spatial Lowpass
for i = 1:0.1:15
    kernel = (1/i).*[1,1,1;1,1,1;1,1,1]; % Or whatever size window you want.
    new_image = convn(image, kernel);
    figure(2)
    imshow(new_image)
    hold on
    text(10, 25, ['Kernel ratio: ',num2str(i)], 'Color', 'y', 'FontSize', 15, 'FontWeight', 'Bold', 'Interpreter', 'None');
end

%% 3. Spatial Highpass
for i = 1:0.1:15
    kernel = [0,-1,0;-1,i,-1;0,-1,0]; % Or whatever size window you want.
    new_image = convn(image, kernel);
    figure(3)
    imshow(new_image)
    hold on
    text(10, 25, ['Kernel ratio: ',num2str(i)], 'Color', 'y', 'FontSize', 15, 'FontWeight', 'Bold', 'Interpreter', 'None');
end

%% 4. Fourier Representation
F = fft2(image,256,256);
F2 = fftshift(F);
imshow(log(1+abs(F2)));
colormap(jet); 
colorbar

%% 5. Fourier Lowpass

%% 6. Fourier Highpass