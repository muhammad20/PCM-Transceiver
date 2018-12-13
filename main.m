m = 10;
L = 8;
samples = [1.5 3.2 2 3 1.5 3 6 7 -5 -9];
quantized_samples = Quantizer(1, samples, L, m);
disp(samples);
disp(quantized_samples);
x = Sampler(1,20);
