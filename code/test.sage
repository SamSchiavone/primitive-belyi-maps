#magma.load("primitivize.m")
#sigma = magma('[Sym(6) | [3, 5, 4, 6, 2, 1], [2, 3, 1, 5, 6, 4], [5, 4, 3, 2, 1, 6]]')
#sigma_prim = magma.Primitivize(sigma)
#print(sigma_prim)

load("lookup.sage")
import os
os.chdir("/scratch/home/sschiavo/github/lmfdb")
from lmfdb import db
rec = db.belyi_galmaps.lucky({'deg':6})
rec_prim = look_up_primitivization(rec)
