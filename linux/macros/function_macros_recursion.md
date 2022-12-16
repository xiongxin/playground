#define recur4(C, T, E) C-T-E
#define recur3(X) [ X ]
#define recur2(C, X) recur4(C(X), recur4(C(X), ,),) |C|
#define recur1(F, X) F(recur3, X)
recur1(recur2, recur1(recur2, 1))

(1)  recur1(recur2, recur1(recur2, 1))
  (2)  recur2, recur1(recur2, 1)
    (3) recur1(recur2, 1)
      (4)  recur2  /*  For arg 1 */
      (5)  1       /*  For arg 2 */
    (6)  recur2(recur3, 1)
      (7)  recur3  /*  For arg 1 */
      (8)  1       /*  For arg 2 */
    (9)  recur4(recur3(1), recur4(recur3(1), ,),) |recur3|
    (10) recur4(recur3(1), recur4(recur3(1), ,),)
      (11)  recur3(1), recur4(recur3(1), ,),
        (12)  [ 1 ]
        (13)  recur4(recur3(1), ,)
          (14)  [ 1 ] /*  First arg to (13) */
          (15)        /*  Second arg to (13) */
          (16)        /*  Third arg to (13) */
        (17) [ 1 ]- -
      (18) [ 1 ],[ 1 ]- -,
      (19) [ 1 ]    /*  First arg */
      (20) [ 1 ]- -  /*  Second arg */
      (21)          /*  Third arg */
    (22) [ 1 ]-[ 1 ]- - -
    (23) [ 1 ]-[ 1 ]- - - |recur3|
  (24)  recur2, [ 1 ]-[ 1 ]- - - |recur3|
(25)  recur1(recur2, [ 1 ]-[ 1 ]- - - |recur3|)
  (26)  recur2(recur3, [ 1 ]-[ 1 ]- - - |recur3|)
    (27)  recur4(recur3([ 1 ]-[ 1 ]- - - |recur3|), recur4(recur3([ 1 ]-[ 1 ]- - - |recur3|), ,),) |recur3|
      (28)  recur4(recur3([ 1 ]-[ 1 ]- - - |recur3|), recur4(recur3([ 1 ]-[ 1 ]- - - |recur3|), ,),)
        (29)  recur3([ 1 ]-[ 1 ]- - - |recur3|), recur4(recur3([ 1 ]-[ 1 ]- - - |recur3|), ,),
          (30)  recur3([ 1 ]-[ 1 ]- - - |recur3|)              /*  Arg 1 */
          (31)  recur4(recur3([ 1 ]-[ 1 ]- - - |recur3|), ,)   /*  Arg 2 */
          (32)                                                 /*  Arg 3 */
            (33) [ [ 1 ]-[ 1 ]- - - |recur3| ]
              (34)  recur3([ 1 ]-[ 1 ]- - - |recur3|)   /*  Arg 1 */
              (35)                                      /*  Arg 2 */
              (36)                                      /*  Arg 3 */
                (37)  [ [ 1 ]-[ 1 ]- - - |recur3| ]
                (38) [ [ 1 ]-[ 1 ]- - - |recur3| ]- -