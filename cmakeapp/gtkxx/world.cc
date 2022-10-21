#include "world.hpp"
#include <iostream>

World::World() : m_button{"Click", true} {

  m_button.set_margin(10);
  m_button.signal_clicked().connect(
      sigc::mem_fun(*this, &World::on_button_clicked));

  set_child(m_button);
}

World::~World() = default;

void World::on_button_clicked() { std::cout << "Hello World" << std::endl; }
