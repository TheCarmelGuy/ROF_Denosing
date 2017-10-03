% % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% PROBLEM SET 1
% ROF MODEL EQUATION  
% Author: Komel Merchant
% % % % % % % % % % % % % % % % % % % % % % % % % % % % 

clc; clear all;

% % --------------
% % SOME VARIABLES
% % --------------
close all; clear all; clc;

f = imread('cameraman.tif');
f = imnoise(f,'gaussian', 0, 0.05);
f = double(f)./255;
[rows, cols] = size(f);

alpha = 3;
N =30; % Number of iterations
lambda = 0.09;                                                                                                    
epsilon = 0.0001;


u = zeros(rows, cols); % initiate u as a 0 matrix
grad_norm_u = zeros(rows, cols);
div_grad_u = zeros(rows, cols);


for k = 1:N 

    % VALUES FOR PREVIOUS
    % -------------------
    
    dux = Dx(u);
    duy = Dy(u);
    
   
%     COMPUTE div(grad_u) / |grad_u|
    grad_norm_u = sqrt((dux.^2) + (duy.^2));      % magnatude of gradient 
    grad_norm_u(grad_norm_u ==0)=epsilon;      % make sure that theres no divide by 0
    
    div_grad_u = (Dx(dux) + Dy(duy));         
    tot_v = div_grad_u./grad_norm_u;
    
    

%   -(div(grad_u)/|grad_u|) - lambda*(f - u)
    grad_E = -(f-u)+(lambda).*tot_v;

 
    % UPDATE U VALES 
    % --------------
    u = u - (alpha.*grad_E);
       
    % CHECK ENERGY FUNCTION
    % ---------------------
   
    
    % COMPUTE  ||f - u||^2 
    % -----------------------
    dfit = (f-u).^2;
  
    dfit_sum = sum(dfit(:));
    dfit_sum = (1/2).*sqrt(dfit_sum); %isnt this number already a scalar (why sum up all)

    
%    COMPUTE integral(| grad_u |) 

%    current differential after update
    dux2 = Dx(u);
    duy2 = Dy(u);
    
%   Compute tv sum
    tv_u = sqrt(dux2.^2 + duy2.^2);
    tv_u_sum= lambda.*sum(tv_u(:));  
    
    
    E_res(k) = dfit_sum + tv_u_sum;
     
end

% PLOT RESULTS
% ------------

plot(E_res);title('Convergence Graph');

figure();
u(u<0) = 0;
imshow(u)
% ;title('Restored Image');

figure();
imshow(f);title('Original Image');
