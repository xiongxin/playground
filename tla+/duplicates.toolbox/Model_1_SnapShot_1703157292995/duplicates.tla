----------------------------- MODULE duplicates -----------------------------
EXTENDS Integers, Sequences, TLC

(*--algorithm dup

variables x \in 1..1000;
begin
  A:
    x := 0;
  B:
    x := x+1;
end algorithm;*)
\* BEGIN TRANSLATION (chksum(pcal) = "4de2b382" /\ chksum(tla) = "8f3e28b5")
VARIABLES x, pc

vars == << x, pc >>

Init == (* Global variables *)
        /\ x \in 1..1000
        /\ pc = "A"

A == /\ pc = "A"
     /\ x' = 0
     /\ pc' = "B"

B == /\ pc = "B"
     /\ x' = x+1
     /\ pc' = "Done"

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == A \/ B
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 

=============================================================================
\* Modification History
\* Last modified Thu Dec 21 19:14:47 CST 2023 by xiongxin
\* Created Thu Dec 21 11:22:30 CST 2023 by xiongxin
