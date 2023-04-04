// Phasor with reversible polarity and sync

Sync
    ? 0
    : Mode
        ? mod(Phase + 2 * pi * (Hz / SampleRate), 2 * pi)
        : mod(Phase - 2 * pi * (Hz / SampleRate), 2 * pi)


Sync?0:mod((Mode?(2*pi-2*pi*(Hz/SampleRate)):(2*pi*(Hz/SampleRate)))+Phase,2*pi)
