OPENQASM 2.0;
include "qelib1.inc";

// Initialize Quantum and Classical Registers
qreg q[7];
creg c[3];

// q[0]: |k> (Kimmel)
// q[1]: NOT |k> (NOT Kimmel)
// q[2]: |m> (Maher)
// q[3]: NOT |m> (NOT Maher)

// Initialize |k> to |1>
x q[0];

// Fan out for |k> and NOT |k>
cx q[0],q[1];
x q[1];

// Fan out for |m> and NOT |m>
cx q[2],q[3];
x q[3];

// (NOT |k>) OR (NOT |m>)
x q[1];
x q[3];
x q[4];
ccx q[1],q[3],q[4];
x q[1];
x q[3];

// |k> OR |m>
x q[0];
x q[2];
x q[5];
ccx q[0],q[2],q[5];
x q[0];
x q[2];

// ( (NOT |k>) OR (NOT |m>) ) AND ( (|k> OR |m>) )
ccx q[4],q[5],q[6];

// Measure whether all constraints are met.
// Yes:1, No:0
measure q[6] -> c[0];

// Measure |k>
measure q[0] -> c[1];

// Measure |m>
measure q[2] -> c[2];
