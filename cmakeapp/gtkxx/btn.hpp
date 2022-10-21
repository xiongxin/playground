#pragma once

#include <gtkmm/box.h>
#include <gtkmm/button.h>
#include <gtkmm/checkbutton.h>
#include <gtkmm/separator.h>
#include <gtkmm/window.h>

class Buttons : public Gtk::Window {

public:
  Buttons();

private:
  void on_button_clicked();
  Gtk::Button m_button;
};

class RadioButtons : public Gtk::Window {

public:
  RadioButtons();

protected:
  void on_button_clicked();

  Gtk::Box m_Box_Top, m_Box1, m_Box2;
  Gtk::CheckButton m_RadioButton1, m_RadioButton2, m_RadioButton3;
  Gtk::Separator m_Separator;
  Gtk::Button m_Button_Close;
};
