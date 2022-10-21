#include <gtkmm.h>

class SimpleEntry : public Gtk::Window {

public:
  SimpleEntry()
      : m_VBox{Gtk::Orientation::VERTICAL}, m_Button_Close{"Close"},
        m_CheckButton_Editable("Editable"), m_CheckButton_Visible("Visible") {

    set_size_request(200, 100);
    set_title("Gtk::Entry");

    set_child(m_VBox);
    m_VBox.set_margin(10);

    m_Entry.set_max_length(50);
    m_Entry.set_text("hello");
    m_Entry.set_text(m_Entry.get_text() + " world");
    m_Entry.select_region(0, m_Entry.get_text_length());
    // m_Entry.set_expand(true);

    m_VBox.append(m_Entry);
    m_VBox.append(m_HBox);

    m_HBox.append(m_CheckButton_Editable);
    m_CheckButton_Editable.set_expand(true);
    m_CheckButton_Editable.signal_toggled().connect(
        sigc::mem_fun(*this, &SimpleEntry::on_checkbox_editable_toggled));
    m_CheckButton_Editable.set_active(true);

    m_HBox.append(m_CheckButton_Visible);
    // m_CheckButton_Visible.set_expand(true);
    m_CheckButton_Visible.signal_toggled().connect(
        sigc::mem_fun(*this, &SimpleEntry::on_checkbox_visibility_toggled));
    m_CheckButton_Visible.set_active(true);

    m_Button_Close.signal_clicked().connect(
        sigc::mem_fun(*this, &SimpleEntry::on_button_close));
    m_VBox.append(m_Button_Close);
    // m_Button_Close.set_expand();
    set_default_widget(m_Button_Close);
  }
  ~SimpleEntry() {}

protected:
  // Signal handlers:
  void on_checkbox_editable_toggled() {
    m_Entry.set_editable(m_CheckButton_Editable.get_active());
  }
  void on_checkbox_visibility_toggled() {
    m_Entry.set_visibility(m_CheckButton_Visible.get_active());
  }
  void on_button_close() { hide(); }

  // Child widgets:
  Gtk::Box m_HBox;
  Gtk::Box m_VBox;
  Gtk::Entry m_Entry;
  Gtk::Button m_Button_Close;
  Gtk::CheckButton m_CheckButton_Editable, m_CheckButton_Visible;
};

int main(int argc, char *argv[]) {
  auto app = Gtk::Application::create("org.gtkmm.example");

  return app->make_window_and_run<SimpleEntry>(argc, argv);
}
