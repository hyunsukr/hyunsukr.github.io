######### MAX RYOO ##########
######### The PC #############
register fF { pc:64 = 0; }

register cC {
SF:1 = 0;
ZF:1 = 1;
}


########## Fetch #############
pc = F_pc;

wire icode:4;
wire ifun:4;
wire rA:4;
wire rB:4;
wire valC:64;

icode = i10bytes[4..8];
ifun= i10bytes[0..4];
rA = i10bytes[12..16];
rB = i10bytes[8..12];

f_icode = icode;
f_ifun=ifun;
f_rA = rA;
f_rB = rB;
f_valC = valC;

wire offset:64, valP:64;
offset = [
icode in { HALT, NOP, RET } : 1;
icode in { RRMOVQ, OPQ, PUSHQ, POPQ } : 2;
icode in { JXX, CALL } : 9;
1 : 10;
];
valP = F_pc + offset;
f_pc = valP;

f_stat = [
f_icode == HALT : STAT_HLT;
f_icode > 0xb : STAT_INS;
1 : STAT_AOK;
];

valC = [
icode in { JXX, CALL } : i10bytes[8..72];
1 : i10bytes[16..80];
];

########## Decode #############
register fD {
icode:4 = NOP;
ifun:4=0;
rA:4 = REG_NONE;
rB:4 = REG_NONE;
valC:64 = 0;
stat:3 = STAT_BUB;
}

reg_srcA = [
D_icode == RMMOVQ:D_rA;
D_icode == CMOVXX:D_rA;
D_icode == RMMOVQ:D_rA;
D_icode == MRMOVQ:D_rA;
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
1 : REG_NONE;
];

d_dstM = [
D_icode == MRMOVQ  : D_rA;
1 : REG_NONE;
];

d_dstE = [
D_icode == IRMOVQ:D_rB;
D_icode == RRMOVQ:D_rB;
D_icode == CMOVXX:D_rB;
D_icode == OPQ:D_rB;
1 : REG_NONE;
];

d_valA = [
reg_srcA == REG_NONE: 0;
reg_srcA == m_dstM : m_valM;
reg_srcA == W_dstM : W_valM;
(reg_srcA==e_dstE)&&
(e_dstE!=REG_NONE):e_valE;
(reg_srcA==m_dstE)&&
(m_dstE!=REG_NONE):m_valE;
(reg_dstE==reg_srcA)&&
(reg_dstE!=REG_NONE):reg_inputE;
1 : reg_outputA;
];

d_valB = [
reg_srcB == REG_NONE: 0;
reg_srcB == m_dstM : m_valM;
reg_srcB == W_dstM : W_valM;
(reg_srcB==e_dstE)&&
(e_dstE!=REG_NONE):e_valE;
(reg_srcB==m_dstE)&&
(m_dstE!=REG_NONE):m_valE;
(reg_dstE==reg_srcB)&&
(reg_dstE!=REG_NONE):reg_inputE;
1 : reg_outputB;
];

d_stat = D_stat;
d_icode = D_icode;
d_ifun=D_ifun;
d_rA=D_rA;
d_rB=D_rB;
d_valC = D_valC;


########## Execute #############
register dE {
icode:4 = NOP;
ifun:4=0;
rA:4=REG_NONE;
rB:4=REG_NONE;
valA:64 = 0;
valB:64 = 0;
valC:64 = 0;
dstE:4=REG_NONE;
dstM:4 = REG_NONE;
stat:3 = STAT_BUB;
}

e_stat =  E_stat;
e_icode = E_icode;
e_ifun=E_ifun;
e_valA = E_valA;
e_valB=E_valB;
e_valC=E_valC;
e_dstM = E_dstM;

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
E_icode==CALL: E_valA-8;
E_icode==RET: E_valA+8;
E_icode==IRMOVQ: E_valC;
E_icode==CMOVXX: E_valA;
1 : 0;
];

c_ZF = (e_valE == 0);
c_SF = (e_valE >= 0x8000000000000000);
stall_C = (e_icode != OPQ);

e_conditions=[
E_ifun==LE: C_SF||C_ZF;
E_ifun==LT: C_SF;
E_ifun==EQ: C_ZF;
E_ifun==NE: !C_ZF;
E_ifun==GE: !C_SF;
E_ifun==GT: (!C_ZF)&&(!C_SF);
1:1;
];

e_dstE = [
(!e_conditions && E_icode==CMOVXX):REG_NONE;
1 : E_dstE;
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
}


mem_addr = [
M_icode == RMMOVQ : M_valE;
M_icode == MRMOVQ : M_valE;
1 : 0;
];

mem_readbit =  M_icode == MRMOVQ;
mem_writebit = M_icode == RMMOVQ;
mem_input = M_valA;

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
1: 0xBADBADBAD;
];

reg_inputM = W_valM;
reg_dstM = W_dstM;



################ Pipeline Register Control #########################

wire load:1;

load = (E_icode in {MRMOVQ}) && (E_dstM in {reg_srcA, reg_srcB});

stall_F = load || f_stat != STAT_AOK;

stall_D = load;

bubble_E = load;

