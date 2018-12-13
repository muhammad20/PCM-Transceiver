function x = Sampler(fm, fs)
%we let the arbitrary m(t) = 5 * cos(2 * pi * fm * t)
t = 0:1/fs * 10 ^ -2:2 * 1/fm;
m_t = 5 * cos(2 * pi * fm * t);
ts = 0:1/fs: 2 * 1/fm;
samples = 5 * cos(2 * pi * fm * ts);
%disp(ts);
plot(t,m_t);
% to plot over the existing plot
hold on;
%stem(ts,samples);
x = samples;
end