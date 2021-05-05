magma.load("primitivize.m")
sigma = magma('[Sym(6) | [3, 5, 4, 6, 2, 1], [2, 3, 1, 5, 6, 4], [5, 4, 3, 2, 1, 6]]')
sigma_prim = magma.Primitivize(sigma)
print(sigma_prim)
