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
h = figure(2);
out_file = 'Lowpass.gif';
for i = 1:0.1:15
    kernel = (1/i).*[1,1,1;1,1,1;1,1,1]; 
    new_image = convn(image, kernel);
    imshow(new_image)
    hold on
    text(10, 25, ['Kernel ratio: ',num2str(i)], 'Color', 'y', 'FontSize', 15, 'FontWeight', 'Bold', 'Interpreter', 'None');
    drawnow 
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if i == 1 
        imwrite(imind,cm,out_file,'gif', 'Loopcount',inf); 
    else 
        imwrite(imind,cm,out_file,'gif','WriteMode','append'); 
    end 
end

%% 3. Spatial Highpass
h = figure(3);
out_file = 'Highpass.gif';
for i = 1:0.1:15
    kernel = [0,-1,0;-1,i,-1;0,-1,0]; 
    new_image = convn(image, kernel);
    imshow(new_image)
    hold on
    text(10, 25, ['Kernel ratio: ',num2str(i)], 'Color', 'y', 'FontSize', 15, 'FontWeight', 'Bold', 'Interpreter', 'None');
    drawnow 
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if i == 1 
        imwrite(imind,cm,out_file,'gif', 'Loopcount',inf); 
    else 
        imwrite(imind,cm,out_file,'gif','WriteMode','append'); 
    end 
end

%% 4. Fourier Representation
h = figure(4);
out_file = 'Fourier_Rep.png';
F = fft2(image,512,512);
F2 = fftshift(F);
imshow(log(1+abs(F2)));
colormap(jet); 
colorbar
%drawnow
saveas(h,out_file);

%% 5. Fourier Lowpass

%% 6. Fourier Highpass