#include "btn.hpp"
#include <gtkmm/box.h>
#include <gtkmm/image.h>
#include <gtkmm/label.h>
#include <iostream>

Buttons::Buttons() {
  auto pmap = Gtk::make_managed<Gtk::Image>("info.xpm");
  auto label = Gtk::make_managed<Gtk::Label>("cool button");
  label->set_expand(true);

  auto hbox = Gtk::make_managed<Gtk::Box>(Gtk::Orientation::HORIZONTAL, 5);
  hbox->append(*pmap);
  hbox->append(*label);

  m_button.set_child(*hbox);
  set_title("Pixmap's buttons!");
  m_button.signal_clicked().connect(
      sigc::mem_fun(*this, &Buttons::on_button_clicked));
  m_button.set_margin(10);
  set_child(m_button);
}

void Buttons::on_button_clicked() {
  std::cout << "The Button was clicked." << std::endl;
}

RadioButtons::RadioButtons()
    : m_Box_Top(Gtk::Orientation::VERTICAL),
      m_Box1(Gtk::Orientation::VERTICAL, 10),
      m_Box2(Gtk::Orientation::VERTICAL, 10), m_RadioButton1("button1"),
      m_RadioButton2("button2"), m_RadioButton3("button3"),
      m_Button_Close("close") {
  set_title("radio buttons");
  m_RadioButton2.set_group(m_RadioButton1);
  m_RadioButton3.set_group(m_RadioButton1);

  set_child(m_Box_Top);

  m_Box_Top.append(m_Box1);
  m_Box_Top.append(m_Separator);
  m_Box_Top.append(m_Box2);
  m_Separator.set_expand();

  m_Box1.set_margin(10);
  m_Box2.set_margin(10);

  m_Box1.append(m_RadioButton1);
  m_Box1.append(m_RadioButton2);
  m_Box1.append(m_RadioButton3);
  m_RadioButton1.set_expand();
  m_RadioButton2.set_expand();
  m_RadioButton3.set_expand();

  m_RadioButton2.set_active(true);

  m_Box2.append(m_Button_Close);
  // m_Button_Close.set_expand();

  set_default_widget(m_Button_Close);
  m_Button_Close.signal_clicked().connect(
      sigc::mem_fun(*this, &RadioButtons::on_button_clicked));
}

void RadioButtons::on_button_clicked() {
  hide(); // to close the application.
}
