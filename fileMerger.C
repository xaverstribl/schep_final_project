#include "TFile.h"

int fileMerger(const char* dir) {

	TFileMerger *merger = new TFileMerger(); 

	// add files which need to be merged:
	for (Int_t i=0;i<10;i++) {
		merger->AddFile(Form("%s/%d/HIJING_LBF_test_small.root",dir,i),kFALSE);
	}

	// final merging:
	merger->OutputFile("AnalysisResults.root");
	merger->Merge();

	return 0;

}
