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
% 7. Gabor Filter

%% 1.Original Image
file_name = 'Lenna.png';
temp_image = imread(file_name);
figure(1)
imshow(temp_image)
image = im2double(temp_image);

% Convert all the white pixels to black
file_name = 'Test_Image.jpg';
temp_image = imread(file_name);
image = im2double(temp_image);

for i = 1:1200
    for j = 1:1200
        if ((image(i,j,1)==1)&&(image(i,j,2)==1)&&(image(i,j,3)==1))
            image(i,j,1) = 0;
            image(i,j,2) = 0;
            image(i,j,3) = 0;
        end
    end
end

figure(2)
imshow(image)

%% 2. Spatial Lowpass
h = figure(3);
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
h = figure(4);
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
h = figure(5);
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

%% 7. Gabor Filter
%sigma = ;
%theta = ;
%lambda = ;
%psi = ;
%gamma = ;

sigma_x = sigma;
sigma_y = sigma/gamma;

% Bounding box
nstds = 3;
xmax = max(abs(nstds*sigma_x*cos(theta)),abs(nstds*sigma_y*sin(theta)));
xmax = ceil(max(1,xmax));
ymax = max(abs(nstds*sigma_x*sin(theta)),abs(nstds*sigma_y*cos(theta)));
ymax = ceil(max(1,ymax));
xmin = -xmax; ymin = -ymax;
[x,y] = meshgrid(xmin:xmax,ymin:ymax);

% Rotation 
x_theta=x*cos(theta)+y*sin(theta);
y_theta=-x*sin(theta)+y*cos(theta);

gb = exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/lambda*x_theta+psi);

