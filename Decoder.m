function [y] = Decoder(type, m, mp, l, fs)

% normalizing input voltage (converting input voltages to binary codewords)

numberOfBits = ceil(log2(l)) + 1;
numberOfWords = length(m)/numberOfBits;
if type == 3
    numberOfWords = numberOfWords/2;
end
bin2dArray = zeros(numberOfWords, numberOfBits);

A = 5;
for i=1:numberOfWords
    for j=1:numberOfBits
        k = (i-1)*numberOfBits + j;
        switch type
            % Unipolar NRZ signaling
            case 1
                if m(k) == A
                    bin2dArray(i,j) = 1;
                elseif m(k) == 0
                    bin2dArray(i,j) = 0;
                end
                
            % Polar NRZ signaling
            case 2
                if m(k) == A
                    bin2dArray(i,j) = 1;
                elseif m(k) == -A
                    bin2dArray(i,j) = 0;
                end
                
            % Manchester signaling
            case 3
                k = k*2-1;
                if m(k) == A
                    bin2dArray(i,j) = 1;
                elseif m(k) == -A
                    bin2dArray(i,j) = 0;
                end
            otherwise
                disp('Invalid encoder type');
        end
    end
end

final_values = zeros(1, numberOfWords);
% converting binary codewords to decimals
for i=1:numberOfWords
    final_values(i) = 0;
    for j=1:numberOfBits
        final_values(i) = final_values(i) + bin2dArray(i,j)*(2.^(numberOfBits-j));
    end
end

% converting decimals to voltage levels
for i = 1:numberOfWords
    final_values(i) = ((final_values(i)*2*mp)/l)-mp + mp/l;
end

y = final_values;
