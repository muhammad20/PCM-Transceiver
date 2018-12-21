clc;
clear;
%% Input
mp = 5;
L = 32;
fs = 20;
fm = 10;
u = 100;
num_cycles = 2;
offset = 100;
ts = -1*num_cycles/fm:1/fs: num_cycles/fm;
t = -1*num_cycles/fm:1/fs * 1/offset: num_cycles/fm;

% original signal
m_t = mp * cos ( 2 * pi * fm * t);

%%
%sampled signal
samples = Sampler(fm, fs, m_t, offset, num_cycles);

%quantized signal
quantized_samples = Quantizer(samples, L, mp, u);

%encoded signal to be transmitted
encoded_msg = Encoder(3, quantized_samples, mp, L, fs);

%decoded signal at receiver
received_quantized = Decoder(3, encoded_msg,mp,L);

received_msg = ReconstructionFilter(received_quantized,fm,fs,u, num_cycles);

%% 
figure;
set(gcf,'name','Sampler Output','numbertitle','off');
plot(t, m_t);
hold on;
stem(ts, samples);
title('Sampler Output');
hold off;

%%
figure;
set(gcf,'name','Quantizer Output','numbertitle','off');
stem(ts, samples);
hold on;
stairs(ts,quantized_samples);
title('Quantizer Output');

%%
figure;
set(gcf,'name','Encoder Output','numbertitle','off');
encoded_msg_plot = encoded_msg;
encoded_msg_plot(length(encoded_msg_plot)+1) = encoded_msg_plot(length(encoded_msg_plot));
stairs(encoded_msg_plot);
ylim([-6 6]);
title('Encoder Output');

%%
figure;
set(gcf,'name','Destination Output','numbertitle','off');
plot(t, m_t);
hold on;
plot(ts,received_msg);
title('Destination Output');

%% Frequency Domain Representation
figure;
l = length(fft(m_t));
freq=(-l/2):(l/2)-1;
subplot(3,1,1);
plot(freq,abs(fftshift(fft(m_t))));
title('Source Input Signal');

l = length(fft(samples));
freq=(-l/2):(l/2)-1;
subplot(3,1,3);
plot(freq,abs(fftshift(fft(samples))));
title('Sampled Signal');

l = length(fft(received_msg));
freq=(-l/2):(l/2)-1;
subplot(3,1,2);
plot(freq,abs(fftshift(fft(received_msg))));
title('Destination Output Signal');

