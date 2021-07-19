#include "TFile.h"
#include "TTree.h"
#include "TH1F.h"

int readDataFromTTree(const char* filename) {

	// // variables
	Double_t entries=0.;
	Double_t p_T=0.;

	// // create histograms
	TH1F *histProton = new TH1F("histProton","Proton: p_T [GeV/c]",200,0,40);
	TH1F *histPion = new TH1F("histPion","Pion: p_T [GeV/c]",200,0,40);
	TH1F *histKaon = new TH1F("histKaon","Kaon: p_T [GeV/c]",200,0,40);

	TFile *file = new TFile(filename,"update"); // there are a few TTree's in this file, each corresponds to different event
	TList *lofk = file->GetListOfKeys(); // standard ROOT stuff, to read all entries in the ROOT file

	for(Int_t i=0;i<lofk->GetEntries();i++)
	{
		TTree *tree = (TTree*) file->Get(Form("%s;%d",lofk->At(i)->GetName(),i+1)); // works if TTrees in ROOT file are named 'event;1', 'event;2'. Otherwise, adapt for your case

		if(!tree || strcmp(tree->ClassName(),"TTree")) // make sure the pointer is valid, and it points to TTree
		{
			cout << Form("%s is not TTree!",lofk->At(i)->GetName()) << endl; 
			continue;
		}

		tree->Print();  //from this printout, you can for instance inspect the names of the TTree's branches

		cout << Form("Accessing TTree named: %s",tree->GetName()) << ": " << tree << endl;
		Int_t nParticles = (Int_t)tree->GetEntries(); // number of particles
		cout << Form("=> It has %d particles.",nParticles) << endl;

		// // add nParticles to entries
		entries=entries+nParticles;

		// // attach local variables to branches:
		Float_t pid = 0., px = 0., py = 0., pz = 0.;
		tree->SetBranchAddress("pid",&pid);
		tree->SetBranchAddress("px",&px); // that the name of this branch is px, you can inspect from tree->Print() above, and so on
		tree->SetBranchAddress("py",&py);
		tree->SetBranchAddress("pz",&pz);

		// loop over all particles in a current TTree
		for(Int_t p=0;p<nParticles;p++) {
			tree->GetEntry(p);
            if(pid==2212.0 || pid==-2212.0) {
                p_T=sqrt(pow(px,2)+pow(py,2));
                histProton->Fill(p_T);
            }
            else if(pid==111.0 || pid==211.0 || pid==-211.0) {
                p_T=sqrt(pow(px,2)+pow(py,2));
                histPion->Fill(p_T);
            }
            else if(pid==311.0 || pid==-311.0 || pid==321.0 || pid==-321.0) {
                p_T=sqrt(pow(px,2)+pow(py,2));
                histKaon->Fill(p_T);
            }
		}  

		cout<<"Done with this event, marching on...\n"<<endl;  

	} // for(Int_t i=0; i<lofk->GetEntries(); i++)

	//cout << "Total number of particles: " << entries << endl;
	histProton->Write(histProton->GetName(),TObject::kSingleKey+TObject::kWriteDelete);
	histPion->Write(histPion->GetName(),TObject::kSingleKey+TObject::kWriteDelete);
	histKaon->Write(histKaon->GetName(),TObject::kSingleKey+TObject::kWriteDelete);

	file->Close(); 

	return 0;

}
