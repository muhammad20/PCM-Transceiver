function x = Sampler(fm, fs, m_t, offset)
%accept m(t) as an input to the function
t = 0:1/fs * 1/offset : 2 * 1/fm;
ts = 0:1/fs: 2 * 1/fm;
samples = zeros(1, length(ts));
k = 1;
for i = 1 : offset : length(t)
    samples(k) = m_t(i);
    k = k + 1;
end
x = samples;
end