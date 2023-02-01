/*
Zero-Cross Detector
by Mark Boyd
v1.0 2023.02.01

Outputs a single-sample pulse whenever an audio wave crosses zero.

Inputs

Audio - The audio to be analyzed

External nodes:

1. Gate: Expr node - An Audio > 0 expression is required to convert the audio signal into a gate.
2. Z1Gate: Unit Delay node - provides a single-sample delayed copy of the gate signal. The internal rising & falling edge detector code ensures that a portion of the code runs only for the 1 sample after the gate goes from low to high or high to low. The Unit Delay's input is the Gate from the Audio > 0 expression, and its output plugs into the Z1Gate input.

*/


// Commented

// If rising edge
Gate > Z1Gate
    // Return 1
    ? 1
    // Else if falling edge
    : Gate < Z1Gate
        // Return 1
        ? 1
        // Else return 0
        : 0


// Uncommented

Gate > Z1Gate
    ? 1
    : Gate < Z1Gate
        ? 1
        : 0


// Minified

Gate>Z1Gate?1:Gate<Z1Gate?1:0
