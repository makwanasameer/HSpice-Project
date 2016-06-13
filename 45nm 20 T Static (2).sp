* HSPICE Deck to find leakage currents in a Conventional Full Adder
* Pradeep Nair
* Model source: Arizona State University. Available at http://www.eas.asu.edu/~ptm
.include '45nm.txt'
.tran 1p 60ns
.options post
.temp 100
vSupply Vdd 0 1.0V
vGround Vss 0 0V
.global Vdd
.global Vss
.param tech_lngth=45n
.param wnmos=90n
.param wpmos=225n
*Here, we choose the width of PMOS to be 2.5 times the width of NMOS


*Trnstr Drain Gate Source Substrate Type Width Length
M1 C_1 B Vdd Vdd PMOS W=wpmos L=tech_lngth
M2 C_1 B Vss Vss NMOS W=wnmos L=tech_lngth

M3 C_2 A Vdd Vdd PMOS W=wpmos L=tech_lngth
M4 C_2 A Vss Vss NMOS W=wnmos L=tech_lngth

M5 C_3 B A Vdd PMOS W=wpmos L=tech_lngth
M6 C_3 C_1 A Vss NMOS W=wnmos L=tech_lngth 

M7 C_3 C_1 C_2 Vdd PMOS W=wpmos L=tech_lngth
M8 C_3 B C_2 Vss NMOS W=wnmos L=tech_lngth

M9 C_4 C_in Vdd Vdd PMOS W=wpmos L=tech_lngth
M10 C_4 C_in Vss Vss NMOS W=wnmos L=tech_lngth

M11 C_5 C_3 Vdd Vdd PMOS W=wpmos L=tech_lngth
M12 C_5 C_3 Vss Vss NMOS W=wnmos L=tech_lngth

M13 Sum C_3 C_in Vdd PMOS W=wpmos L=tech_lngth
M14 Sum C_5 C_in Vss NMOS W=wnmos L=tech_lngth

M15 Sum C_5 C_4 Vdd PMOS W=wpmos L=tech_lngth
M16 Sum C_3 C_4 Vss NMOS W=wnmos L=tech_lngth

M17 C_out C_5 C_in Vdd PMOS W=wpmos L=tech_lngth
M18 C_out C_3 C_in Vss NMOS W=wnmos L=tech_lngth

M19 C_out C_3 A Vdd PMOS W=wpmos L=tech_lngth
M20 C_out C_5 A Vss NMOS W=wnmos L=tech_lngth


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
VCin C_in Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage1 rms I(vSupply) FROM=10n TO=15n
.print leakage1

.alter
.tran 1ps 60ns

VA A Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage2 rms I(vSupply) FROM=10n TO=15n
.print leakage2

.alter
.tran 1ps 60ns

VA A Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage3 rms I(vSupply) FROM=10n TO=15n
.print leakage3

.alter
.tran 1ps 60ns

VA A Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage4 rms I(vSupply) FROM=10n TO=15n
.print leakage4

.alter
.tran 1ps 60ns

VA A Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage5 rms I(vSupply) FROM=10n TO=15n
.print leakage5

.alter
.tran 1ps 60ns

VA A Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (0 0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage6 rms I(vSupply) FROM=10n TO=15n
.print leakage6

.alter
.tran 1ps 60ns

VA A Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VB B Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
VCin C_in Vss pulse (1.0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)
.measure tran leakage7 rms I(vSupply) FROM=10n TO=15n
.print leakage7

.end