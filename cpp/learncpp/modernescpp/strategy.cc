#include <iostream>
#include <memory>
#include <utility>

class Strategy {
public:
  virtual void execute() = 0;
  virtual ~Strategy() {}
};

class Context {
  std::unique_ptr<Strategy> start;

public:
  void setStrategy(std::unique_ptr<Strategy> start_) {
    start = std::move(start_);
  }

  void strategy() {
    if (start)
      start->execute();
  }
};
