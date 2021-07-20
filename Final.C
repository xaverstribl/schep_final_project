#include "TFile.h"
#include "TTree.h"

int Final() {

	TFile *file = new TFile("AnalysisResults.root","read");

	if (!file) {
		cout << "File for final work does not exist" << endl;
		return 1;
	}

	// // open histograms
	TH1F *histProton = dynamic_cast<TH1F*>(file->Get("histProton"));
	TH1F *histPion = dynamic_cast<TH1F*>(file->Get("histPion"));
	TH1F *histKaon = dynamic_cast<TH1F*>(file->Get("histKaon"));

	// // x-axis and y-axis stuff
	histProton->GetXaxis()->SetRange(0,histProton->FindLastBinAbove(0.,1));
	histProton->GetXaxis()->SetTitle("Energy [GeV/c]");
	//histProton->GetYaxis()->SetTitle("Counts");
	//histProton->GetYaxis()->SetTitleOffset(1);
	histProton->SetLineWidth(2);
	histPion->GetXaxis()->SetRange(0,histPion->FindLastBinAbove(0.,1));
	histPion->GetXaxis()->SetTitle("Energy [GeV/c]");
	//histPion->GetYaxis()->SetTitle("Counts");
	//histProton->GetYaxis()->SetTitleOffset(1);
	histPion->SetLineWidth(2);
	histKaon->GetXaxis()->SetRange(0,histKaon->FindLastBinAbove(0.,1));
	histKaon->GetXaxis()->SetTitle("Energy [GeV/c]");
	//histKaon->GetYaxis()->SetTitle("Counts");
	//histProton->GetYaxis()->SetTitleOffset(1);
	histKaon->SetLineWidth(2);

	// // canvas stuff, draw histograms
	TCanvas *c1 = new TCanvas("c1","p_T",3600,1200);
	c1->Divide(3,1);
	c1->cd(1);
	histPion->Draw();
	c1->cd(2);
	histKaon->Draw();
	c1->cd(3);
	histProton->Draw();
	c1->Update();
	c1->SaveAs("transverseMomentum.pdf");
	c1->SaveAs("transverseMomentum.eps");
	c1->SaveAs("transverseMomentum.png");
	c1->SaveAs("transverseMomentum.C");

	// // print out average p_T
	cout << endl << endl << "Average pT for the whole dataset:" << endl;
	cout << histPion->GetEntries() << " pions   = " << histPion->GetMean() << " GeV/c" << endl;
	cout << histKaon->GetEntries() << " kaons   = " << histKaon->GetMean() << " GeV/c" << endl;
	cout << histProton->GetEntries() << " protons = " << histProton->GetMean() << " GeV/c" << endl << endl;

	return 0;

}
