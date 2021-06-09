function wfft(W,FS)
	L = size(W,2);
	f = FS*(0:(L/2))/L;
	Y = fft(W);
	P2 = abs(Y/L);
	P1 = P2(1:L/2+1);
	P1(2:end-1) = 2*P1(2:end-1);
	RGB = [rand() rand() rand()];
	plot(f,P1,'Color',RGB);
