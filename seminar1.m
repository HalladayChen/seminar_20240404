k = 20;
M = 100;
% SDFT Algorithm
X = zeros(1, 1000); % Initialize X vector

% Input data is a sine wave
for n = 0:999
    x(n + 1) = sin(2 * pi * k / M * n); % 可分析頻率為20以及40的sin波型
    y(n + 1) = awgn(x(n + 1), 20,'measured');
end

% sin當中的n乃經過sampling(delta(t - nT))，取樣後變為週期表示，希望週期可至1000次，也就是n = 1000

for t = 0:900
    for m = 0:(M-1) % 在窗口大小M範圍內進行DFT
        X(t + 1) = X(t + 1) + y(t + 1 + m) * exp(-1i * 2 * pi * m * k / M); % Accumulate value
    end
    X(t+1) = X(t+1)/M; % 傅立葉轉換時，會取出係數1/M
end

fig = figure;

subplot(2,2,1);
plot(0:999,y);
title('Input signal','FontSize', 9)
%xlabel('m')
%ylabel('x')
%grid on
%hold off;  % Release hold on the plot

% Define complex numbers
z = X;

% Compute absolute values
abs_value = abs(z);

% Plot the absolute value graph
subplot(2,2,2);
plot(1:1000,abs_value)
title('Absolute Value of X','FontSize', 9)
%xlabel('Index')
%ylabel('Absolute Value')
%grid on

% Extract real and imaginary parts
real_part = real(z);
imag_part = imag(z);

% Plot the real part graph
subplot(2,2,3);
plot(1:1000,real_part)
title('Real Part of X','FontSize', 9)
%xlabel('Index')
%ylabel('Real Part')
%grid on

% Plot the imaginary part graph
subplot(2,2,4);
plot(1:1000,imag_part)
title('Imaginary Part of X','FontSize', 9)
%xlabel('Index')
%ylabel('Imaginary Part')
%grid on

% Create a title textbox
annotation(fig,'textbox', [0 0.9 1 0.1], ...
    'String', 'formula1 result', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', ...
    'FontSize', 9);
print('Sliding DFT - initial formula - adding noise', '-dpng')
