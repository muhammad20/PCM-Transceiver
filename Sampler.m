function x = Sampler(fm, fs, m_t, offset, num_cycles)
%accept m(t) as an input to the function
t = -1*num_cycles/fm:1/fs * 1/offset :num_cycles/fm;
ts = -1*num_cycles/fm:1/fs: num_cycles/fm;
samples = zeros(1, length(ts));
k = 1;
for i = 1 : offset : length(t)
    samples(k) = m_t(i);
    k = k + 1;
end
x = samples;
end