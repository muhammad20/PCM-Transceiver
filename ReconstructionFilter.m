function x = ReconstructionFilter(received_quantized, fm, fs)
    t_filter = -2 : 1/fs: 2;
    
    S=sinc(2*(fm+1)*t_filter);
   
    %plot(t_filter,conv(S,received_quantized,'same'));
    
end