#include "nfa.hpp"
#include <algorithm>
#include <memory>
#include <stack>
#include <vector>

std::ostream &operator<<(std::ostream &os, const state &self) {
  os << "m_is_end:" << self.m_is_end << '\n';

  os << "m_transition:";
  for (auto transition : self.m_transition) {
    os << transition.first << " -> [" << transition.second << "]";
  }
  os << '\n' << "m_epsilon_transitions:";
  for (auto e_transition : self.m_epsilon_transitions) {
    os << "{" << e_transition << " }";
  }

  os << '\n';
  return os;
}

std::ostream &operator<<(std::ostream &os, const block &self) {
  os << "m_start:" << self.m_start << '\n';
  os << "m_end:" << self.m_end << '\n';

  return os;
}

block block::concats(block first, block second) {
  first.m_end->add_epsilon_transition(second.m_start);
  first.m_end->set_end(false);

  return {first.m_start, second.m_end};
}

block block::unions(block first, block second) {
  std::shared_ptr<state> start = std::make_shared<state>(false);
  start->add_epsilon_transition(first.m_start);
  start->add_epsilon_transition(second.m_start);

  std::shared_ptr<state> end = std::make_shared<state>(true);

  first.m_end->add_epsilon_transition(end);
  first.m_end->set_end(false);

  second.m_end->add_epsilon_transition(end);
  second.m_end->set_end(false);

  return {start, end};
}

block block::closures(block nfa) {
  std::shared_ptr<state> start = std::make_shared<state>(false);
  std::shared_ptr<state> end = std::make_shared<state>(true);

  start->add_epsilon_transition(end);
  start->add_epsilon_transition(nfa.m_start);

  nfa.m_end->add_epsilon_transition(end);
  nfa.m_end->add_epsilon_transition(nfa.m_start);
  nfa.m_end->set_end(false);

  return {start, end};
}

block from_epsilon() {
  std::shared_ptr<state> start = std::make_shared<state>(false);
  std::shared_ptr<state> end = std::make_shared<state>(true);

  return {start, end};
}

block from_symbol(char symbol) {
  std::shared_ptr<state> start = std::make_shared<state>(false);
  std::shared_ptr<state> end = std::make_shared<state>(true);
  start->add_transition(end, symbol);

  return {start, end};
}

block to_nfa(std::string_view postfix_exp) {
  if (postfix_exp.empty())
    return from_epsilon();

  std::stack<block> block_stack{};

  for (char token : postfix_exp) {
    if (token == '*') {
      auto b = block::closures(block_stack.top());
      block_stack.emplace(b);
    } else if (token == '|') {
      block right = block_stack.top();
      block_stack.pop();
      block left = block_stack.top();
      block_stack.pop();

      block_stack.push(block::unions(left, right));
    } else if (token == '.') {
      block right = block_stack.top();
      std::cout << right;
      block_stack.pop();
      block left = block_stack.top();
      std::cout << left;
      block_stack.pop();

      auto b = block::concats(left, right);
      std::cout << b;
      block_stack.push(b);
    } else {
      block_stack.push(from_symbol(token));
    }
  }

  return block_stack.top();
}

void add_next_states(std::shared_ptr<state> current_state,
                     std::vector<std::shared_ptr<state>> &next_states,
                     std::vector<std::shared_ptr<state>> &visited) {
  if (current_state->get_epsilon_transitions().size()) {
    for (auto st : current_state->get_epsilon_transitions()) {
      if (std::find(visited.begin(), visited.end(), st) == visited.end()) {
        visited.push_back(st);
        add_next_states(st, next_states, visited);
      }
    }
  } else {
    next_states.push_back(current_state);
  }
}

bool search(block nfa, std::string_view word) {
  // std::cout << nfa;
  std::vector<std::shared_ptr<state>> current_states{};
  std::vector<std::shared_ptr<state>> visited{};
  add_next_states(nfa.get_start(), current_states, visited);
  for (char symbol : word) {
    std::vector<std::shared_ptr<state>> next_states{};

    for (auto st : current_states) {
      if (st->get_transitions().contains(symbol)) {
        visited.clear();
        add_next_states(st->get_transitions().at(symbol), next_states, visited);
      }
    }

    current_states = next_states;
  }

  return std::find_if(current_states.begin(), current_states.end(), [](auto s) {
           return s->is_end();
         }) != current_states.end();
}
