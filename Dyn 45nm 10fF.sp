* 32nm
.include'45nm.txt'
.tran 1ps 60ns
.options post
.temp 100

vSupply Vdd 0 1.0V
vGround Vss 0 0V
.global Vdd
.global Vss

.param tech_lngth=45n
.param wnmos=90n
.param wpmos=225n


.subckt AND3 AND3_in1 AND3_in2 AND3_in3 AND3_out

M1 3NAND_out AND3_in1 Vdd Vdd PMOS W=wpmos L=tech_lngth
M2 3NAND_out AND3_in2 Vdd Vdd PMOS W=wpmos L=tech_lngth
M3 3NAND_out AND3_in3 Vdd Vdd PMOS W=wpmos L=tech_lngth
M4 AND3_out 3NAND_out Vdd Vdd PMOS W=wpmos L=tech_lngth

M5 3NAND_out AND3_in1 N1 Vss NMOS W=wnmos L=tech_lngth
M6 N1 AND3_in2 N2 Vss NMOS W=wnmos L=tech_lngth
M7 N2 AND3_in3 Vss Vss NMOS W=wpmos L=tech_lngth
M8 AND3_out 3NAND_out Vss Vss NMOS W=wpmos L=tech_lngth
.ends


.subckt OR4 OR4_in1 OR4_in2 OR4_in3 OR4_in4 OR4_out

M9 N3 OR4_in1 Vdd Vdd PMOS W=wpmos L=tech_lngth
M10 N4 OR4_in2 N3 Vdd PMOS W=wpmos L=tech_lngth
M11 N5 OR4_in3 N4 Vdd PMOS W=wpmos L=tech_lngth
M12 4NOR_out OR4_in4 N5 Vdd PMOS W=wpmos L=tech_lngth
M13 OR4_out 4NOR_out Vdd Vdd PMOS W=wpmos L=tech_lngth

M14 4NOR_out OR4_in1 Vss Vss NMOS W=wnmos L=tech_lngth
M15 4NOR_out OR4_in2 Vss Vss NMOS W=wnmos L=tech_lngth
M16 4NOR_out OR4_in3 Vss Vss NMOS W=wnmos L=tech_lngth
M17 4NOR_out OR4_in4 Vss Vss NMOS W=wnmos L=tech_lngth
M18 OR4_out 4NOR_out Vss Vss NMOS W=wnmos L=tech_lngth
.ends


.subckt AND2 AND2_in1 AND2_in2 AND2_out

M19 2NAND_out AND2_in1 Vdd Vdd PMOS W=wpmos L=tech_lngth
M20 2NAND_out AND2_in2 Vdd Vdd PMOS W=wpmos L=tech_lngth
M21 AND2_out 2NAND_out Vdd Vdd PMOS W=wpmos L=tech_lngth

M22 2NAND_out AND2_in1 N6 Vss NMOS W=wnmos L=tech_lngth
M23 N6 AND2_in2 Vss Vss NMOS W=wnmos L=tech_lngth
M24 AND2_out 2NAND_out Vss Vss NMOS W=wpmos L=tech_lngth
.ends

.subckt OR3 OR3_in1 OR3_in2 OR3_in3 OR3_out

M25 N7 OR3_in1 Vdd Vdd PMOS W=wpmos L=tech_lngth
M26 N8 OR3_in2 N7 Vdd PMOS W=wpmos L=tech_lngth
M27 3NOR_out OR3_in3 N8 Vdd PMOS W=wpmos L=tech_lngth
M28 OR3_out 3NOR_out Vdd Vdd PMOS W=wpmos L=tech_lngth

M29 3NOR_out OR3_in1 Vss Vss NMOS W=wnmos L=tech_lngth
M30 3NOR_out OR3_in2 Vss Vss NMOS W=wnmos L=tech_lngth
M31 3NOR_out OR3_in3 Vss Vss NMOS W=wnmos L=tech_lngth
M32 OR3_out 3NOR_out Vss Vss NMOS W=wnmos L=tech_lngth
.ends


.subckt INVERTER Inv_in Inv_out
M33 Inv_out Inv_in Vdd Vdd PMOS W=wpmos L=tech_lngth
M34 Inv_out Inv_in Vss Vss NMOS W=wnmos L=tech_lngth
.ends



Xinverter_1 A Invert_A INVERTER
Xinverter_2 B Invert_B INVERTER
Xinverter_3 Cin Invert_Cin INVERTER
Xand3_1 Invert_A Invert_B Cin AND31_out AND3
Xand3_2 Invert_A B Invert_Cin AND32_out AND3
Xand3_3 A Invert_B Invert_Cin AND33_out AND3
Xand3_4 A B Cin AND34_out AND3
Xor4_1 AND31_out AND32_out AND33_out AND34_out sum OR4
Xand2_1 A B AND21_out AND2
Xand2_2 A Cin AND22_out AND2
Xand2_3 B Cin AND23_out AND2
XOR3_1 AND21_out AND22_out AND23_out Cout OR3
C1 sum Vss 10fF
C2 Cout Vss 10fF


VA A Vss pulse (0 1.0 1.99ns 0.01ns 0.01ns 1.99ns 4ns)
VB B Vss pulse (0 1.0 0.99ns 0.01ns 0.01ns 0.99ns 2ns)
VCin Cin Vss pulse (0 1.0 0.49ns 0.01ns 0.01ns 0.49ns 1ns)



.measure TRAN tdelay1 TRIG V(Cin) val=0.5 rise=1 td=0n TARG V(sum) val=0.5 rise=1
.measure TRAN tdelay2 TRIG V(Cin) val=0.5 rise=2 td=0n TARG V(sum) val=0.5 fall=1

.measure TRAN tdelay3 TRIG V(Cin) val=0.5 rise=2 td=0n TARG V(Cout) val=0.5 rise=1
.measure TRAN tdelay4 TRIG V(Cin) val=0.5 fall=2 td=0n TARG V(Cout) val=0.5 fall=1

.print tdelay1
.print tdelay2
.print tdelay3
.print tdelay4

.measure dynpower avg power from 0n to 60n
.print dynpower

.end
