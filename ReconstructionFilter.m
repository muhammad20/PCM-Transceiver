function x = ReconstructionFilter(received_quantized, fm, fs,mp,u)
if nargin == 5
    max_q = mp;
    received_quantized = (exp(abs(received_quantized)*log(1+u))-1)*(max_q/u) .*sign(received_quantized);
end
Ts = 1/fs;

t_n = 0:1/fs * 1/ 100:1/fm;
received_message = zeros(1,length(t_n));
k=1;
for t = 0:1/fs * 1/100:2 * 1/fm
    received_message(k) = 0;
    for i=1:length(received_quantized)
        received_message(k) = received_message(k) + received_quantized(i)*sinc((t-i*Ts)/Ts);
    end
    k=k+1;
end
x = received_message;

% y = received_quantized;
% for i = 1 : 2000
%     t = (i - 1) * Ts/100;
%     h = sinc((t-20.*Ts)./Ts);
%     xr(i)= y*h.';
% end
%     x = xr;
end