def look_up_prim_labels(label):
    import os
    os.chdir("/scratch/home/ahoey/lmfdb")
    from lmfdb import db

def look_up_primitivization(record):
    d = record["deg"]    
    S = SymmetricGroup(d)
    print("finding primitivization for %s" % record['label'])

    #1) Compute primitivization (using Katie's Magma code)
    sigmas_orig_str = record["triples"][0]
    sigmas_orig = [S(elt) for elt in sigmas_orig_str]
    print("original triple = %s" % sigmas_orig)
    sigmas_orig_magma = make_magma_sigmas(sigmas_orig, d)
    print("original triple magma = %s" % sigmas_orig_magma)

    magma.load("primitivize.m") # do we need to change directory here?
    sigmas_prim_magma = magma.Primitivize(sigmas_orig_magma, nvals=2)
    prim_bool = sigmas_prim_magma[1]
    prim_bool = (str(prim_bool) == "true")
    sigmas_prim_magma = sigmas_prim_magma[0]
    if prim_bool: # if original record was primitive, just return it
        return record
    d_prim = magma.Degree(magma.Parent(sigmas_prim_magma[1]))
    print("magma sigma_prim = %s" % sigmas_prim_magma) # printing
    sigmas_prim = make_sage_sigmas(sigmas_prim_magma, d_prim)
    print("sage sigma_prim = %s" % sigmas_prim) # printing

    #2) Make search dicts using primitivization
    search_data = make_search_data(sigmas_prim, d_prim)
    group_id = search_data[1]
    print("primitive group id = %s" % group_id)
    lambdas = search_data[0]
    print("primitive partitions = %s" % lambdas)
    search_dicts = make_search_dicts(group_id, lambdas)

    #3) Find primitivization's record -- requires are_conjugate to work
    new_rec = find_prim_record(search_dicts, sigmas_prim, d_prim)
    return new_rec

def make_sage_sigmas(magma_sigmas, d):
    S = SymmetricGroup(d)
    sigma_list = list(magma_sigmas)
    sigmas_new = []
    for el in sigma_list:
        if str(el) == 'Id($)': # deal with identity
            sigmas_new.append(S([]))
        else:
            sigmas_new.append(S(str(el)))
    #sigmas_new = [S(str(el)) for el in sigma_list]
    return sigmas_new

#Here, sigma_sage is formatted as [Permutation, Permutation, Permutation]
def make_magma_sigmas(sigma_sage, d):
    """
    Input: a list of 3 (Sage) permutations
    Output: a Magma object of the 3 permutations
    """
    #S = sigma_sage[0].parent()
    #d = S.degree()
    sigma_clean = []
    for el in sigma_sage:
        if str(el) == "()": # deal with identity
            sigma_clean.append("1")
        else:
            sigma_clean.append(str(el))
    magma_string = '[Sym(%s) | %s, %s, %s]' % (d, sigma_clean[0], sigma_clean[1], sigma_clean[2])
    return magma(magma_string)

def make_search_data(sigmas_new, d):
    sigma_mag = make_magma_sigmas(sigmas_new, d)
    mag_str = 'sub< Sym(%s) | %s, %s, %s>' % (d, sigma_mag[1], sigma_mag[2], sigma_mag[3])
    G = magma(mag_str) 
    group_id = magma.TransitiveGroupIdentification(G, nvals=2) # use this to get transitive group number
    group_str = "%sT%s" % (group_id[1], group_id[0])
    return ([list(el.cycle_type()) for el in sigmas_new], group_str)

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
    #os.chdir("/scratch/home/ahoey/lmfdb")
    os.chdir("/scratch/home/sschiavo/github/lmfdb")
    from lmfdb import db    

    for D in search_dicts:
        possible_records = list(db.belyi_galmaps.search(D))
        print("number of possible matches = %s" % len(possible_records))
        for rec in possible_records:
            triples = rec['triples'][0]
            if are_conjugate(triples, sigmas_prim, d): #??
                return rec

def are_conjugate(triples, sigmas_prim, d):
    """
    Input triples, sigmas_prim (notation of triples[0] in db.belyi_galmaps), d = degree
    Returns True if conjugate, False else
    """	
    #S = sigmas_prim[0].parent()
    #d = S.degree()
    Sd_magma = magma.SymmetricGroup(d)
    val = str( magma.IsConjugate(Sd_magma, make_magma_sigmas(triples,d), make_magma_sigmas(sigmas_prim,d)) )
    if val != "true":
        return False
    return True

#def write_primitive(rec):
#    prim_label = look_up_primitivization(rec)
#    jobs = open('primitive_results.txt')
#    jobs.write('{f_in} | {f_out}\n'.format(f_in = label, f_out = prim_label))
