
// virtual : may be redefined later in a class derived from this one
class Container {
public:
  virtual double &operator[](int) = 0; // pure virtual function
  virtual int size() const = 0;        // const member function
  virtual ~Container() {}              // destructor
};