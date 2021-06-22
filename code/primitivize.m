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
