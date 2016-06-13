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



VA A Vss pulse (0 0.9 1.99ns 0.01ns 0.01ns 1.99ns 4ns)
VB B Vss pulse (0 0.9 0.99ns 0.01ns 0.01ns 0.99ns 2ns)
VCin C_in Vss pulse (0 0.9 0.49ns 0.01ns 0.01ns 0.49ns 1ns)


.measure TRAN tdelay1 TRIG V(C_in) val=0.45 rise=1 td=0n TARG V(Sum) val=0.45 rise=1
.measure TRAN tdelay2 TRIG V(C_in) val=0.45 rise=2 td=0n TARG V(Sum) val=0.45 fall=1

.measure TRAN tdelay3 TRIG V(C_in) val=0.45 rise=2 td=0n TARG V(C_out) val=0.45 rise=1
.measure TRAN tdelay4 TRIG V(C_in) val=0.45 fall=2 td=0n TARG V(C_out) val=0.45 fall=1

.print tdelay1
.print tdelay2
.print tdelay3
.print tdelay4

.measure dynpower avg power from 0n to 60n
.print dynpower
.end