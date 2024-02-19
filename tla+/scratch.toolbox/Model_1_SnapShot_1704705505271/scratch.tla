------------------------------ MODULE scratch ------------------------------

EXTENDS Integers,Sequences,FiniteSets


MinutesToSenconds(m) == m * 60
Xor(A, B) == A = ~B
S == 1..4
Seq1 == <<8, 2, 7, 4, 3, 1, 3>>


ClockType == (0..23) \X (0..59) \X (0..59)
AddTimes(t1, t2) == <<t1[1] + t2[1], t1[2] + t2[2], t1[3] + t2[3]>>
ToSeconds(time) == time[1]*3600 + time[2]*60 + time[3]
Earlier(t1, t2) == ToSeconds(t1) < ToSeconds(t2)
ToClock(seconds) == CHOOSE x \in ClockType: ToSeconds(x) = seconds % 86400

Range(f) == {f[x] : x \in DOMAIN f}

Prod ==
  LET SS == 1..10 IN
  [p \in SS \X SS |-> p[1] * p[2]]

Zip1(seq1, seq2) ==
  LET Min(a, b) == IF a < b THEN a ELSE b
      N == Min(Len(seq1), Len(seq2))
  IN
    [i \in 1..N |-> <<seq1[i], seq2[i]>>]
\* 排序    
IsSorted(seq) ==
  \A i, j \in 1..Len(seq):
    i < j => seq[i] <= seq[j]
    

=============================================================================
\* Modification History
\* Last modified Thu Jan 04 16:58:24 CST 2024 by xiongxin
\* Created Tue Dec 19 16:07:33 CST 2023 by xiongxin
