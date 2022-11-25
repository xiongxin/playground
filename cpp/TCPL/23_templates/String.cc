template <typename C> class String {
public:
  String();
  explicit String(const C *);
  String(const String &);
  String operator=(const String &);
  // ...
  C &operator[](int n) { return ptr[n]; }
  String &operator+=(C c);
  // ...
private:
  static const int short_max = 15;
  int sz;
  C *ptr;
  // ptr points to sz Cs
};

template <typename C> String<C>::String() {}
template <typename C> String<C> &String<C>::operator+=(C c) { return *this; }
