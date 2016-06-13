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
M1 C_1 B A Vdd PMOS W=wpmos L=tech_lngth
M2 C_1 A C_2 Vss NMOS W=wnmos L=tech_lngth

M3 C_1 A B Vdd PMOS W=wpmos L=tech_lngth
M4 C_2 B Vss Vss NMOS W=wnmos L=tech_lngth

M5 C_3 C_1 Vdd Vdd PMOS W=wpmos L=tech_lngth
M6 C_3 C_1 Vss Vss NMOS W=wnmos L=tech_lngth 

M7 Sum C_1 C_in Vdd PMOS W=wpmos L=tech_lngth
M8 Sum C_3 C_in Vss NMOS W=wnmos L=tech_lngth

M9 Sum C_in C3 Vdd PMOS W=wpmos L=tech_lngth
M10 Sum C_in C1 Vss NMOS W=wnmos L=tech_lngth

M11 C_out C_3 C_in Vdd PMOS W=wpmos L=tech_lngth
M12 C_out C_1 C_in Vss NMOS W=wnmos L=tech_lngth

M13 C_out C_1 A Vdd PMOS W=wpmos L=tech_lngth
M14 C_out C_3 A Vss NMOS W=wnmos L=tech_lngth



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