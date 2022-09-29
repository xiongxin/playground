#include <gtkmm/application.h>
#include <gtkmm/window.h>

class MyWindows : public Gtk::Window {

public:
  MyWindows();
};

MyWindows::MyWindows() {
  set_title("基本应用");
  set_default_size(200, 200);
}

int main(int argc, char *argv[]) {

  auto app = Gtk::Application::create("org.gtkmm.examples.base");

  return app->make_window_and_run<MyWindows>(argc, argv);
}
