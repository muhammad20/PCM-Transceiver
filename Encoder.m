function [y] = Encoder(type, m, mp, l, fs)

% converting voltage levels to decimals
for i = 1:1:length(m)
    output(i)=((m(i)+mp-mp/l)*l)/(2*mp);
end

numberOfBits = ceil(log2(l)) + 1;
bin2dArray = zeros(length(m),numberOfBits);

% converting decimals to binary numbers
for i = 1:1:length(m)
    binaryNumber = dec2bin(output(i), numberOfBits);
    for j = numberOfBits:-1:1
        bin2dArray(i,j) = binaryNumber(j);
        bin2dArray(i,j) = bin2dArray(i,j) - 48; 
    end
end

% converting binary numbers to voltage levels (A = 5 volt)
A = 5;
counter = 1;
% for each bit in the message
for i = 1:1:length(m)
    for j = 1:1:numberOfBits
        switch type
            % Unipolar NRZ signaling
            case 1
                if bin2dArray(i,j) == 1
                    final_values(counter) = A;
                elseif bin2dArray(i,j) == 0
                    final_values(counter) = 0;
                end
            % Polar NRZ signaling
            case 2
                if bin2dArray(i,j) == 1
                    final_values(counter) = A;
                elseif bin2dArray(i,j) == 0
                    final_values(counter) = -1*A;
                end
            % Manchester signaling
            case 3
                if bin2dArray(i,j) == 1
                    final_values(counter) = A;
                    counter = counter + 1;
                    final_values(counter) = -1*A;
                elseif bin2dArray(i,j) == 0
                    final_values(counter) = -1*A;
                    counter = counter + 1;
                    final_values(counter) = A;
                end
            otherwise
                disp('Invalid encoder type');
        end
        counter = counter + 1;
    end
end

% plotting

xValues = final_values;
xValues(length(xValues)+1) = xValues(length(xValues));

Ts = 1 / fs;
for i=1:length(xValues)
    signalTime(i) = (i-1)*Ts;
    if type == 3
        signalTime(i) = signalTime(i)/2;
    end
end

% figure % opens new figure window
% stairs(signalTime, xValues, 'LineWidth',3);
% 
% title('Encoder Output')
% xlabel('time')
% ylabel('voltage')
% ylim([-1*A-1 A+1]);
% 
% % end of plotting

y = final_values;
