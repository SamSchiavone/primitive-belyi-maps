sigma :=
  [Sym(12)|
    (1, 8)(4, 11)(5, 10)(6, 12)(7, 9),
    (1, 6, 3, 4)(2, 5, 8, 7)(9, 10, 12, 11),
    (1, 5, 9, 8, 4, 12)(2, 7, 11, 3, 6, 10)
  ];
G := sub< Sym(12) | sigma>;
MinimalPartition(G);
partition := $1;
//GSet(G,partition);
//X := $1;
//G_prim := ActionImage(G,X);
//G_prim;
//StandardGroup(G_prim);
BlocksImage(G,partition);
G_prim := $1;
sigma_prim := GeneratorsSequence(G_prim);
//hom< G -> G_prim | sigma[1] -> sigma_prim[1], sigma[2] -> sigma_prim[2], sigma[3] -> sigma_prim[3]>;
//hom< G -> G_prim | sigma_prim>;
BlocksAction(G,partition);
hom_prim := $1;

// verify against LMFDB

sigmas := [[Sym(6) | [3, 5, 4, 6, 2, 1], [2, 3, 1, 5, 6, 4], [5, 4, 3, 2, 1, 6]]];
sigma_lmfdb := sigmas[1];

// reorder permutation
sigma_prim := [sigma_prim[2], sigma_prim[3], sigma_prim[1]];
IsConjugate(Sym(6), sigma_prim, sigma_lmfdb);
