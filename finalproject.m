clc
clear all

% Parameters
nfft = 8192;
noverlap = round(0.75*nfft);
hanning = hanning(nfft);
scale = 100;

% Read in Audio
[y,Fs]=audioread('filename.wav'); % change filename to analyzed filename
channel = 1;
signal = y(:,channel);
samples = length(signal);

% Average FFT
[sensor_spectrum, freq] = pwelch(signal,hanning,noverlap,nfft,Fs);
spectrum = 20*log10(sensor_spectrum);
semilogx(freq,spectrum)
grid
figure(1)
title(['Averaged FFT = ' num2str(freq(2)-freq(1)) ' Hz ']);
xlabel('Frequency (Hz)');
ylabel('Amplitude(dB)');

% Time / Frequency Analysis & Spectrum Graph
[sg,fsg,tsg] = specgram(signal,nfft,Fs,hanning,noverlap); 
peak = 20*log10(abs(sg))+20*log10(2/length(fsg));
minimum = round(max(max(peak))) - scale;
peak(peak<minimum) = minimum;
figure(2);
imagesc(tsg,fsg,peak);
colormap('jet');
axis('xy');
colorbar('vert');
grid
title(['Spectrogram - Avg Freq = ' num2str(fsg(2)-fsg(1)) ' Hz ']);
xlabel('Time (s)');
ylabel('Frequency (Hz)');