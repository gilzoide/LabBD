#pragma once

#include <wx/listctrl.h>
#include <vector>

using namespace std;

/**
 * Query Lister: nossa janela que lista resultado de SELECTs
 */
class queryLister : public wxListCtrl {
public:
	queryLister (wxWindow *parent, wxWindowID id, const wxPoint &pos, const wxSize &size,
			vector<vector<string>> values);
	queryLister (wxWindow *parent, vector<vector<string>> values);

	wxString OnGetItemText (long item, long column) const;
private:
	vector<vector<string>> vec;
};
