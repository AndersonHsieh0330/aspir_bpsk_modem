% In this program I have described a very simple yet effective way of
% applying a costas loop in receiving a DSB-SC signal with unknown phase
% offset in carrier. The basic contruction of a costas receiver includes
% Low pass filters and Voltage controlled oscillator with central frequency
% same as carrier frequency.
% 
% For applying a low pass filter a simple Integrator can be used. In
% digital domain integrator can be replaced by summator and hence I have
% replaced integrator with summator which generate output summing previous
% Tc/Ts samples, where Tc is period of carrier wave
%                      Ts is sampling time
% The reason is we are considering integrator as y(t) = int(x(t)) from 0 to
% Tc. For this approximate lowpass filter best bandwidth achieved is 200Hz 
% so consider this before designing your message.
% The VCO operation can be approximated as 
% phi(i) = phi(i-1) - sign(.25*m(t)*sin(phi(i-1))*cos(phi(i-1)));
% That is, if phase of carrier is greater than VCO phase then we increase
% phase in next iteration and vice versa.
% After doing iteration all over sample we will get our desired message
% signal and will get initial phase offset applied to input carrier.
% ------------------------------------------------------------------------
% For any suggestions please contact :
% gauravgg@iitk.ac.in
% gaurav71531@gmail.com

% ------------------------------------------------------------------------
% --------------------------Input Parameters------------------------------
% ------------------------------------------------------------------------
t = 0:(256000-1);             % time vector, we want time to start at 0. 
                              % Each element of the vector is a time step, 
                              % not 1 second. if you really want to think 
                              % of it in terms of seconds, each time step
                              % would be 1/fs seconds.

bit_rate = 10000;             % bits per second
fs = 4e5;                     % sampling frequency
fc = 40000;                   % carrier frequency
sps = fs / bit_rate;          % samples per symbol
tx_phase_offset = 2*pi*rand;  % phase offset for testing
lpf_taps = 15;                % depth of our integrator lpf

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
i_arm_filtered = zeros(1,N);
q_arm_filtered = zeros(1,N);

for i = 1:N
    
    if i>1
        % The step in which phase is changed is pi*5*10*-6, 
        % it can be varied
        phi(i) = phi(i-1) - (5*10^-6)*pi*sign(i_arm_filtered(i-1)*q_arm_filtered(i-1));
    end
    
    i_arm(i) = bpsk_signal(i) * cos(2*pi*fc*t(i)/fs  + phi(i));
    q_arm(i) = bpsk_signal(i) * sin(2*pi*fc*t(i)/fs  + phi(i));

% -----------------------INTEGRATOR (used as LPF)-------------------------
    % summing previous 100 (Tc/Ts) values        
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
subplot(3, 2, 1);
stem(bit_data, 'filled');
title('random bit\_data generated');
xlabel('Bit Index');
ylabel('Data');

subplot(3, 2, 2);
stem(mapped_data, 'filled');
title('mapped\_data');
xlabel('Time Step (Sample Step)');
ylabel('Amplitude');

subplot(3, 2, 3);
plot(t,bpsk_signal);
title('bpsk\_signal');
xlabel('Time Step (Sample Step)');
ylabel('Amplitude');

subplot(3, 2, 4);
plot(t,phi);
ylim([-pi pi]);
title('phase adjust');
xlabel('Time Step (Sample Step)');
ylabel('Amplitude');

subplot(3, 2, 5);
plot(t,i_arm_filtered);
title('output signal');
xlabel('Time Step (Sample Step)');
ylabel('Amplitude');

subplot(3, 2, 6);
stem(sampled_data, 'filled');
title('sampled data after demodulation');
xlabel('Bit Index');
ylabel('Data');

disp(['carrier phase offset at trasmitter side : ',...
    num2str(tx_phase_offset), ' rad/s']);
phase = phi(end);
disp(['final phase adjustment : ', num2str(phase), ' rad/s']);

% compare sampled data with original data
comparison_result = zeros(1,length(bit_data));
for i = 1:length(bit_data)
    % 0 for mismatch
    comparison_result(i) = bit_data(i) == sampled_data(i);
end
disp(['there are ', int2str(sum(comparison_result == 0)), ...
    ' mismatch between original data and sampled data, preamble not included in this simulation'])