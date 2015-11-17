#include <wx/wx.h>
#include <wx/aboutdlg.h>
#include "dbManager.hpp"
#include "queryLister.hpp"

class MyApp : public wxApp
{
	public:
		virtual bool OnInit();
};

class LabBD : public wxFrame {
public:
	LabBD (const wxString& title);

	void OnExit (wxCommandEvent & event);
	void OnAbout (wxCommandEvent & event);

	//wxMenuBar *menuBar;

	wxChoice *ch;
	queryLister *q;

	dbManager db;
};


LabBD::LabBD (const wxString& title) :
		wxFrame (NULL, wxID_ANY, title, wxDefaultPosition, wxSize (800, 600)) {
	auto panel = new wxPanel (this, -1);

	// Barra de menu
	auto menuBar = new wxMenuBar;
	SetMenuBar (menuBar);
	// Menu do programa
	auto fileMenu = new wxMenu;
	menuBar->Append (fileMenu, "Programa");

	fileMenu->Append (wxID_EXIT, "Sair", "Sai do programa");
	Connect (wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler (LabBD::OnExit));
	// Menu de ajuda
	auto helpMenu = new wxMenu;
	menuBar->Append (helpMenu, "Ajuda");

	helpMenu->Append (wxID_ABOUT, "Sobre");
	Connect (wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler (LabBD::OnAbout));

	auto vec = db.select ("*", "Pessoa WHERE escolaridade LIKE 'ensino medio'");
	q = new queryLister (panel, -1, wxPoint (10, 50), wxSize (700, 400), vec);

	auto choices = db.getTableColumns ("Zona", 3);
	vector<wxString> strs;
	for (auto c : choices) {
		strs.push_back (wxString (c));
	}

	ch = new wxChoice (panel, 5, wxPoint (10, 500), wxDefaultSize, strs.size (),
			strs.data ());
	ch->SetSelection (0);

	Centre();
}


void LabBD::OnExit (wxCommandEvent & WXUNUSED (event)) {
	Close (true);
}
void LabBD::OnAbout (wxCommandEvent & WXUNUSED (event)) {
	wxAboutDialogInfo info;
	info.SetName ("T5 de LabBD");
	info.SetVersion ("0.0.1");
	info.SetDescription ("Trabalho 5 de Laboratório de Bases de Dados");
	info.SetIcon (wxIcon ("cavalo.png"));
	info.AddDeveloper ("Gil Barbosa Reis - 8532248");
	info.AddDeveloper ("Raul Zaninetti Rosa - 8517310");

	wxAboutBox (info);
}


IMPLEMENT_APP(MyApp)

bool MyApp::OnInit() {
	try {
		LabBD *labBD = new LabBD ("LabBD");
		labBD->Show(true);

		labBD->db.printTableMetaData ("Zona");
	}
	catch (string connExc) {
		wxMessageBox (connExc, "Erro de conexão", wxCENTRE | wxICON_ERROR | wxOK);
		return false;
	}

	return true;
}



