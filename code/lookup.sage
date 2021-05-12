def look_up_primitivization(record):
	#1) Compute primitivization (using Katie's Magma code)
    #

    #2) Make search dicts using primitivization
    #group_id = make_search_data(sigmas_new)[1]
    #lambdas = make_search_data(sigmas_new)[0]
    #search_dicts = make_search_dicts(group_id, lambdas)

    #3) Find primitivization's record -- requires are_conjugate to work
	#magma_sigmas = ?
	return

def make_sage_sigmas(magma_sigmas):
    sigma_list = list(magma_sigmas)
    sigmas_new = [Permutation(str(el)) for el in sigma_list]
    return sigmas_new

def make_magma_sigmas(sigma_sage):
    S = sigma_sage[0].parent()
    d = S.degree()
    magma_string = '[Sym(%s) | %s, %s, %s]' % (d, sigma_sage[0], sigma_sage[1], sigma_sage[2])
    return magma(magma_string)

def make_search_data(sigmas_new):
    group_id = magma.TransitiveGroupIdentification(G, nvals=2) # use this to get transitive group number
    return ([el.cycle_type() for el in sigmas_new], group_id)


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


def find_prim_record(search_dicts, sigmas_prim, d):
    """
    Input search_dicts (list of search dicts as in make_search_dicts),
        sigmas_prim (desired triple, in [] permutation notation),
        d where the symmetric group of sigmas_prim is S_d
    Returns corresponding record
    """
    #open lmfdb -- only works on my computer though
    import os
    os.chdir("/scratch/home/ahoey/lmfdb")
    from lmfdb import db    

    for D in search_dicts:
        possible_records = list(db.belyi_galmaps.search(D))
        for rec in possible_records:
            triples = rec['triples'][0]
            if are_conjugate(triples, sigmas_prim, d): #??
                return rec

#THIS FUNCTION IS NOT RIGHT -- IDK HOW TO CHECK IF EVERYTHING IS CONJUGATE BY SAME ELEMENT
def are_conjugate(triples, sigmas_prim):
	"""
	Input triples, sigmas_prim (notation of triples[0] in db.belyi_galmaps)
	Returns True if conjugate, False else
	"""	
    S = sigmas_prim[0].parent()
    d = S.degree()
	Sd_magma = magma.SymmetricGroup(d)
	val = str( magma.IsConjugate(Sd_magma, make_magma_sigmas(triples), make_magma_sigmas(sigmas_prim)) )
	if val != "true":
			return False
	return True
