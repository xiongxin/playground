use std::fs::File;
use std::io::prelude::*;

use hashbrown::HashMap;

type Rule = Vec<Token>;

#[derive(Debug)]
enum Token {
  NONTERMINAL(char),
  TERMINAL(char),
  NULL,
}

pub struct NonTerminals {
  nullable_map: HashMap<char, bool>,
  first_map: HashMap<char, Vec<char>>,
  follow_map: HashMap<char, Vec<char>>,
  rule_map: HashMap<char, Vec<Rule>>,
}

impl NonTerminals {
  pub fn init(grammar: String) -> Self {
    let mut nullable_map = HashMap::new();
    let mut first_map = HashMap::new();
    let mut follow_map = HashMap::new();
    let mut rule_map = HashMap::new();

    // go line by line eg A -> B c
    for line in grammar.split("\n") {
      // split line into two sides ["A ", " B c"]
      let mut side = line.split("->");
      let mut lhs = side.next().expect("Missing left hand side").trim().chars();
      let nonterminal = lhs.next();
      match nonterminal {
        Some(c) if c.is_ascii_uppercase() => {
          nullable_map.entry(c).or_insert(false);
          first_map.entry(c).or_insert(Vec::new());
          follow_map.entry(c).or_insert(Vec::new());
          rule_map.entry(c).or_insert(Vec::new());
        }
        _ => panic!("Smething with the left hand side of wrong"),
      }

      if let Some(_) = lhs.next() {
        panic!("left hand side too long");
      }

      let rhs = side.next().expect("Missing right and side").trim().chars();
      let rule = rhs
        .filter(|c| (c.is_ascii() || *c == '0') && !c.is_whitespace())
        .map(|c| match c {
          '0' => Token::NULL,
          _ if c.is_uppercase() => Token::NONTERMINAL(c),
          _ => Token::TERMINAL(c),
        })
        .collect();

      rule_map
        .entry(nonterminal.unwrap())
        .and_modify(|set| set.push(rule));
    }

    NonTerminals {
      nullable_map,
      first_map,
      follow_map,
      rule_map,
    }
  }

  /// Determines which nonterminals are nullable
  pub fn calc_null_set(&mut self) {
    let mut changed = true;
    while changed {
      changed = false;

      for (non_terminal, rules) in self.rule_map.iter() {
        for rule in rules {
          let nullable = rule.iter().all(|token| match token {
            Token::NONTERMINAL(c) => *self.nullable_map.get(c).unwrap(),
            Token::TERMINAL(_) => false,
            Token::NULL => true,
          });

          if nullable && nullable != *self.nullable_map.get(non_terminal).unwrap() {
            self.nullable_map.insert(*non_terminal, true);
            changed = true;
          }
        }
      }
    }
  }

  /// Determines the first set of each nonterminal
  pub fn calc_first_set(&mut self) {
    let mut changed = true;
    while changed {
      changed = false;
      for (non_terminal, rules) in self.rule_map.iter() {
        for rule in rules {
          for token in rule {
            match token {
              // push all first, if not nullable break
              Token::NONTERMINAL(c) => {
                let potential_new_firsts = (*self.first_map.get(c).unwrap()).clone();
                for f in potential_new_firsts {
                  if !self.first_map.get(non_terminal).unwrap().contains(&f) {
                    self
                      .first_map
                      .entry(*non_terminal)
                      .and_modify(|first_set| first_set.push(f));

                    changed = true;
                  }
                }

                if !self.nullable_map.get(c).unwrap() {
                  break;
                }
              }
              Token::TERMINAL(c) => {
                if !self.first_map.get(non_terminal).unwrap().contains(c) {
                  self
                    .first_map
                    .entry(*non_terminal)
                    .and_modify(|first_set| first_set.push(*c));

                  changed = true;
                }

                break;
              }
              Token::NULL => (),
            }
          }
        }
      }
    }
  }

  /// Determines the follow set of each nonterminal
  pub fn calc_follow_set(&mut self) {
    let mut changed = true;
    while changed {
      changed = false;

      for (non_terminal, _) in self.rule_map.iter() {
        for (lhs_nonterminal, rules) in self.rule_map.iter() {
          for rule in rules {
            // state 0 waiting nonterminal to appear
            // state 1 nonterminal appered
            let mut state = 0;

            // if a nonterminal is last in a rule, or everything after it is nullable
            // then it inherits all follows from left hand side nonterminal
            let mut nullable_til_end = false;
            for token in rule {
              match token {
                Token::NONTERMINAL(c) => {
                  // if we are waiting for nonterminal, and we find it
                  // stop waiting for it
                  if state == 0 && c == non_terminal {
                    state += 1;
                    nullable_til_end = true;
                  } else if state == 1 && c != non_terminal {
                    // get list of potential_new_follows
                    // make sure they are non already in the list
                    for f in self.first_map.get(c).unwrap() {
                      if !self.follow_map.get(non_terminal).unwrap().contains(f) {
                        self
                          .follow_map
                          .entry(*non_terminal)
                          .and_modify(|follow_set| follow_set.push(*f));
                      }
                    }

                    // if it is nullable, keep adding more follows
                    if !self.nullable_map.get(c).unwrap() {
                      state += 1;
                      nullable_til_end = false;
                    }
                  } else {
                    continue;
                  }
                }
                Token::TERMINAL(c) => {
                  nullable_til_end = false;
                  // if nonterminal not found yet, keep waiting
                  if state == 0 {
                    continue;
                    // if we found nonteriminal, we have potential new follow
                  } else if state == 1 {
                    if !self.follow_map.get(non_terminal).unwrap().contains(c) {
                      self
                        .follow_map
                        .entry(*non_terminal)
                        .and_modify(|follow_set| follow_set.push(*c));

                      changed = true;
                    }

                    state += 1;
                  } else {
                    break;
                  }
                }
                Token::NULL => (),
              };
            }

            if nullable_til_end && lhs_nonterminal != non_terminal {
              // get list of potential_new_follows
              let potential_new_follows = self.follow_map.get(lhs_nonterminal).unwrap().clone();

              for f in potential_new_follows {
                if !self.follow_map.get(non_terminal).unwrap().contains(&f) {
                  self
                    .follow_map
                    .entry(*non_terminal)
                    .and_modify(|follow_set| follow_set.push(f));

                  changed = true;
                }
              }
            }
          }
        }
      }
    }
  }

  /// You can use this function to verify that nff understood your rules correctly
  pub fn print_rules(&self) {
    for (non_terminal, rule) in self.rule_map.iter() {
      println!("{}\n{:?}", non_terminal, rule);
    }
  }
  /// Print results
  pub fn print_results(&self) {
    for (nonterminal, _) in self.rule_map.iter() {
      println!("{}", nonterminal);
      println!("Nullable: {}", self.nullable_map.get(nonterminal).unwrap());
      println!("First: {:?}", self.first_map.get(nonterminal).unwrap());
      println!("Follow: {:?}", self.follow_map.get(nonterminal).unwrap());
    }
  }
}

/// Opens the file defined by the first argument
pub fn open_file(mut args: std::env::Args) -> String {
  if args.len() > 2 {
    println!("Program only supports 1 file");
  }
  args.next();
  let filename = match args.next() {
    Some(arg) => arg,
    None => panic!("Specify file with grammars"),
  };
  let mut f = File::open(filename).expect("File not found");
  let mut contents = String::new();
  f.read_to_string(&mut contents).expect("Error reading file");

  contents
}
