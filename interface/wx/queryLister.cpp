#include "queryLister.hpp"

queryLister::queryLister (wxWindow *parent, wxWindowID id, const wxPoint &pos, const wxSize &size,
		vector<vector<string>> values) :
		wxListCtrl (parent, wxID_ANY, pos, size, wxLC_REPORT | wxLC_VIRTUAL) {
	// primeira linha é a das colunas
	auto colunas = values[0];
	values.erase (values.begin ());

	vec = values;
	// dimensões
	int height = vec.size ();
	int width = colunas.size ();
	int columnWidth = size.GetWidth () / width;
	// adiciona colunas
	for (int i = 0; i < width; i++) {
		wxListItem col;
		col.SetId (i);
		col.SetText (colunas[i]);
		col.SetWidth (columnWidth);
		InsertColumn (i, col);
	}

	SetItemCount (height);
}


queryLister::queryLister (wxWindow *parent, vector<vector<string>> values) :
		queryLister (parent, wxID_ANY, wxDefaultPosition, wxDefaultSize, values) {}


wxString queryLister::OnGetItemText (long item, long column) const {
	return vec[item][column];
}
