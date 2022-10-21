#include "ranges_window.hpp"
#include <iostream>
RangesWindow::RangesWindow()
    : m_VBox_Top(Gtk::Orientation::VERTICAL, 0),
      m_VBox2(Gtk::Orientation::VERTICAL, 20),
      m_VBox_HScale(Gtk::Orientation::VERTICAL, 10),
      m_HBox_Scales(Gtk::Orientation::HORIZONTAL, 10),
      m_HBox_Combo(Gtk::Orientation::HORIZONTAL, 10),
      m_HBox_Digits(Gtk::Orientation::HORIZONTAL, 10),
      m_HBox_PageSize(Gtk::Orientation::HORIZONTAL, 10),

      // Value, lower, upper, step_increment, page_increment, page_size:
      // Note that the page_size value only makes a difference for
      // scrollbar widgets, and the highest value you'll get is actually
      // (upper - page_size).
      m_adjustment(Gtk::Adjustment::create(0.0, 0.0, 101.0, 0.1, 1.0, 1.0)),
      m_adjustment_digits(Gtk::Adjustment::create(1.0, 0.0, 5.0, 1.0, 2.0)),
      m_adjustment_pagesize(Gtk::Adjustment::create(1.0, 1.0, 101.0)),

      m_VScale(m_adjustment, Gtk::Orientation::VERTICAL),
      m_HScale(m_adjustment, Gtk::Orientation::HORIZONTAL),
      m_Scale_Digits(m_adjustment_digits),
      m_Scale_PageSize(m_adjustment_pagesize),

      // A checkbutton to control whether the value is displayed or not:
      m_CheckButton("Display value on scale widgets", 0),

      // Reuse the same adjustment again.
      // Notice how this causes the scales to always be updated
      // continuously when the scrollbar is moved.
      m_Scrollbar(m_adjustment),

      m_Button_Quit("Quit") {

  set_title("range controls");
  set_default_size(300, 350);

  // VScale:
  m_VScale.set_digits(1);
  m_VScale.set_value_pos(Gtk::PositionType::TOP);
  m_VScale.set_draw_value();
  m_VScale.set_inverted(); // highest value at top

  // HScale:
  m_HScale.set_digits(1);
  m_HScale.set_value_pos(Gtk::PositionType::TOP);
  m_HScale.set_draw_value();

  set_child(m_VBox_Top);
  m_VBox_Top.append(m_VBox2);
  m_VBox2.set_expand(true);
  m_VBox2.set_margin(10);
  m_VBox2.append(m_HBox_Scales);
  m_HBox_Scales.set_expand(true);

  // Put VScale and HScale (above scrollbar) side-by-side.
  m_HBox_Scales.append(m_VScale);
  m_VScale.set_expand(true);
  m_HBox_Scales.append(m_VBox_HScale);
  m_VBox_HScale.set_expand(true);

  m_VBox_HScale.append(m_HScale);
  m_HScale.set_expand(true);

  // Scrollbar:
  m_VBox_HScale.append(m_Scrollbar);
  m_Scrollbar.set_expand(true);

  // CheckButton:
  m_CheckButton.set_active();
  m_CheckButton.signal_toggled().connect(
      sigc::mem_fun(*this, &RangesWindow::on_checkbutton_toggled));
  m_VBox2.append(m_CheckButton);

  // Position ComboBox:
  // Create the Tree model:
  m_refTreeModel = Gtk::ListStore::create(m_Columns);
  m_ComboBox_Position.set_model(m_refTreeModel);
  m_ComboBox_Position.pack_start(m_Columns.m_col_title);

  // Fill the ComboBox's Tree Model:
  auto row = *(m_refTreeModel->append());
  row[m_Columns.m_col_position_type] = Gtk::PositionType::TOP;
  row[m_Columns.m_col_title] = "Top";
  row = *(m_refTreeModel->append());
  row[m_Columns.m_col_position_type] = Gtk::PositionType::BOTTOM;
  row[m_Columns.m_col_title] = "Bottom";
  row = *(m_refTreeModel->append());
  row[m_Columns.m_col_position_type] = Gtk::PositionType::LEFT;
  row[m_Columns.m_col_title] = "Left";
  row = *(m_refTreeModel->append());
  row[m_Columns.m_col_position_type] = Gtk::PositionType::RIGHT;
  row[m_Columns.m_col_title] = "Right";

  m_VBox2.append(m_HBox_Combo);
  m_HBox_Combo.append(
      *Gtk::make_managed<Gtk::Label>("Scale Value Position:", 0));
  m_HBox_Combo.append(m_ComboBox_Position);
  m_ComboBox_Position.signal_changed().connect(
      sigc::mem_fun(*this, &RangesWindow::on_combo_position));
  m_ComboBox_Position.set_active(0); // Top
  m_ComboBox_Position.set_expand(true);

  // Digits:
  m_HBox_Digits.append(*Gtk::make_managed<Gtk::Label>("Scale Digits:", 0));
  m_Scale_Digits.set_digits(0);
  m_Scale_Digits.set_expand(true);
  m_Scale_Digits.set_draw_value();
  m_adjustment_digits->signal_value_changed().connect(
      sigc::mem_fun(*this, &RangesWindow::on_adjustment1_value_changed));
  m_HBox_Digits.append(m_Scale_Digits);

  // Page Size:
  m_HBox_PageSize.append(
      *Gtk::make_managed<Gtk::Label>("Scrollbar Page Size:", 0));
  m_Scale_PageSize.set_digits(0);
  m_Scale_PageSize.set_expand(true);
  m_Scale_PageSize.set_draw_value();
  m_adjustment_pagesize->signal_value_changed().connect(
      sigc::mem_fun(*this, &RangesWindow::on_adjustment2_value_changed));
  m_HBox_PageSize.append(m_Scale_PageSize);

  m_VBox2.append(m_HBox_Digits);
  m_VBox2.append(m_HBox_PageSize);
  m_VBox_Top.append(m_Separator);
  m_VBox_Top.append(m_Button_Quit);

  set_default_widget(m_Button_Quit);
  m_Button_Quit.signal_clicked().connect(
      sigc::mem_fun(*this, &RangesWindow::on_button_quit));
  m_Button_Quit.set_margin(10);
}

void RangesWindow::on_checkbutton_toggled() {
  m_VScale.set_draw_value(m_CheckButton.get_active());
  m_HScale.set_draw_value(m_CheckButton.get_active());
}

void RangesWindow::on_combo_position() {
  const auto iter = m_ComboBox_Position.get_active();
  if (!iter)
    return;

  const auto row = *iter;
  if (!row)
    return;

  const auto postype = row[m_Columns.m_col_position_type];

  m_VScale.set_value_pos(postype);
  m_HScale.set_value_pos(postype);
}

void RangesWindow::on_adjustment1_value_changed() {
  const double val = m_adjustment_digits->get_value();
  m_VScale.set_digits((int)val);
  m_HScale.set_digits((int)val);
}

void RangesWindow::on_adjustment2_value_changed() {
  const double val = m_adjustment_pagesize->get_value();
  m_adjustment->set_page_size(val);
  m_adjustment->set_page_increment(val);

  // Note that we don't have to emit the "changed" signal
  // because gtkmm does this for us.
}

void RangesWindow::on_button_quit() { hide(); }
