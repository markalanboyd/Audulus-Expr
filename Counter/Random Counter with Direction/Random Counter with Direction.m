/*
Random Counter with Direction
by Mark Boyd
v1.0 2023.02.01

A fully-featured counter written for an Expr node. The counter counts from Begin to End, regardless if Begin is a higher value than End. Changing the Begin and End values does not affect the current count. Sync instantly resets the counter to the Begin value. Random mode chooses a random number between the Begin and End values. Direction makes the counter count forward from Begin to End (1), backward (0), or a biased random walk (between 0 and 1), where 0.5 = 50% chance to count forwards or backwards.

Inputs

RandMode - Toggles Random mode on (1) or off (0)
Gate - Advances the counter on rising edge
PrevGate - Single-sample delayed copy of the gate signal
Noise - Random node input
End - The value the counter ends at
Begin - The value the counter begins at
Count - Feedback point for current count value
Sync - Resets counter to Begin on rising edge
Direction - 0 to 1 control that sets direction as forwards (1), backwards (0), or a biased random walk (between 0 and 1)
Increment - The amount by which the counter increments


External nodes:

1. Count: Unit Delay node - The output of the node is fed back into the Count input through a Unit Delay node to ensure that the feedback runs at sample rate.
2. PrevGate: Unit Delay node - provides a single-sample delayed copy of the gate signal. The internal rising edge detector code ensures that a portion of the code runs only for the 1 sample after the gate goes from low to high. The Unit Delay's input is the Gate, and its output plugs into the PrevGate input.
3. Noise: Random node - the counter has two features that use randomness: random step and random walk.
4 & 5. Begin/End: Expr nodes - The Begin and End control values need to be multiplied by a single MaxCount value + 0.999 to ensure that the controls swing through all numbers equally.


Pseudocode:

Random Mode
    Rising Edge Detector
        Choose random numbers between the Begin and End values
Count Mode
    Begin <= End
        Sync
            Rising Edge Detector
                Direction between 0 and 1
                    Count up or down depending on chance
                Direction 0 or 1
                    Count up if Direction == 1; down if Direction == 0
    Begin > End
        Sync
            Rising Edge Detector
                Direction between 0 and 1
                    Count up or down depending on chance
                Direction 0 or 1
                    Count up if Direction == 0; down if Direction == 1

*/


// Commented

// Random Mode
RandMode
    // Rising edge detector
    // The following applies to all instances of the rising edge detector: 
    // Execute the following portion in the 1 sample that occurs at the rising edge of the gate signal - requires an external feed-forward unit delay!
	? Gate > PrevGate
		? floor(Noise * (floor(End) - floor(Begin)) + floor(Begin))
		: Count
// Count Mode
    // Begin is less than or equal to End
	: Begin <= End
        // If Sync is high,
		? Sync 
            // return to begin.
			? floor(Begin)
            // Rising edge detector
			: Gate > PrevGate 
                // Check if the Direction control is somewhere between 0 and 1.
                ? (Direction > 0) * (Direction < 1)
                    // If Noise is less than Direction,
                    ? Noise < Direction
                        // and Count is less than End,
                        ? Count < floor(End)
                            // add the Increment to the Count;
                            ? Count + Increment
                            // otherwise return to Begin.
                            : floor(Begin)
                    // If Noise is greater than Direction,
                        // and Count is greater than Begin,
                        : Count > floor(Begin)
                            // subtract the Increment from the Count;
                            ? Count - Increment
                            // otherwise return to End.
                            : floor(End)
                // Direction is either 0 or 1.
                    : Direction
                        // If Direction is 1, count up. Check if Count is less than End.
                        ? Count < floor(End)
                            // If so, add the increment to the count;
                            ? Count + Increment
                            // Otherwise, return to Begin.
                            : floor(Begin)
                        // If Direction is 0, count down. Check if Count is greater than Begin.
                        : Count > floor(Begin)
                            // If so, subtract the increment from the count;
                            ? Count - Increment
                            // Otherwise, return to End.
                            : floor(End)
            // If not during the 1 sample after Gate's rising edge is detected
                // Return Count
				: Count
    // Begin is greater than End
        // If Sync is high,
		: Sync 
            // return to Begin.
			? floor(Begin) 
            // Rising edge detector
			: Gate > PrevGate 
                // Check if the Direction control is somewhere between 0 and 1.
                ? (Direction > 0) * (Direction < 1)
                    // If Noise is less than Direction,
                    ? Noise < Direction
                        // and Count is greater than End,
                        ? Count > floor(End)
                            // subtract the Increment from the Count;
                            ? Count - Increment
                            // otherwise return to Begin.
                            : floor(Begin)
                    // If Noise is greater than Direction, 
                        // and Count is less than Begin,
                        : Count < floor(Begin)
                            // add the Increment to the Count;
                            ? Count + Increment
                            // otherwise return to End.
                            : floor(End)
                    // Direction is either 0 or 1.
                    : Direction
                        // If Direction is 1, count down. Check if Count is greater than End.
                        ? Count > floor(End)
                            // If so, subtract the increment from the count;
                            ? Count - Increment
                            // otherwise, return to Begin.
                            : floor(Begin)
                        // If Direction is 0, count up. Check if Count is less than End.
                        : Count < floor(Begin)
                            // If so, add the increment to the count;
                            ? Count + Increment
                            // otherwise, return to End.
                            : floor(End)
            // If not during the 1 sample after Gate's rising edge is detected
                // Return Count
				: Count


// Uncommented

RandMode
	? Gate > PrevGate
		? floor(Noise * (floor(End) - floor(Begin)) + floor(Begin))
		: Count
	: Begin <= End
		? Sync 
			? floor(Begin)
			: Gate > PrevGate 
                ? (Direction > 0) * (Direction < 1)
                    ? Noise < Direction
                        ? Count < floor(End)
                            ? Count + Increment
                            : floor(Begin)
                        : Count > floor(Begin)
                            ? Count - Increment
                            : floor(End)
                    : Direction
                        ? Count < floor(End)
                            ? Count + Increment
                            : floor(Begin)
                        : Count > floor(Begin)
                            ? Count - Increment
                            : floor(End)
				: Count
		: Sync 
			? floor(Begin) 
			: Gate > PrevGate 
                ? (Direction > 0) * (Direction < 1)
                    ? Noise < Direction
                        ? Count > floor(End)
                            ? Count - Increment
                            : floor(Begin)
                        : Count < floor(Begin)
                            ? Count + Increment
                            : floor(End)
                    : Direction
                        ? Count > floor(End)
                            ? Count - Increment
                            : floor(Begin)
                        : Count < floor(Begin)
                            ? Count + Increment
                            : floor(End)
				: Count


// Minified

RandMode?Gate>PrevGate?floor(Noise*(floor(End)-floor(Begin))+floor(Begin)):Count:Begin<=End?Sync?floor(Begin):Gate>PrevGate?(Direction>0)*(Direction<1)?Noise<Direction?Count<floor(End)?Count+Increment:floor(Begin):Count>floor(Begin)?Count-Increment:floor(End):DirectionthanEnd.?Count<floor(End)?Count+Increment:floor(Begin):Count>floor(Begin)?Count-Increment:floor(End):Count:Sync?floor(Begin):Gate>PrevGate?(Direction>0)*(Direction<1)?Noise<Direction?Count>floor(End)?Count-Increment:floor(Begin):Count<floor(Begin)?Count+Increment:floor(End):Direction?Count>floor(End)?Count-Increment:floor(Begin):Count<floor(Begin)?Count+Increment:floor(End):Count
