######### MAX RYOO ##########
######### The PC #############
register fF { prediction:64 = 0; }

register cC {
SF:1 = 0;
ZF:1 = 1;
}


########## Fetch #############
pc = [
M_wjmp: M_valP;
W_icode == RET: W_valM;
1: F_prediction;
];

wire icode:4;
wire ifun:4;
wire rA:4;
wire rB:4;
wire valC:64;

f_icode = icode;
f_ifun=ifun;
f_rA = rA;
f_rB = rB;
f_valC = valC;
f_valP=valP;

icode = i10bytes[4..8];
ifun= i10bytes[0..4];
rA = i10bytes[12..16];
rB = i10bytes[8..12];

wire offset:64, valP:64;
offset = [
icode in { HALT, NOP, RET } : 1;
icode in { RRMOVQ, OPQ, PUSHQ, POPQ } : 2;
icode in { JXX, CALL } : 9;
1 : 10;
];

valC = [
icode in { JXX, CALL } : i10bytes[8..72];
1 : i10bytes[16..80];
];


valP = pc + offset;

f_prediction = [
icode == JXX:valC;
icode == CALL:valC;
1:valP;
];

f_stat = [
f_icode == HALT : STAT_HLT;
f_icode > 0xb : STAT_INS;
1 : STAT_AOK;
];


wire checkret:1;
checkret=(D_icode==RET||E_icode==RET||M_icode==RET);

########## Decode #############
register fD {
icode:4 = NOP;
ifun:4=0;
rA:4 = REG_NONE;
rB:4 = REG_NONE;
valC:64 = 0;
stat:3 = STAT_BUB;
valP:64 = 0;
}

reg_srcA = [
D_icode == RRMOVQ:D_rA;
D_icode == CMOVXX:D_rA;
D_icode == RMMOVQ:D_rA;
D_icode == OPQ:D_rA;
D_icode == PUSHQ:D_rA;
D_icode == POPQ:D_rA;
1 : REG_NONE;
];

reg_srcB = [
D_icode == RRMOVQ:D_rB;
D_icode == CMOVXX:D_rB;
D_icode == IRMOVQ:D_rB;
D_icode == RMMOVQ:D_rB;
D_icode == MRMOVQ:D_rB;
D_icode == OPQ:D_rB;
D_icode == PUSHQ:REG_RSP;
D_icode == POPQ:REG_RSP;
D_icode == CALL:REG_RSP;
D_icode == RET:REG_RSP;
1 : REG_NONE;
];

d_dstM = [
D_icode == MRMOVQ  : D_rA;
D_icode == POPQ: D_rA;
1 : REG_NONE;
];

d_dstE = [
D_icode == IRMOVQ:D_rB;
D_icode == RRMOVQ:D_rB;
D_icode == CMOVXX:D_rB;
D_icode == OPQ:D_rB;
D_icode == PUSHQ:REG_RSP;
D_icode == POPQ:REG_RSP;
D_icode == CALL:REG_RSP;
D_icode == RET:REG_RSP;
1 : REG_NONE;
];

d_valA = [
reg_srcA == REG_NONE: 0;
reg_srcA==e_dstE:e_valE;
reg_srcA==m_dstE:m_valE;
reg_srcA == m_dstM : m_valM;
reg_srcA == W_dstM : W_valM;
reg_srcA == W_dstE: W_valE;
1 : reg_outputA;
];

d_valB = [
reg_srcB == REG_NONE: 0;
reg_srcB==e_dstE:e_valE;
reg_srcB==m_dstE:m_valE;
reg_srcB == m_dstM : m_valM;
reg_srcB == W_dstM : W_valM;
reg_srcB == W_dstE : W_valE;
1 : reg_outputB;
];

d_stat = D_stat;
d_icode = D_icode;
d_ifun=D_ifun;
d_rA=D_rA;
d_rB=D_rB;
d_valC = D_valC;
d_valP=D_valP;


########## Execute #############
register dE {
icode:4 = NOP;
ifun:4=0;
rA:4=REG_NONE;
rB:4=REG_NONE;
valA:64 = 0;
valB:64 = 0;
valC:64 = 0;
dstE:4 = REG_NONE;
dstM:4 = REG_NONE;
stat:3 = STAT_BUB;
valP:64 = 0;
}

e_stat =  E_stat;
e_icode = E_icode;
e_ifun=E_ifun;
e_valA = E_valA;
e_valB=E_valB;
e_valC=E_valC;
e_dstM = E_dstM;
e_valP = E_valP;

e_valE = [
E_icode == RMMOVQ: E_valC + E_valB;
E_icode == MRMOVQ: E_valC + E_valB;
(E_icode==OPQ && E_ifun==XORQ): E_valA^E_valB;
(E_icode==OPQ && E_ifun==ADDQ): E_valA+E_valB;
(E_icode==OPQ && E_ifun==SUBQ): E_valB-E_valA;
(E_icode==OPQ && E_ifun==ANDQ): E_valA&E_valB;
(E_icode==RMMOVQ||E_icode==MRMOVQ): E_valB+E_valC;
E_icode==PUSHQ: E_valB-8;
E_icode==POPQ: E_valB+8;
E_icode==CALL: E_valB-8;
E_icode==RET: E_valB+8;
E_icode==IRMOVQ: E_valC;
E_icode==CMOVXX: E_valA;
1 : 0;
];

c_ZF = (e_valE == 0);
c_SF = (e_valE >= 0x8000000000000000);
stall_C = (e_icode != OPQ) || M_wjmp;

e_conditions=[
E_ifun==LE: C_SF||C_ZF;
E_ifun==LT: C_SF;
E_ifun==EQ: C_ZF;
E_ifun==NE: !C_ZF;
E_ifun==GE: !C_SF;
E_ifun==GT: (!C_ZF)&&(!C_SF);
!(E_icode in {JXX,CMOVXX}):1;
1:1;
];

e_dstE = [
(!e_conditions && E_icode==CMOVXX):REG_NONE;
1 : E_dstE;
];

e_wjmp=[
(E_icode==JXX&&!e_conditions):1;
1:0;
];

########## Memory #############
register eM {
stat:3 = STAT_BUB;
icode:4 = NOP;
ifun:4=0;
valC:64=0;
valE:64 = 0;
valA:64 = 0;
valB:64=0;
dstE:4=REG_NONE;
dstM:4 = REG_NONE;
conditions:1=0;
wjmp:1=0;
valP:64=0;
}


mem_addr = [
M_icode == RMMOVQ : M_valE;
M_icode == MRMOVQ : M_valE;
M_icode == PUSHQ : M_valE;
M_icode == CALL : M_valE;
M_icode == POPQ:M_valB;
M_icode == RET: M_valB;
1 : 0;
];

mem_readbit =  M_icode in {MRMOVQ, POPQ, RET};
mem_writebit = M_icode in {RMMOVQ, PUSHQ, CALL};
mem_input = [
M_icode == CALL: M_valP;
1:M_valA;
];

m_stat = M_stat;
m_valA=M_valA;
m_valM = mem_output;
m_dstM = M_dstM;
m_icode = M_icode;
m_valC=M_valC;
m_valE=M_valE;
m_dstE=M_dstE;


########## Writeback #############
register mW {
icode:4 = NOP;
valA:64=0;
valM:64 = 0;
valC:64=0;
valE:64=0;
dstE:4=REG_NONE;
dstM:4 = REG_NONE;
stat:3 = STAT_BUB;
}

reg_dstE = W_dstE;
Stat = W_stat;

reg_inputE = [
W_icode == CMOVXX : W_valA;
W_icode == IRMOVQ : W_valC;
W_icode == OPQ: W_valE;
W_icode == POPQ: W_valE;
W_icode == PUSHQ: W_valE;
W_icode == CALL: W_valE;
W_icode == RET: W_valE;
1: 0xBADBADBAD;
];

reg_inputM = W_valM;
reg_dstM = W_dstM;


################ Pipeline Register Control #########################

wire load:1;

load = [
E_dstM == REG_NONE:0;
reg_srcA == E_dstM : 1;
reg_srcB == E_dstM : 1;
1 : 0;
];

stall_F = load || f_stat != STAT_AOK || (checkret&&!bubble_D&&!bubble_E&&!bubble_M);


stall_D = load;
bubble_D=checkret&&!load&&!bubble_E&&!bubble_M;

bubble_E = load||M_wjmp;

bubble_M = M_wjmp;
