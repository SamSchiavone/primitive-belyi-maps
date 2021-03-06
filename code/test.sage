#magma.load("primitivize.m")
#sigma = magma('[Sym(6) | [3, 5, 4, 6, 2, 1], [2, 3, 1, 5, 6, 4], [5, 4, 3, 2, 1, 6]]')
#sigma_prim = magma.Primitivize(sigma)
#print(sigma_prim)

load("lookup.sage")
import os
os.chdir("/scratch/home/sschiavo/github/lmfdb")
from lmfdb import db
#rec = db.belyi_galmaps.lucky({'deg':6})
#label = "8T17-8_4.4_4.1.1.1.1-a"
#label = "9T13-6.3_6.3_3.3.1.1.1-a"
#label = "9T26-8.1_3.3.1.1.1_6.3-a"
#label = "9T30-9_4.3.2_2.2.2.2.1-a"
#label = "8T16-8_8_2.2.1.1.1.1-a"
#label = "8T16-8_8_2.2.1.1.1.1-a"
label = "4T2-2.2_2.2_2.2-a"
rec = db.belyi_galmaps.lookup(label)
prim_label = look_up_primitivization(rec)
print(prim_label)
