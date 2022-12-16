// expre_Expressions_with_Pointer_Member_Operators.cpp
// compile with: /EHsc
#include <iostream>
#include <type_traits>
using namespace std;

class Testpm
{
public:
    void m_func1() { cout << "m_func1\n"; }
    int m_num;
};

// 必须
// Define derived types pmfn and pmd.
// These types are pointers to members m_func1() and
// m_num, respectively.
void (Testpm::*func)() = &Testpm::m_func1;
int Testpm::*m_num = &Testpm::m_num;

int main()
{
    Testpm ATestpm;
    Testpm *pTestpm = new Testpm;

    // Access the member function
    (ATestpm.*func)();
    (pTestpm->*func)(); // Parentheses required since * binds
                        // less tightly than the function call.

    // Access the member data
    ATestpm.*m_num = 1;
    pTestpm->*m_num = 2;

    cout << ATestpm.*m_num << endl
         << pTestpm->*m_num << endl;
    delete pTestpm;
}