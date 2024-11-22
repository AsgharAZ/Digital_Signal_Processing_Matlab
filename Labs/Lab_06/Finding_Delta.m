clear; close all
cycles = 2; 
B = 8;
fx = 1;
OS = 20;
tmax = cycles*1/fx;
Ah=1.5;

fsZOH = OS*fx;
tstepZOH = 1/fsZOH;
timeZOH = 0:tstepZOH:tmax;
tlenZOH = length(timeZOH);
xsZOH = sin(2*pi*fx*timeZOH)+Ah*sin(6*pi*fx*timeZOH);
yZOH = quantize_v(xsZOH,B);

fs = OS*B*fx;
tstep = 1/fs;
time = 0:tstep:tmax;
tlen = length(time);
xs = sin(2*pi*fx*time)+Ah*sin(6*pi*fx*time);

DELall = [1:0.05:25]*OS*2^(-B);

for jj=1:length(DELall)
    DEL=DELall(jj);
    xnQlast = 0;
    enQ = zeros(1,tlen);
    for ii = 1:tlen
        en = xs(ii) - xnQlast;
        enQ(ii) = DEL*sign(en);
        xnQlast =  enQ(ii) + xnQlast;
    end
    yenQ = cumsum(enQ); 
    J = 5; 
    yenQJ = repmat(yenQ(1:end-1),J,1); 
    yenQJ = yenQJ(:);
    JZOH = B*J; 
    yZOHJ = repmat(yZOH(1:end-1),JZOH,1); 
    yZOHJ = yZOHJ(:);
    faxis = linspace(0.001,fs*J,length(yZOHJ))';
    FFTyJ = abs(fft(yZOHJ));
    FFTyenQJ = abs(fft(yenQJ));
    harmonics(jj)=sum(abs(FFTyJ-FFTyenQJ)./(sqrt(faxis)));
end

semilogy(DELall,harmonics)
[a,b]=min(harmonics);
Best_DEL = DELall(b);
disp(Best_DEL')

record=[];
diff_fft=sign(diff(harmonics))+1;
for ii=1:length(diff_fft)-1
    if diff_fft(ii)==0 && diff_fft(ii+1)==2
        record=[record DELall(ii+1)];
    end
end
record;