------------------------------ MODULE scratch ------------------------------

EXTENDS Integers,Sequences,FiniteSets


MinutesToSenconds(m) == m * 60
Xor(A, B) == A = ~B
S == <<"A">>

ClockType == (0..23) \X (0..59) \X (0..59)
AddTimes(t1, t2) == <<t1[1] + t2[1], t1[2] + t2[2], t1[3] + t2[3]>>
ToSeconds(time) == time[1]*3600 + time[2]*60 + time[3]
Earlier(t1, t2) == ToSeconds(t1) < ToSeconds(t2)
ToClock(seconds) == CHOOSE x \in ClockType: ToSeconds(x) = seconds % 86400

Range(seq) == {seq[i]: i \in 1..Len(seq)}
=============================================================================
\* Modification History
\* Last modified Fri Dec 22 14:33:01 CST 2023 by xiongxin
\* Created Tue Dec 19 16:07:33 CST 2023 by xiongxin
