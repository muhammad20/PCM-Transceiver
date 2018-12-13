% type = 1 => mid-rise uniform quantizer
% type = 2 => non-uniform u-law quantizer

function x = Quantizer(type, samples, L, Mp, u)
modified_samples = zeros(1, length(samples));
if type == 2
    %use non-uniform u-law quantizer (modify samples then pass them to mid-rise uniform quantizer)
    modified_samples = log(1 + u * abs(samples)) / log(1 + u);
elseif type == 1 
    %use mid-rise unfiorm quantizer
    modified_samples = samples;
end
delta =  2 * Mp / L;
quantizer_arr = ones(1, L);
for k = L / 2 : -1 : 1
        quantizer_arr(L / 2 + 1 - k) = -(delta / 2) - delta * (k - 1);
end
for k = 1 : L / 2
    quantizer_arr(k + L / 2) = delta / 2 + delta * (k - 1);
end


%%% calculate the quantized values
quantized_samples = zeros(1, length(samples));
quantity_index = 0;
for i = 1 : length(samples)
    min_quantity = inf;
    for k = 1 : length(quantizer_arr)
        val = abs(modified_samples(i) - quantizer_arr(k));
        if val < min_quantity
            min_quantity = val;
            quantity_index = k;
        end
    end
    quantized_samples(i) = quantizer_arr(quantity_index);
end

%%return the quantized values
x = quantized_samples;
end

