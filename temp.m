% Temperature variation using Kalman Filter
%
% System Model
% x_est+ = x_est + K*(x_mea-x_est)
% y  = x_est + v
% 

clear; clc;

dt = 1;

x_est = 70;
e_est = 3;
e_mea = 3;
x_true = 75;
k = 1;

% Temperature measurement calculation
x_mea = randi([70, 80], 1, 51);

tt = 0:dt:50;

% Saving all instances of previous calculations
XX = zeros(1, size(tt,2));
X_est = zeros(1, size(tt,2));
K = zeros(1, size(tt,2));
E_est = zeros(1, size(tt,2));

% start loop
i = 1;
for t = tt

    % Predict-ipdate 
    k = e_est/(e_est + e_mea);
    x_est = x_est + k* (x_mea(i)-x_est);
    e_est = (1-k)*e_est ;
    
    % collect data
    X_est(:,i) = x_est;
    K(:,i) = k;
    E_est(:,i) = e_est;
    XX(:,i) = x_true;

    % update index
    i = i + 1;
end

% plot
subplot(2,1,1)
plot(tt,XX,'r',tt,X_est,'b');
axis([0 50 70 80]);
legend('truth','estimate');
title('Estimation with respect time variation');

subplot(2,1,2)
plot(tt,K,'r',tt,E_est,'b');
legend('Kalman Gain','Error in Estimation');
title('Error in estimation with respect time variation');

