mp = 3;
L = 8;
fs = 50;
fm = 1;
ts = 0:1/fs: 2 * 1/fm;
t = 0:1/fs * 10 ^ -2:2 * 1/fm;
m_t = mp * sin ( 2 * pi * fm * t);
samples = Sampler(mp, fm, fs);
stem(ts, samples);
grid on;
quantized_samples = Quantizer(1, samples, L, mp);
% disp(samples);
% disp(quantized_samples);
stem(ts,quantized_samples);
encoded_msg = Encoder(1, quantized_samples, mp, L, fs);
received_quantized = Decoder(1, encoded_msg,mp,L);
stairs(ts,received_quantized);