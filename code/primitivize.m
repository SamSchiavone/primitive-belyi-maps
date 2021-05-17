function Primitivize(sigma)
  S := Parent(sigma[1]);
  G := sub< S | sigma>;
  if IsPrimitive(G) then
    return sigma;
  end if;
  partition := MinimalPartition(G);
  G_prim := BlocksImage(G,partition); //does the thing but better
  assert #GeneratorsSequence(G_prim) eq 3;
  return GeneratorsSequence(G_prim);
end function;
