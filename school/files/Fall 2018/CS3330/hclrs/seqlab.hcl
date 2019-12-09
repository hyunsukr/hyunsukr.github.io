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
icode==JXX:i10bytes[8..72];
icode == RMMOVQ : i10bytes[16..80];
icode == IRMOVQ : i10bytes[16..80];
1:0;
];

valE=[
icode == OPQ && ifun == XORQ : reg_outputA ^ reg_outputB;
icode == OPQ && ifun == ANDQ : reg_outputA & reg_outputB;
icode == OPQ && ifun == ADDQ : reg_outputA + reg_outputB;
icode == OPQ && ifun == SUBQ : reg_outputB - reg_outputA;
icode == RMMOVQ : reg_outputB + valC;
icode == CMOVXX : reg_outputA;
1:0;
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

reg_srcA = rA;
reg_srcB= rB;

reg_dstE = [
(icode==IRMOVQ ||(iscmovXX && conditions)|| icode==OPQ || isRRmovq) : rB;
1:REG_NONE;
];

reg_inputE=[
icode==IRMOVQ:valC;
icode == RRMOVQ : reg_outputA;
icode == OPQ : valE;
icode == CMOVXX : valE;
1:0;
];

register cC {
	  SF: 1 = 0;
	   ZF : 1 =1;
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
     icode == JXX : valC;
     icode == HALT : pc+1; 
     icode == OPQ : pc+2; 
     icode == CMOVXX : pc+2; 
     1 : pc+10; # you may use math ops directly...
];


mem_addr = [
icode == RMMOVQ : valE;
1: 0;
];

mem_readbit = [
icode == RMMOVQ : 0;
1:0;
];

mem_writebit=[
icode == RMMOVQ : 1;
1:0;
];

mem_input = [
icode == RMMOVQ : reg_outputA;
1:0;
];
