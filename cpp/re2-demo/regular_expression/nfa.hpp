

#include <iostream>
#include <map>
#include <memory>
#include <string_view>
#include <vector>
/*
  A state in Thompson's NFA can either have
   - a single symbol transition to a state
    or
   - up to two epsilon transitions to another states
  but not both.
*/
class state {

public:
  state() : m_is_end{false}, m_transition{}, m_epsilon_transitions{} {}
  state(bool is_end)
      : m_is_end{is_end}, m_transition{}, m_epsilon_transitions{} {}

  void add_epsilon_transition(std::shared_ptr<state> to) {
    m_epsilon_transitions.push_back(to);
  }
  void add_transition(std::shared_ptr<state> to, char symbol) {
    m_transition[symbol] = to;
  }
  void set_end(bool is_end) { m_is_end = is_end; }

  std::vector<std::shared_ptr<state>> &get_epsilon_transitions() {
    return m_epsilon_transitions;
  }
  const std::vector<std::shared_ptr<state>> &get_epsilon_transitions() const {
    return m_epsilon_transitions;
  }
  std::map<char, std::shared_ptr<state>> &get_transitions() {
    return m_transition;
  }
  const std::map<char, std::shared_ptr<state>> &get_transitions() const {
    return m_transition;
  }

  bool operator==(const state &other) const {
    return m_is_end == other.m_is_end && m_transition == other.m_transition &&
           m_epsilon_transitions == other.m_epsilon_transitions;
  }

  bool &is_end() { return m_is_end; }
  const bool &is_end() const { return m_is_end; }

  friend std::ostream &operator<<(std::ostream &os, const state &self);

private:
  bool m_is_end;
  std::map<char, std::shared_ptr<state>> m_transition;
  std::vector<std::shared_ptr<state>> m_epsilon_transitions;
};

class block {
private:
  std::shared_ptr<state> m_start;
  std::shared_ptr<state> m_end;

public:
  block()
      : m_start(std::make_shared<state>(false)),
        m_end(std::make_shared<state>(true)) {}
  block(char symbol)
      : m_start(std::make_shared<state>(false)),
        m_end(std::make_shared<state>(true)) {
    m_start->add_transition(m_end, symbol);
  }
  block(std::shared_ptr<state> start, std::shared_ptr<state> end)
      : m_start(start), m_end(end) {}

  std::shared_ptr<state> get_start() { return m_start; }
  const std::shared_ptr<state> get_start() const { return m_start; }

  static block concats(block, block);
  static block unions(block, block);
  static block closures(block);

  friend std::ostream &operator<<(std::ostream &os, const block &self);
};

block to_nfa(std::string_view);

bool search(block, std::string_view);

block from_symbol(char symbol);
