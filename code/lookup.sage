def look_up_primitivization(record):
	#do something with Primitivization in magma?
	#magma_sigmas = ?
	return

def make_sage_sigmas(magma_sigmas):
	sigma_list = list(magma_sigmas)
	sigmas_new = [Permutation(str(el)) for el in sigma_list]
	return sigmas_new

def make_search_data(sigmas_new): #can we rename make_lambdas(sigmas_new)?
	return [el.cycle_type() for el in sigmas_new]



#NEW (AFTER CODING SESSION ON MONDAY 05-10)
def make_search_dicts(group_id, lambdas):
	"""
	Input: group_id (format "xTy"), lambdas ("lambdas")
	Returns list of  6 search dicts with permutations of sigmas_new
	"""
	L = []
	lambdas.sort()
	a = lambdas[0]
	b = lambdas[1]
	c = lambdas[2]
	for perm in [[a,b,c], [a,c,b], [b,a,c], [b,c,a], [c,a,b], [c,b,a]]:
		L.append({"group": group_id, "lambdas":perm})
	return L

#SOMEHOW MUST GET TO LMFDB : from lmfdb import db

def find_prim_record(search_dicts, sigmas_prim, d):
	"""
	Input search_dicts (list of search dicts as in make_search_dicts),
		sigmas_prim (desired triple, in [] permutation notation),
		d where the symmetric group of sigmas_prim is S_d
	Returns corresponding record
	"""
	for D in search_dicts:
		possible_records = list(db.belyi_galmaps.search(D))
		for rec in possible_records:
			triples = rec['triples'][0]
			if are_conjugate(triples, sigmas_prim, d): #??
				return rec

#THIS FUNCTION IS NOT RIGHT -- IDK HOW TO CHECK IF EVERYTHING IS CONJUGATE BY SAME ELEMENT
def are_conjugate(triples, sigmas_prim, d):
	"""
	Input triples, sigmas_prim (notation of triples[0] in db.belyi_galmaps)
		d where the symmetric group is S_d
	Returns True if conjugate, False else
	"""	
	Sd_magma = magma.SymmetricGroup(d)
	for i in range(3):
		val = str( magma.IsConjugate(Sd_magma, triples[i], sigmas_prim[i]) )
		if val != "true":
			return False
	return True
