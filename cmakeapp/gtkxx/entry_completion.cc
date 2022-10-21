#include <gtkmm.h>
#include <iostream>

class EntryCompletion : public Gtk::Window {

public:
  EntryCompletion()
      : m_VBox{Gtk::Orientation::VERTICAL},
        m_HBox{Gtk::Orientation::HORIZONTAL},
        m_Label{"Press a or b to see a list of possible completions."},
        m_Button_Close{"Close"} {

    set_title("Gtk::EntryCompletion");
    set_child(m_VBox);

    m_VBox.set_margin(10);
    m_VBox.append(m_Entry);
    m_VBox.append(m_Label);
    m_Label.set_expand(true);

    m_Button_Close.signal_clicked().connect(
        sigc::mem_fun(*this, &EntryCompletion::on_button_close));
    m_VBox.append(m_Button_Close);

    m_Entry.set_text("input some thing pls!");
    m_Entry.set_icon_from_icon_name("edit-find");
    m_Entry.signal_icon_press().connect(
        sigc::mem_fun(*this, &EntryCompletion::on_icon_pressed));

    auto completion = Gtk::EntryCompletion::create();
    m_Entry.set_completion(completion);

    // Change the progress fraction every 0.1 second:
    Glib::signal_timeout().connect(
        sigc::mem_fun(*this, &EntryCompletion::on_timeout), 100);

    // create and fill the completion's filter model
    auto refCompletionModel = Gtk::ListStore::create(m_Columns);
    completion->set_model(refCompletionModel);

    auto row = *(refCompletionModel->append());
    row[m_Columns.m_col_id] = 1;
    row[m_Columns.m_col_name] = "Alan Zebedee";

    row = *(refCompletionModel->append());
    row[m_Columns.m_col_id] = 2;
    row[m_Columns.m_col_name] = "Adrian Boo";

    row = *(refCompletionModel->append());
    row[m_Columns.m_col_id] = 3;
    row[m_Columns.m_col_name] = "Bob McRoberts";

    row = *(refCompletionModel->append());
    row[m_Columns.m_col_id] = 4;
    row[m_Columns.m_col_name] = "Bob McBob";
    completion->set_text_column(m_Columns.m_col_name);
  }
  virtual ~EntryCompletion() {}

protected:
  // Signal handlers:
  void on_button_close() { hide(); }
  void on_icon_pressed(Gtk::Entry::IconPosition icon_pos) {
    std::cout << "Icon pressed." << std::endl;
  }
  bool on_timeout() {
    static double fraction = 0;
    m_Entry.set_progress_fraction(fraction);

    fraction += 0.01;
    if (fraction > 1)
      fraction = 0;

    return true;
  }

  // Tree model columns, for the EntryCompletion's filter model:
  class ModelColumns : public Gtk::TreeModel::ColumnRecord {

  public:
    ModelColumns() {
      add(m_col_id);
      add(m_col_name);
    }

    Gtk::TreeModelColumn<unsigned int> m_col_id;
    Gtk::TreeModelColumn<Glib::ustring> m_col_name;
  };

  ModelColumns m_Columns;

  // Child widgets:
  Gtk::Box m_HBox;
  Gtk::Box m_VBox;
  Gtk::Entry m_Entry;
  Gtk::Label m_Label;
  Gtk::Button m_Button_Close;
};

int main(int argc, char *argv[]) {
  auto app = Gtk::Application::create("org.gtkmm.example");

  return app->make_window_and_run<EntryCompletion>(argc, argv);
}
