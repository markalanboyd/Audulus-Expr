/*
Begin-End Counter
by Mark Boyd
v1.0 2023.02.01

A basic counter written for an Expr node. The counter counts from Begin to End. If the Begin value is greater than or equal to the End value, counting stops. ync instantly resets the counter to the Begin value.

Inputs

Sync - Resets counter to Begin on rising edge
Begin - The value the counter begins at
Gate - Advances the counter on rising edge
Z1Gate - Single-sample delayed copy of the gate signal
Count - Feedback point for current count value
End - The value the counter ends at
Increment - The amount by which the counter increments


External nodes:

1. Count: Unit Delay node - The output of the node is fed back into the Count input through a Unit Delay node to ensure that the feedback runs at sample rate.
2. Z1Gate: Unit Delay node - provides a single-sample delayed copy of the gate signal. The internal rising edge detector code ensures that a portion of the code runs only for the 1 sample after the gate goes from low to high. The Unit Delay's input is the Gate, and its output plugs into the Z1Gate input.
3 & 4. Begin/End: Expr nodes - The Begin and End control values need to be multiplied by a single MaxCount value + 0.999 to ensure that the controls swing through all numbers equally.

*/


// Commented

// If sync is high
Sync 
    // Return to Begin
    ? floor(Begin)
    // If rising edge
    : Gate > Z1Gate 
        // If Count is less than End
        ? Count < floor(End)
            // Add the increment to the count
            ? Count + Increment
            // Else return to Begin
            : floor(Begin)
    // If not rising edge
        // Return Count
        : Count


// Uncommented

Sync 
    ? floor(Begin)
    : Gate > Z1Gate 
        ? Count < floor(End)
            ? Count + Increment
            : floor(Begin)
        : Count


// Minified

Sync?floor(Begin):Gate>Z1Gate?Count<floor(End)?Count+Increment:floor(Begin):Count
