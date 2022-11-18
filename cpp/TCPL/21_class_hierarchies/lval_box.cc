class Ival_box {
protected:
  int val;
  int low, high;
  bool changed{false}; // changed by user using set_value()
public:
  Ival_box(int ll, int hh) : val{ll}, low{ll}, high{hh} {}
  virtual int get_value() { // for application
    changed = false;
    return val;
  }
  virtual void set_value(int i) { // for user
    changed = true;
    val = i;
  }
  virtual void reset_value(int i) { // for application
    changed = false;
    val = i;
  }
  virtual void prompt() {}
  virtual bool was_changed() const { return changed; }
  virtual ~Ival_box(){};
};
