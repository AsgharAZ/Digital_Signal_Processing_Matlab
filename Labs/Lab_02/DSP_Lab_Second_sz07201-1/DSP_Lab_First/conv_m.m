function [y, ny] = conv_m(x, nx, h, nh)
% Modified convolution routine for signal processing
% --------------------------------------------------------------
% [y, ny] = concolution result
% [x, nx] = first signal
% [h, nh] = second signal
%
nyb = nx(1) + nh(1);
nye = nx(length(x)) + nh(length(h));
ny = [nyb:nye];
y = conv(x, h);
% End of the function
