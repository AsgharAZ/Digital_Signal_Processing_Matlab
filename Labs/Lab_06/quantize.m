function quantized_signal = quantize(signal, num_bits)
    % Determine the range of the signal
    signal_min = min(signal);
    signal_max = max(signal);
    signal_range = signal_max - signal_min;
    
    % Calculate the step size for quantization
    step_size = signal_range / (2^num_bits);
    
    % Quantize the signal
    quantized_signal = round(signal / step_size) * step_size;
end
