* HSPICE Deck to find leakage currents in a Conventional Full Adder
* Pradeep Nair
* Model source: Arizona State University. Available at http://www.eas.asu.edu/~ptm
.include '32nm.txt'
.tran 1p 60ns
.options post
.temp 100
vSupply Vdd 0 0.9V
vGround Vss 0 0V
.global Vdd
.global Vss
.param tech_lngth=32n
.param wnmos=64n
.param wpmos=160n
*Here, we choose the width of PMOS to be 2.5 times the width of NMOS


*Trnstr Drain Gate Source Substrate Type Width Length
M1 C_1 A Vdd Vdd PMOS W=wpmos L=tech_lngth
M2 C_2 B C_1 Vdd PMOS W=wpmos L=tech_lngth

M3 C_2 B C_3 Vss NMOS W=wnmos L=tech_lngth
M4 C_3 A Vss Vss NMOS W=wnmos L=tech_lngth

M5 C_4 A Vdd Vdd PMOS W=wpmos L=tech_lngth
M6 C_4 B Vdd Vdd PMOS W=wpmos L=tech_lngth
M7 C_2 C_in C_4 Vdd PMOS W=wpmos L=tech_lngth

M8 C_2 C_in C_5 Vss NMOS W=wnmos L=tech_lngth
M9 C_5 A Vss Vss NMOS W=wnmos L=tech_lngth
M10 C_5 B Vss Vss NMOS W=wnmos L=tech_lngth

M11 C_6 A Vdd Vdd PMOS W=wpmos L=tech_lngth
M12 C_6 B Vdd Vdd PMOS W=wpmos L=tech_lngth
M13 C_6 C_in Vdd Vdd PMOS W=wpmos L=tech_lngth
M14 C_7 C_2 C_6 Vdd PMOS W=wpmos L=tech_lngth

M15 C_7 C_2 C_8 Vss NMOS W=wnmos L=tech_lngth
M16 C_8 A Vss Vss NMOS W=wnmos L=tech_lngth
M17 C_8 B Vss Vss NMOS W=wnmos L=tech_lngth
M18 C_8 C_in Vss Vss NMOS W=wnmos L=tech_lngth

M19 C_9 A Vdd Vdd PMOS W=wpmos L=tech_lngth
M20 C_10 B C_9 Vdd PMOS W=wpmos L=tech_lngth
M21 C_7 C_in C_10 Vdd PMOS W=wpmos L=tech_lngth

M22 C_7 C_in C_11 Vss NMOS W=wnmos L=tech_lngth
M23 C_11 A C_12 Vss NMOS W=wnmos L=tech_lngth
M24 C_12 B Vss Vss NMOS W=wnmos L=tech_lngth

M25 C_out C_2 Vdd Vdd PMOS W=wpmos L=tech_lngth
M26 C_out C_2 Vss Vss NMOS W=wnmos L=tech_lngth

M27 Sum C_7 Vdd Vdd PMOS W=wpmos L=tech_lngth
M28 Sum C_7 Vss Vss NMOS W=wnmos L=tech_lngth

C1 Sum Vss 10fF
C2 C_out Vss 10fF

VA A Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage0 rms I(vSupply) FROM=10n TO=15n
.print leakage0

.alter
.tran 1ps 60ns

VA A Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage1 rms I(vSupply) FROM=10n TO=15n
.print leakage1

.alter
.tran 1ps 60ns

VA A Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage2 rms I(vSupply) FROM=10n TO=15n
.print leakage2

.alter
.tran 1ps 60ns

VA A Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage3 rms I(vSupply) FROM=10n TO=15n
.print leakage3

.alter
.tran 1ps 60ns

VA A Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage4 rms I(vSupply) FROM=10n TO=15n
.print leakage4

.alter
.tran 1ps 60ns

VA A Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage5 rms I(vSupply) FROM=10n TO=15n
.print leakage5

.alter
.tran 1ps 60ns

VA A Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage6 rms I(vSupply) FROM=10n TO=15n
.print leakage6

.alter
.tran 1ps 60ns

VA A Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0.9 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage7 rms I(vSupply) FROM=10n TO=15n
.print leakage7


.end