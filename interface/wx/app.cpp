#include <wx/wx.h>
#include <wx/aboutdlg.h>
#include "dbManager.hpp"
#include "queryLister.hpp"

/**
 * Classe da aplicação
 */
class MyApp : public wxApp {
	public:
		virtual bool OnInit();
};

/**
 * Frame: janela principal da aplicação
 */
class LabBD : public wxFrame {
public:
	LabBD (const wxString& title);

	/// Tenta conectar/reconectar o BD
	void reconnect ();

	// Eventos gerados
	void OnExit (wxCommandEvent & event);
	void OnAbout (wxCommandEvent & event);
	void OnReconnect (wxCommandEvent & event);
	void OnWX (wxCommandEvent & event);

	/// Nossa conexão com a base de dados
	dbManager db;

	/// IDs usados para eventos
	enum ids {
		ID_WX,
		ID_RECONNECT
	};
	wxDECLARE_EVENT_TABLE ();
};

// conecta eventos
wxBEGIN_EVENT_TABLE (LabBD, wxFrame)
	EVT_MENU (wxID_EXIT, LabBD::OnExit)
	EVT_MENU (wxID_ABOUT, LabBD::OnAbout)
	EVT_MENU (ID_RECONNECT, LabBD::OnReconnect)
	EVT_MENU(ID_WX, LabBD::OnWX)
wxEND_EVENT_TABLE()



LabBD::LabBD (const wxString& title) :
		wxFrame (NULL, wxID_ANY, title, wxDefaultPosition, wxSize (800, 600)) {
	auto panel = new wxPanel (this, wxID_ANY);
	CreateStatusBar ();
	reconnect ();

	// Barra de menu
	auto menuBar = new wxMenuBar;
	SetMenuBar (menuBar);
	// Menu do programa
	auto fileMenu = new wxMenu;
	menuBar->Append (fileMenu, "&Programa");

	fileMenu->Append (ID_RECONNECT, "Reconectar", "Tenta refazer a conexão com o banco de dados");
	fileMenu->AppendSeparator ();
	fileMenu->Append (wxID_EXIT, "Sair", "Sai do programa");
	// Menu de Operações
	auto opMenu = new wxMenu;
	menuBar->Append (opMenu, wxT ("&Operações"));
	// Menu de ajuda
	auto helpMenu = new wxMenu;
	menuBar->Append (helpMenu, "&Ajuda");

	helpMenu->Append (wxID_ABOUT, "&Sobre", "Mostra informação sobre o programa");
	helpMenu->Append (ID_WX, "&Sobre o wxWidgets", "Mostra informação sobre a versão do WxWidgets usada");
	// Resto
	auto vec = db.select ("*", "Pessoa WHERE escolaridade LIKE 'ensino medio'");
	auto q = new queryLister (panel, wxID_ANY, wxPoint (10, 50), wxSize (750, 450), vec);

	auto choices = db.getTableColumns ("Zona", 3);
	vector<wxString> strs;
	for (auto c : choices) {
		strs.push_back (wxString (c));
	}

	auto ch = new wxChoice (panel, 5, wxPoint (10, 500), wxDefaultSize, strs.size (),
			strs.data ());
	ch->SetSelection (0);

	SetIcon (wxIcon ("cavalo.png"));

	Centre();
}

void LabBD::reconnect () {
	db.disconnect ();
	try {
		db.connect ();
		SetStatusText ("Conectado!");
	}
	catch (string err) {
		wxMessageBox (err, "Erro de conexão", wxCENTRE | wxICON_ERROR | wxOK);
		SetStatusText ("Erro de conexão!");
	}
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
void LabBD::OnReconnect (wxCommandEvent & WXUNUSED (event)) {
	reconnect ();
}
void LabBD::OnWX (wxCommandEvent & WXUNUSED (event)) {
	wxInfoMessageBox (nullptr);
}


IMPLEMENT_APP(MyApp)

bool MyApp::OnInit() {
	LabBD *labBD = new LabBD ("LabBD");
	labBD->Show (true);

	//labBD->db.printTableMetaData ("Zona");

	return true;
}



