% Written by Anderson Hsieh, 2025/01/01
% based off https://www.mathworks.com/matlabcentral/fileexchange/32956-costas-loop
% with modifications
% TODO : look into lpf integrator depth and the phase adjustment step

% ------------------------------------------------------------------------
% --------------------------Input Parameters------------------------------
% ------------------------------------------------------------------------
symbol_rate = 2500000;                      % symbol rate (symbol/second)
bits_per_symbol = 1;                        % bits/symbol, 1 for bpsk
bit_rate = bits_per_symbol*symbol_rate;     % bits per second
fs = 200000000;                             % sampling frequency
fc = 25000000;                              % carrier frequency
sps = fs / bit_rate;                        % samples per symbol
tx_phase_offset = 2*pi*rand;                % phase offset for testing
lpf_taps = 10;                              % depth of our integrator LPF
t = 0:(sps*1000-1);             % time vector, we want time to start at 0. 
                                % Each element of the vector is a time step, 
                                % not 1 second. if you really want to think 
                                % of it in terms of seconds, each time step
                                % would be 1/fs seconds.
                                % 1000 bits regardless of any other params

% ------------------------------------------------------------------------
% --------------------------Modulation------------------------------------
% ------------------------------------------------------------------------
% generate random data
bit_data = randi([0, 1], 1, length(t)/sps);

% map data to constellation 
mapped_data = repelem((2*bit_data-1), sps);  

% carrier signal with phase offset     
carrier = cos(2*pi*fc*t/fs + tx_phase_offset);            

% modulate the signal
bpsk_signal = mapped_data.*carrier;

% ------------------------------------------------------------------------
% --------------------------Demodulation----------------------------------
% ------------------------------------------------------------------------
N = length(bpsk_signal);  
phi = zeros(1,N);            % Phase vector of NCO ouptut
i_arm = zeros(1,N); 
q_arm = zeros(1,N);
i_arm_lu = zeros(1,N);
q_arm_lu = zeros(1,N);
i_arm_filtered = zeros(1,N);
q_arm_filtered = zeros(1,N);

for i = 1:N
    
    if i>1
        % The step in which phase is changed is pi*5*10*-5, 
        % it can be varied
        %phi(i) = phi(i-1) - (5*10^-1)*pi*sign(i_arm_filtered(i-1)*q_arm_filtered(i-1));
        phi(i) = phi(i-1) - 0.00613592315*sign(i_arm_filtered(i-1)*q_arm_filtered(i-1));
    end
    i_arm_lu(i) = cos(2*pi*fc*t(i)/fs  + phi(i));
    q_arm_lu(i) = sin(2*pi*fc*t(i)/fs  + phi(i));
    i_arm(i) = bpsk_signal(i) * i_arm_lu(i);
    q_arm(i) = bpsk_signal(i) * q_arm_lu(i);

% -----------------------INTEGRATOR (used as LPF)-------------------------
    % summing previous 10 (Tc/Ts) values        
    for j = i-(lpf_taps-1):i
        if (j < 1)
            continue
        end
        i_arm_filtered(i) = i_arm_filtered(i) + i_arm(j);
        q_arm_filtered(i) = q_arm_filtered(i) + q_arm(j);
    end
%-------------------------------------------------------------------------  
end

% ------------------------------------------------------------------------
% ---------------------Resample Demodulated data--------------------------
% ------------------------------------------------------------------------
sample_offset = 39;
i = 1 + sample_offset;
index_counter = 1;
sampled_data = zeros(1,length(bit_data));
while (i < length(i_arm_filtered))
    % reverse the polarity when sampling
    % -1 -> 1
    %  1 -> 0
    sampled_data(index_counter) = (1-sign(i_arm_filtered(i)))/2;
    index_counter = index_counter + 1;
    i = i + sps;
end

% ------------------------------------------------------------------------
% -----------------------------Ploting------------------------------------
% ------------------------------------------------------------------------
subplot(4, 2, 1);
stem(bit_data, 'filled');
title('random bit\_data generated');
xlabel('Bit Index');
ylabel('Data');

subplot(4, 2, 2);
stem(mapped_data, 'filled');
title('mapped\_data');
xlabel('Time Step (Sample Step)');
ylabel('Amplitude');

subplot(4, 2, 3);
plot(t,i_arm_lu);
title('i\_arm\_lu');
xlabel('Time Step (Sample Step)');
ylabel('Amplitude');

subplot(4, 2, 4);
plot(t,i_arm);
title('i\_arm');
xlabel('Time Step (Sample Step)');
ylabel('Amplitude');

subplot(4, 2, 5);
plot(t,phi);
ylim([-pi pi]);
title('phase adjust');
xlabel('Time Step (Sample Step)');
ylabel('Amplitude');

subplot(4, 2, 6);
plot(t,i_arm_filtered);
title('i\_arm\_filtered');
xlabel('Time Step (Sample Step)');
ylabel('Amplitude');

subplot(4, 2, 7);
stem(sampled_data, 'filled');
title('sampled data after demodulation');
xlabel('Bit Index');
ylabel('Data');

% compare sampled data with original data
comparison_result = zeros(1,length(bit_data));
for i = 1:length(bit_data)
    % 0 for mismatch
    comparison_result(i) = bit_data(i) == sampled_data(i);
end

%subplot(4, 2, 8);
%plot(comparison_result);
%title('comparison orignal data and sampled data');
%xlabel('0 for mismatch');
%ylabel('index');

nfft = 1024; % FFT size
frequencies = linspace(-fs/2, fs/2, nfft);
rf_spectrum = fftshift(abs(fft(bpsk_signal, nfft)));
subplot(4, 2, 8);
plot(frequencies, 20*log10(rf_spectrum));
title('spectrum of bpsk signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

disp(['carrier phase offset at trasmitter side : ',...
    num2str(tx_phase_offset), ' rad/s']);
phase = phi(end);
disp(['final phase adjustment : ', num2str(phase), ' rad/s']);
disp(['number of data points: ', int2str(length(bit_data))]);
disp(['there are ', int2str(sum(comparison_result == 0)), ...
    ' mismatch between original data and sampled data, preamble not included in this simulation'])