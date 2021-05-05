
// Belyi maps downloaded from the LMFDB on 28 April 2021.
// Magma code for Belyi map with label 6T7-4.2_3.3_2.2.1.1-a


// Group theoretic data

d := 6;
i := 7;
G := TransitiveGroup(d,i);
sigmas := [[Sym(6) | [3, 5, 4, 6, 2, 1], [2, 3, 1, 5, 6, 4], [5, 4, 3, 2, 1, 6]]];
embeddings := [ComplexField(15)![1.0, 0.0]];

// Geometric data

// Define the base field
K<nu> := RationalsAsNumberField();
// Define the curve
X := Curve(ProjectiveSpace(PolynomialRing(K, 2)));
// Define the map
KX<x> := FunctionField(X);
phi := -108*x^2/(x^6 + 12*x^4 - 60*x^2 + 64);