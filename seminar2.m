k = 20;
M = 100;
% SDFT Algorithm
X = zeros(1, 1000); % Initialize X vector

% Input data is a sine wave
x = zeros(1, 1000); % Initialize x vector
for n = 0:999
    x(n + 1) = sin(2 * pi * k / M * n); % 原始輸入為sin波
    % y(n + 1) = awgn(x(n + 1), 30,'measured'); % SNR值需要調到50以下，才能較清楚看見雜訊對訊號的影響
end

% sin當中的n乃經過sampling(delta(t - nT))，取樣後變為週期表示，希望週期可至1000次，也就是n = 1000

% intial by using formula1
for t = 0:900
    for m = 0:(M-1)
        X(t + 1) = X(t + 1) + x(t + m + 1) * exp(-1i * 2 * pi * m * k / M); % Accumulate value
    end
    X(t+1) = X(t+1)/M;
end

% formula2
for t = 1:900
    % substitute M = n - t
    X(n) = (X(n-1) - x(t) + x(n)) * exp(1i * 2 * pi * k / M); % Accumulate value
    X(n) = X(n)/ M; % while doing DFT, divide coeffiecient M
end

subplot(2,2,1);
plot(0:999,x);
title('input signal','FontSize', 9)

% Define complex numbers
z = X;

% Compute absolute values
abs_value = abs(z);


% Plot the absolute value graph
subplot(2,2,2);
plot(1:1000,abs_value)
title('Absolute Value of X','FontSize', 9)

% Extract real and imaginary parts
real_part = real(z);
imag_part = imag(z);

% Plot the real part graph
subplot(2,2,3);
plot(1:1000,real_part)
title('Real Part of X','FontSize', 9)

% Plot the imaginary part graph
subplot(2,2,4);
plot(1:1000,imag_part)
title('Imaginary Part of X','FontSize', 9)

print('Sliding DFT - recursive formula result', '-dpng')