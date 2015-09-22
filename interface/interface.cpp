#include <wx/wx.h>
#include "dbManager.hpp"

class MyApp : public wxApp
{
	public:
		virtual bool OnInit();
};

class Move : public wxFrame
{
	public:
		Move(const wxString& title);

		void OnMove(wxMoveEvent & event);

		wxStaticText *st1;
		wxStaticText *st2;
		wxChoice *ch;

	dbManager db;

};


Move::Move(const wxString& title) :
		wxFrame(NULL, wxID_ANY, title, wxDefaultPosition, wxSize(400, 300))
{
	wxPanel *panel = new wxPanel(this, -1);

	st1 = new wxStaticText(panel, -1, wxT(""), wxPoint(10, 10));
	st2 = new wxStaticText(panel, -1, wxT(""), wxPoint(10, 30));

	auto choices = db.getTableColumns ("Zona", 3);
	vector<wxString> strs;
	for (auto c : choices) {
		strs.push_back (wxString (c));
	}

	ch = new wxChoice (panel, -1, wxPoint (10, 50), wxDefaultSize, strs.size (),
			strs.data ());

	Connect(wxEVT_MOVE, wxMoveEventHandler(Move::OnMove));

	Centre();
}


void Move::OnMove(wxMoveEvent& event)
{
	wxPoint size = event.GetPosition();
	st1->SetLabel(wxString::Format(wxT("x: %d"), size.x ));
	st2->SetLabel(wxString::Format(wxT("y: %d"), size.y ));
}


IMPLEMENT_APP(MyApp)

bool MyApp::OnInit()
{
	Move *move = new Move(wxT("Move event"));
	move->Show(true);

	move->db.printTableMetaData ("Zona");
	move->db.select ();

	return true;
}



