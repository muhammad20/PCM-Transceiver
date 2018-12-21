function x = ReconstructionFilter(received_quantized, fm, fs, u, num_cycles)
if u ~= 0
    received_quantized = 5*(exp(abs(received_quantized)*log(1+u))-1)*(1/u) .*sign(received_quantized);
end

t = -1*num_cycles/fm : 1/fs : num_cycles/fm;
y = sinc(fs * t);
x = conv(y, received_quantized, 'same');

end