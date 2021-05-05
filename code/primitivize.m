function Primitivize(sigma)
  S := Parent(sigma[1]);
  G := sub< S | sigma>;
  partition := MinimalPartition(G);
  if IsPrimitive(G) then
    return sigma;
  end if;
  G_prim := BlocksImage(G,partition); //does the thing but better
  assert #GeneratorsSequence(G_prim) eq 3;
  return GeneratorsSequence(G_prim);
end function;
