mp = 5;
L = 32;
fs = 100;
fm = 5;
u = 100;
num_cycles = 2;
offset = 100;
ts = -1/fm:1/fs: 1/fm;
t = -1/fm:1/fs * 1/offset: 1/fm;

% original signal
m_t = mp * cos ( 2 * pi * fm * t);

%sampled signal
samples = Sampler(fm, fs, m_t, offset);

%quantized signal
quantized_samples = Quantizer(samples, L, mp);

%encoded signal to be transmitted
encoded_msg = Encoder(1, quantized_samples, mp, L, fs);

%decoded signal at receiver
received_quantized = Decoder(1, encoded_msg,mp,L);

received_msg = ReconstructionFilter(received_quantized,fm,fs,mp);

% %plotting the data at transmitter
% subplot(2,1,1);
% plot(t, m_t);
% hold on;
% stem(ts, samples);
% subplot(2,1,2);
% stairs(ts,quantized_samples);

figure;
%plotting data at receiver
stairs(ts, received_quantized);

figure;
plot(ts,received_msg);
