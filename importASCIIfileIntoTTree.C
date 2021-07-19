#include "TFile.h"
#include "TTree.h"

int importASCIIfileIntoTTree(const char* filename) {

	TFile *file = new TFile("HIJING_LBF_test_small.root","update");
	TTree *tree = new TTree("event","data from ASCII file");

	Long64_t nlines = tree->ReadFile(filename,"label:pid:prim:final:px:py:pz:E");
	tree->Write();
	file->Close();

	return 0; 

}
