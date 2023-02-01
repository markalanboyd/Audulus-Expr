/*
JK Flip-Flop
by Mark Boyd
v1.0 2023.02.01

A JK flip-flop is a version of a Set-Reset flip-flop without the invalid conditions of S = 0 and R = 0. The J and K are the initials of its inventor, Jack Kilby. Kilby was an electrical engineer who also co-created the first integrated circuit at Texas Instruments. This implementation includes a Mode to determine what to do when J and K go high simultaenously.

Inputs

Mode - If J and K go high simultaenously, in J Mode (1), the gate will go or stay high; in K mode (0), the gate will go or stay low.
J - Sets output gate high on rising edge
K - Resets the output gate low on rising edge
Q - Feedback point for output


External nodes:

1. Q: Unit Delay node - The output of the node is fed back into the Q input through a Unit Delay node to ensure that the feedback runs at sample rate.

*/


// Commented

// If Mode is high
Mode
    // If J is high
    ? J
        // Return 1
        ? 1
        // Else if K is high
        : K
            // Return 0
            ? 0
            // Else return Q
            : Q
// If Mode is low
    // If K is high
    : K
        // Return 0
        ? 0
        // Else if J is high
        : J
            // Return 1
            ? 1
            // Else return Q
            : Q


// Uncommented

Mode
    ? J
        ? 1
        : K
            ? 0
            : Q
    : K
        ? 0
        : J
            ? 1
            : Q


// Minified

Mode?J?1:K?0:Q:K?0:J?1:Q
