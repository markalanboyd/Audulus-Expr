/*
T Flip-Flop
by Mark Boyd
v1.0 2023.02.01

A T flip-flop toggles Q state on each rising edge input.

Inputs

T - Toggle gate input
Z1T - Single-sample delayed copy of the T gate
Q - Feedback point for the Q output


External nodes:

1. Q: Unit Delay node - The output of the node is fed back into the Count input through a Unit Delay node to ensure that the feedback runs at sample rate.
2. Z1T: Unit Delay node - provides a single-sample delayed copy of the T gate. The internal rising edge detector code ensures that a portion of the code runs only for the 1 sample after the gate goes from low to high. The Unit Delay's input is the Gate, and its output plugs into the Z1T input.

*/


// Commented

// Execute when T goes high
T
    // If rising edge
    ? T > Z1T
        // If Q is high
        ? Q
            // Return 0
            ? 0
            // Else return 1
            : 1
    // If not rising edge
        // Return Q
        : Q
    // If T not high, return Q
    : Q


// Uncommented

T
    ? T > Z1T
        ? Q
            ? 0
            : 1
        : Q
    : Q


// Minified

T?T>Z1T?Q?0:1:Q:Q
