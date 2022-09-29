#include <gtkmm/button.h>
#include <gtkmm/window.h>

class World : public Gtk::Window {
public:
  World();

  ~World() override;

protected:
  void on_button_clicked();

  Gtk::Button m_button;
};
