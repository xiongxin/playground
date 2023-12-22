-------------------------- MODULE find_duplicates --------------------------
EXTENDS Integers, Sequences, TLC


S == 1..10
(*--algorithm find_duplicates
variables
  seq \in S \X S \X S \X S;
  is_unique = TRUE;
begin
  is_unique := FALSE;
end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "32c69cda" /\ chksum(tla) = "cdacb74b")
VARIABLES seq, is_unique, pc

vars == << seq, is_unique, pc >>

Init == (* Global variables *)
        /\ seq \in S \X S \X S \X S
        /\ is_unique = TRUE
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ is_unique' = FALSE
         /\ pc' = "Done"
         /\ seq' = seq

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 
=============================================================================
\* Modification History
\* Last modified Thu Dec 21 19:33:46 CST 2023 by xiongxin
\* Created Thu Dec 21 19:31:58 CST 2023 by xiongxin
