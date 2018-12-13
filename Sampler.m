function x = Sampler(fm, fs)
%we let the arbitrary m(t) = 5 * cos(2 * pi * fm * t)
t = 0:1/fm * 10 ^ -2:2 * 1/fm;
m_t = 5 * cos(2 * pi * fm * t);
ts = 1/fs;
disp(ts);
plot(t,m_t);
x = 10;
end