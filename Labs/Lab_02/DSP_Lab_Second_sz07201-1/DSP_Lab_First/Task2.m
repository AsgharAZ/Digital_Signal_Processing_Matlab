%Task2
[A,freq] = audioread("speech.wav");
[B,freq2] = audioread("Large Long Echo Hall.wav");
B2 = B(:,1)
A2 = A(:,1)
Result = conv(B2,A2);
filename = "Beginning_13.wav"
audiowrite(filename, Result, freq2);