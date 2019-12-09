# An example file in our custom HCL variant, with lots of comments

register pP {  
    # our own internal register. P_pc is its output, p_pc is its input.
    pc:64 = 0; # 64-bits wide; 0 is its default value.
    
    # we could add other registers to the P register bank
    # register bank should be a lower-case letter and an upper-case letter, in that order.
    
    # there are also two other signals we can optionally use:
    # "bubble_P = true" resets every register in P to its default value
    # "stall_P = true" causes P_pc not to change, ignoring p_pc's value
} 

# "pc" is a pre-defined input to the instruction memory and is the 
# address to fetch 6 bytes from (into pre-defined output "i10bytes").
pc = P_pc;

# we can define our own input/output "wires" of any number of 0<bits<=80
wire opcode:8, icode:4;
wire rB: 4;
wire rA:4;
wire valC:64;
wire valE:64;
wire valP:64;
wire ifun:4;

wire conditions:1, isRRmovq:1, iscmovXX:1;
isRRmovq = icode == RRMOVQ && ifun == 0;
iscmovXX = icode == CMOVXX && ifun !=0;
conditions = [
    ifun==LE: C_SF||C_ZF;
    ifun==LT: C_SF;
    ifun==EQ: C_ZF;
    ifun==NE: !C_ZF;
    ifun==GE: !C_SF;
    ifun==GT: (!C_ZF)&&(!C_SF);
    1:1;
];


# the x[i..j] means "just the bits between i and j".  x[0..1] is the 
# low-order bit, similar to what the c code "x&1" does; "x&7" is x[0..3]
opcode = i10bytes[0..8];   # first byte read from instruction memory
icode = opcode[4..8];      # top nibble of that byte
ifun = opcode[0..4];
rB=i10bytes[8..12];
rA=i10bytes[12..16];

valC=[
icode == JXX:i10bytes[8..72];
icode == CALL:i10bytes[8..72];
1:i10bytes[16..80];
];

valE=[
icode == OPQ && ifun == XORQ : reg_outputA ^ reg_outputB;
icode == OPQ && ifun == ANDQ : reg_outputA & reg_outputB;
icode == OPQ && ifun == ADDQ : reg_outputA + reg_outputB;
icode == OPQ && ifun == SUBQ : reg_outputB - reg_outputA;
icode == RMMOVQ : reg_outputB + valC;
icode == CMOVXX : reg_outputA;
icode == MRMOVQ:reg_outputB + valC;
icode == PUSHQ:reg_outputB-8;
icode == POPQ:reg_outputB+8;
icode == CALL:reg_outputA-8;
icode == RET:reg_outputA+8;
1:0;
];

valP =[
icode == HALT : P_pc +1;
icode == NOP : P_pc+1;
icode == RET : P_pc+1;
icode == RRMOVQ : P_pc+2;
icode == OPQ : P_pc+2;
icode == PUSHQ : P_pc+2;
icode == POPQ : P_pc+2;
icode == JXX : P_pc+9;
icode == CALL: P_pc+9;
1: P_pc+10;
];


/* we could also have done i10bytes[4..8] directly, but I wanted to
 * demonstrate more bit slicing... and all 3 kinds of comments      */
// this is the third kind of comment

# named constants can help make code readable
const TOO_BIG = 0xC; # the first unused icode in Y86-64

# some named constants are built-in: the icodes, ifuns, STAT_??? and REG_???


# Stat is a built-in output; STAT_HLT means "stop", STAT_AOK means 
# "continue".  The following uses the mux syntax described in the 
# textbook
Stat = [
     icode >= 0xC : STAT_INS;
     icode == HALT : STAT_HLT;
     1             : STAT_AOK;
];

reg_srcA = [
icode==RRMOVQ:rA;
icode==OPQ:rA;
icode==RMMOVQ:rA;
icode==PUSHQ:rA;
icode==CALL:REG_RSP;
icode==RET:REG_RSP;
1:REG_NONE
];
reg_srcB= [
icode==OPQ:rB;
icode==RMMOVQ:rB;
icode==MRMOVQ:rB;
icode==PUSHQ:REG_RSP;
icode==POPQ:REG_RSP;
1:REG_NONE;
];

reg_dstE = [
icode==IRMOVQ:rB;
icode==CMOVXX && !conditions :REG_NONE;
icode==CMOVXX:rB;
icode==OPQ:rB;
isRRmovq: rB;
icode==MRMOVQ:rA;
icode==PUSHQ:REG_RSP;
icode==POPQ:REG_RSP;
icode==CALL:REG_RSP;
icode==RET:REG_RSP;
1:REG_NONE;
];

reg_inputE=[
icode==IRMOVQ:valC;
icode == RRMOVQ : reg_outputA;
icode == OPQ : valE;
icode == CMOVXX : valE;
icode == PUSHQ :valE;
icode == POPQ:valE;
icode == CALL:valE;
icode == RET:valE;
icode == POPQ:mem_output;
icode == MRMOVQ: mem_output;
1:reg_outputA;
];

reg_dstM=[
icode==POPQ: rA;
1:REG_NONE;
];
reg_inputM=[
icode == POPQ: mem_output;
1:reg_outputA;
];

register cC {
	   SF: 1 = 0;
       ZF: 1 = 1;
}
stall_C = (icode != OPQ) ;
c_ZF = (valE == 0);
c_SF = (valE >= 0x8000000000000000);

# to make progress, we have to update the PC...
p_pc = [
     icode == NOP : pc+ 1; 
     icode == RRMOVQ : pc+2; 
     icode == RMMOVQ : pc+10;
     icode == IRMOVQ : pc+10; 
     icode == JXX && conditions: valC;
     icode == HALT : pc+1; 
     icode == OPQ : pc+2; 
     icode == CMOVXX : pc+2;
     icode == CALL:valC;
     icode == RET: mem_output;
     1 : valP;
];


mem_addr = [
icode == RMMOVQ : valE;
icode == POPQ:valE-8;
icode == RET:valE-8;
1: valE;
];

mem_readbit = [
icode == MRMOVQ:1;
icode == POPQ:1;
icode == RET:1;
1:0;
];

mem_writebit=[
icode == RMMOVQ : 1;
icode == PUSHQ: 1;
icode == CALL : 1;
1:0;
];

mem_input = [
icode == CALL:P_pc+9;
1:reg_outputA;
];
