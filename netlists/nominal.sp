Gate sizing characterization: nominal
**********************************Libs**********************************
.inc	'../models/32nm_bulk.pm'	32n
*********************************INPUTS*********************************
Vs	vdd GND   vd
VA	A	0	Pulse	0	vd	0	t	t	100n	200n
*********************************Inverter*******************************
.SUBCKT	INV	in	out size=1

Vsupply	Vdin	GND	vd

M1	out	in	GND		GND		nmos	L=Lmin	W='size*Wnmos'
M2	out	in	Vdin	Vdin	pmos	L=Lmin	W='size*Wpmos'

.ENDS INV
**********************************NAND2*********************************
.SUBCKT NAND2 in1 in2 out size=1

Vsupply Vdin GND vd

M1 out in1 n1 GND nmos L=Lmin W='size*Wnmos'
M2 n1 in2 GND GND nmos L=Lmin W='size*Wnmos'
M3 out in1 Vdin Vdin pmos L=Lmin W='size*Wpmos'
M4 out in2 Vdin Vdin pmos L=Lmin W='size*Wpmos'

.ENDS NAND2
**********************************NAND3*********************************
.SUBCKT NAND3 in1 in2 in3 out size=1

Vsupply Vdin GND vd

M1 out in1 n1 GND nmos L=Lmin W='size*Wnmos'
M2 n1 in2 n2 GND nmos L=Lmin W='size*Wnmos'
M3 n2 in3 GND GND nmos L=Lmin W='size*Wnmos'
M4 out in1 Vdin Vdin pmos L=Lmin W='size*Wpmos'
M5 out in2 Vdin Vdin pmos L=Lmin W='size*Wpmos'
M6 out in3 Vdin Vdin pmos L=Lmin W='size*Wpmos'

.ENDS NAND3
***********************************NOR2*********************************
.SUBCKT NOR2 in1 in2 out size=1

Vsupply Vdin GND vd

M1 out in1 GND GND nmos L=Lmin W='size*Wnmos'
M2 out in2 GND GND nmos L=Lmin W='size*Wnmos'
M3 out in1 n1 Vdin pmos L=Lmin W='size*Wpmos'
M4 n1 in2 Vdin Vdin pmos L=Lmin W='size*Wpmos'

.ENDS NOR2
*********************************CIRCUIT********************************
X2iNand1   A   vdd  m        NAND2      size=8 
X3iNand1   m   vdd  vdd  n   NAND3      size=y     
X3iNand2   m   vdd  vdd  i   NAND3      size=y     
X3iNand3   m   vdd  vdd  j   NAND3      size=y     
X2iNOR1    n   GND  out      NOR2       size=x    
X2iNOR2    n   GND  k        NOR2       size=x    
XINV1      out l             INV        size=60
*******************************PARAMETERS*******************************
.param  Lmin = 32n
+ Wmin = 32n
+ Wnmos = Wmin
+ Wpmos = '2*Wmin'
+ vd = 1.8V
+ t = 10p
+ x = 12
+ y = 8
******************************SIMULATION********************************
.op
.tran	    1p	    800n
.print V(A) V(m) V(n) V(out) V(l) V(k) V(j) V(i)

.end