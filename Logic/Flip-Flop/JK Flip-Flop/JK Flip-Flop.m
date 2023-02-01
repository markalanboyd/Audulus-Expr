/*
JK Flip-Flop
by Mark Boyd
v1.0 2023.02.01

A JK flip-flop is a version of a Set-Reset flip-flop without the invalid conditions of S = 0 and R = 0. The J and K are the initials of its inventor, Jack Kilby. Kilby was an electrical engineer who also co-created the first integrated circuit at Texas Instruments.

Inputs

J - Sets the bit 


External nodes:

1. Count: Unit Delay node - The output of the node is fed back into the Count input through a Unit Delay node to ensure that the feedback runs at sample rate.
2. PrevGate: Unit Delay node - provides a single-sample delayed copy of the gate signal. The internal rising edge detector code ensures that a portion of the code runs only for the 1 sample after the gate goes from low to high. The Unit Delay's input is the Gate, and its output plugs into the PrevGate input.
3 & 4. Begin/End: Expr nodes - The Begin and End control values need to be multiplied by a single MaxCount value + 0.999 to ensure that the controls swing through all numbers equally.

*/


// Commented




// Uncommented




// Minified


