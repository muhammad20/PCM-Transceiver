function x = ReconstructionFilter(received_quantized, fm, fs,mp,u)
if nargin == 5
    received_quantized = (exp(abs(received_quantized)*log(1+u))-1)*(1/u) .*sign(received_quantized);
end
Ts = 1/fs;
% 
% t_n = -1/fm:1/fs * 1/ 100:1/fm;
% received_message = zeros(1,length(t_n));
% k=1;
% for t = -1/fm:1/fs * 1/100:1/fm
%     received_message(k) = 0;
%     for i=1:length(received_quantized)
%         received_message(k) = received_message(k) + received_quantized(i)*sinc((t-i*Ts)/Ts);
%     end
%     k=k+1;
% end
t = -1/fm : 1/fs : 1/fm;
y = sinc(fs * t);
x = conv(y, received_quantized, 'same');

% y = received_quantized;
% for i = 1 : 2000
%     t = (i - 1) * Ts/100;
%     h = sinc((t-20.*Ts)./Ts);
%     xr(i)= y*h.';
% end
%     x = xr;
end