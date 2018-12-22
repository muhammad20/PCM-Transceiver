function x = ReconstructionFilter(received_quantized, fm, fs, u, mp,offset)
time=(-2/fm): 1/(100*fs): (2/fm);

SSinc=sinc(2*(fm)*(time));
count1=1;
count2=1;
temp=zeros(size(time));
while(count1<=length(received_quantized))
   temp(count2)=received_quantized(count1);
   count1=count1+1;
   count2=count2+100;
end
x=conv(temp,SSinc,'same');
x=x-(max(x)+min(x))/2;
x=(mp/max(x))*x;


end