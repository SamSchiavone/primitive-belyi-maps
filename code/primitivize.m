function Primitivize(sigma)
  S := Parent(sigma[1]);
  G := sub< S | sigma>;
  prim_bool := IsPrimitive(G);
  if prim_bool then
    return sigma, prim_bool;
  end if;
  //partition := MinimalPartition(G);
  partition := MaximalPartition(G);
  G_prim := BlocksImage(G,partition); //does the thing but better
  assert #GeneratorsSequence(G_prim) eq 3;
  return GeneratorsSequence(G_prim), prim_bool;
end function;

function Primitivizations(sigma)
  S := Parent(sigma[1]);
  G := sub< S | sigma >;
  if IsPrimitive(G) then
    return [ sigma ], true;
  end if;
  blocks := AllPartitions(G);        // one block per nontrivial system
  m := Max([ #B : B in blocks ]);    // largest blocks = minimal degree
  out := [];
  for B in [ B : B in blocks | #B eq m ] do
    f := BlocksAction(G, MinimalPartition(G : Block := B));
    Append(~out, [ f(s) : s in sigma ]);
  end for;
  return out, false;
end function;

function AllPrimitivizations(sigma)
  S := Parent(sigma[1]);
  G := sub< S | sigma >;
  if IsPrimitive(G) then
    return [ sigma ], true;
  end if;
  blocks := AllPartitions(G);
  maximal := [ B : B in blocks | not exists{ C : C in blocks | B subset C and B ne C } ];
  out := [* *];
  for B in maximal do
    f := BlocksAction(G, MinimalPartition(G : Block := B));
    Append(~out, [ f(s) : s in sigma ]);
  end for;
  return out, false;
end function;

//sigma := [Sym(6) | (1,3,5)(2,4,6), (1,2)(3,6)(4,5), (1,4)(2,3)(5,6)];
