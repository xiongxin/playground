#include <iostream>

template <class T> class DynamicScope
{
  T instance;
  T *next;

public:
  template <class... T2>
  DynamicScope<T> (T2... rest) : instance (rest...), next (&instance)
  {
  }

  T &
  operator* ()
  {
    return *next;
  }
  T *
  operator->()
  {
    return next;
  }

  // Create a new binding at the given DynamicScope Point
  class BindPointer
  {
    T *old_next;
    DynamicScope<T> &head;

  public:
    BindPointer (DynamicScope<T> &head, T *instance)
        : head (head), old_next (head.next)
    {
      head.next = instance;
    }

    ~BindPointer () { head.next = old_next; }
  };

  class BindInstance : protected BindPointer
  {
    T instance;

  public:
    template <class... T2>
    BindInstance (DynamicScope<T> &head, T2... rest)
        : BindPointer (head, &instance), instance (rest...)
    {
    }
  };
};

DynamicScope<int> G (0);

void
bar ()
{
  std::cout << "bar " << *G << std::endl;
}

void
foo ()
{
  DynamicScope<int>::BindInstance b1 (G, 3);
  DynamicScope<int>::BindInstance b2 (G, 100);
  bar ();
}

int
main ()
{
  std::cout << "main1 " << *G << std::endl;
  foo ();
  std::cout << "main2 " << *G << std::endl;
}
