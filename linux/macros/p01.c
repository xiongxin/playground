#define stringify_indirect(x) #x
#define stringify(x) stringify_indirect(x)
#define put_side_by_side(x,y,z) x y z
#define a(x) x


#define boo() 123
#define foo(x) x #x

#define recur4(C, T, E) C-T-E
#define recur3(X) [ X ]
#define recur2(C, X) recur4(C(X), recur4(C(X), ,),) |C|
#define recur1(F, X) F(recur3, X)


int main(void){

  return 0;
}
