% Load the audio file
[audioSignal, fs] = audioread('C:\Users\conno\Desktop\Song.mp3'); % Your specified audio file path
audioSignal = audioSignal(:, 1); % Use only the first channel if stereo

% Define frequency bands for bass, midrange, and treble
bassBand = [20, 150]; % Bass frequency range (20 Hz - 150 Hz)
midBand = [150, 1000]; % Midrange frequency range (150 Hz - 1000 Hz)
trebleBand = [1000, 5000]; % Treble frequency range (1000 Hz - 5000 Hz)

% Create filters for each band using Butterworth filter
[bass_b, bass_a] = butter(2, bassBand / (fs / 2), 'bandpass');
[mid_b, mid_a] = butter(2, midBand / (fs / 2), 'bandpass');
[treble_b, treble_a] = butter(2, trebleBand / (fs / 2), 'bandpass');

% Apply filters to the audio signal
bassSignal = filter(bass_b, bass_a, audioSignal);
midSignal = filter(mid_b, mid_a, audioSignal);
trebleSignal = filter(treble_b, treble_a, audioSignal);

% Adjust the gain of each band (parametric equalizer effect)
bassGain = 1.5; % Adjust as needed
midGain = 1.0; % Adjust as needed
trebleGain = 1.2; % Adjust as needed

% Apply gain adjustments
bassSignal = bassSignal * bassGain;
midSignal = midSignal * midGain;
trebleSignal = trebleSignal * trebleGain;

% Combine the modified bands to create the equalized audio signal
equalizedSignal = bassSignal + midSignal + trebleSignal;

% Normalize the output signal to prevent clipping
equalizedSignal = equalizedSignal / max(abs(equalizedSignal));

% Plot frequency response of the filters in separate figures
figure;
freqz(bass_b, bass_a, 1024, fs);
title('Bass Band Filter Frequency Response');

figure;
freqz(mid_b, mid_a, 1024, fs);
title('Midrange Band Filter Frequency Response');

figure;
freqz(treble_b, treble_a, 1024, fs);
title('Treble Band Filter Frequency Response');

% Play the original and equalized audio
disp('Playing original audio');
sound(audioSignal, fs);
pause(length(audioSignal) / fs + 1); % Wait for original audio to finish

disp('Playing equalized audio');
sound(equalizedSignal, fs);

% Save the equalized audio to a new file
audiowrite('C:\Users\conno\Desktop\equalized_audio.wav', equalizedSignal, fs);

disp('Equalized audio has been saved to "C:\Users\conno\Desktop\equalized_audio.wav".');

