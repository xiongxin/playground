#include <gtkmm.h>
#include <iostream>

class ProgressBarWindow : public Gtk::Window {

public:
  ProgressBarWindow()
      : m_VBox(Gtk::Orientation::VERTICAL, 5), m_CheckButton_Text("Show text"),
        m_CheckButton_Activity("Activity mode"),
        m_CheckButton_Inverted("Right to Left"), m_Button_Close("Close"),
        m_bActivityMode(false) {

    set_resizable();
    set_title("Gtk::ProgressBar");

    m_VBox.set_margin(10);
    set_child(m_VBox);

    m_VBox.append(m_ProgressBar);
    m_ProgressBar.set_margin_end(5);
    m_ProgressBar.set_halign(Gtk::Align::CENTER);
    m_ProgressBar.set_valign(Gtk::Align::CENTER);
    m_ProgressBar.set_size_request(100, -1);
    m_ProgressBar.set_text("some text");
    // m_ProgressBar.set_show_text(false);

    m_connection_timeout = Glib::signal_timeout().connect(
        sigc::mem_fun(*this, &ProgressBarWindow::on_timeout), 50);
    m_VBox.append(m_Separator);
    m_VBox.append(m_Grid);
    m_Grid.set_expand(true);
    m_Grid.set_row_homogeneous(true);

    m_Grid.attach(m_CheckButton_Text, 0, 1);
    m_CheckButton_Text.set_margin(5);
    m_CheckButton_Text.signal_toggled().connect(
        sigc::mem_fun(*this, &ProgressBarWindow::on_checkbutton_text));

    // Add a check button to toggle activity mode
    m_Grid.attach(m_CheckButton_Activity, 0, 2);
    m_CheckButton_Activity.set_margin(5);
    m_CheckButton_Activity.signal_toggled().connect(
        sigc::mem_fun(*this, &ProgressBarWindow::on_checkbutton_activity));

    // Add a check button to select growth from left to right or from right to
    // left:
    m_Grid.attach(m_CheckButton_Inverted, 0, 3);
    m_CheckButton_Inverted.set_margin(5);
    m_CheckButton_Inverted.signal_toggled().connect(
        sigc::mem_fun(*this, &ProgressBarWindow::on_checkbutton_inverted));

    // Add a button to exit the program
    m_VBox.append(m_Button_Close);
    m_Button_Close.signal_clicked().connect(
        sigc::mem_fun(*this, &ProgressBarWindow::on_button_close));

    set_default_widget(m_Button_Close);
  }
  ~ProgressBarWindow() {}

private:
  // Signal handlers:
  void on_checkbutton_text() {
    const bool show_text = m_CheckButton_Text.get_active();
    m_ProgressBar.set_show_text(show_text);
  }
  void on_checkbutton_activity() {
    m_bActivityMode = m_CheckButton_Activity.get_active();

    if (m_bActivityMode)
      m_ProgressBar.pulse();
    else
      m_ProgressBar.set_fraction(0.0);
  }
  void on_checkbutton_inverted() {
    const bool inverted = m_CheckButton_Inverted.get_active();
    m_ProgressBar.set_inverted(inverted);
  }

  // update the vaue of the progress bar so that we get some movement
  bool on_timeout() {
    if (m_bActivityMode)
      m_ProgressBar.pulse();
    else {
      double new_val = m_ProgressBar.get_fraction() + 0.01;
      if (new_val > 1.0) {
        new_val = 0.0;
      }

      m_ProgressBar.set_fraction(new_val);
      m_ProgressBar.set_text(
          Glib::ustring::format("处理进度：", new_val * 100, "%"));
    }

    return true;
  }
  void on_button_close() { hide(); }

  // Child widgets:
  Gtk::Box m_VBox;
  Gtk::Grid m_Grid;
  Gtk::ProgressBar m_ProgressBar;
  Gtk::Separator m_Separator;
  Gtk::CheckButton m_CheckButton_Text, m_CheckButton_Activity,
      m_CheckButton_Inverted;
  Gtk::Button m_Button_Close;

  sigc::connection m_connection_timeout;
  bool m_bActivityMode;
};
int main(int argc, char *argv[]) {
  auto app = Gtk::Application::create("org.gtkmm.example");

  return app->make_window_and_run<ProgressBarWindow>(argc, argv);
}
