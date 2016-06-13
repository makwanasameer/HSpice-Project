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



VA A Vss pulse (0 1.0 1.99ns 0.01ns 0.01ns 1.99ns 4ns)
VB B Vss pulse (0 1.0 0.99ns 0.01ns 0.01ns 0.99ns 2ns)
VCin C_in Vss pulse (0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)


.measure TRAN tdelay1 TRIG V(C_in) val=0.5 rise=1 td=0n TARG V(Sum) val=0.5 rise=1
.measure TRAN tdelay2 TRIG V(C_in) val=0.5 rise=2 td=0n TARG V(Sum) val=0.5 fall=1

.measure TRAN tdelay3 TRIG V(C_in) val=0.5 rise=2 td=0n TARG V(C_out) val=0.5 rise=1
.measure TRAN tdelay4 TRIG V(C_in) val=0.5 fall=2 td=0n TARG V(C_out) val=0.5 fall=1

.print tdelay1
.print tdelay2
.print tdelay3
.print tdelay4

.measure dynpower avg power from 0n to 60n
.print dynpower
.end