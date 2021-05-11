def look_up_primitivization(record):
	#do something with Primitivization in magma?
	magma_sigmas = ?

def make_sage_sigmas(magma_sigmas):
	sigma_list = list(magma_sigmas)
	sigmas_new = [Permutation(str(el)) for el in sigma_list]
	return sigmas_new

def make_search_data(sigmas_new):
	return [el.cycle_type() for el in sigmas_new]


