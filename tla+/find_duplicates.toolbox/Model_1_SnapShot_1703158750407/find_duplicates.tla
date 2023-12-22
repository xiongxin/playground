-------------------------- MODULE find_duplicates --------------------------
EXTENDS Integers, Sequences, TLC


S == 1..10
(*--algorithm find_duplicates
variables
  seq \in S \X S \X S \X S;
  index = 1;
  seen = {};
  is_unique = TRUE;
  
  
define
    TypeInvariant ==
        /\ is_unique \in BOOLEAN
        /\ seen \subseteq S
        /\ index \in 1..Len(seq)+1
end define

begin
  is_unique := FALSE;
end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "442c1cd6" /\ chksum(tla) = "52ae683e")
VARIABLES seq, index, seen, is_unique, pc

(* define statement *)
TypeInvariant ==
    /\ is_unique \in BOOLEAN
    /\ seen \subseteq S
    /\ index \in 1..Len(seq)+1


vars == << seq, index, seen, is_unique, pc >>

Init == (* Global variables *)
        /\ seq \in S \X S \X S \X S
        /\ index = 1
        /\ seen = {}
        /\ is_unique = TRUE
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ is_unique' = FALSE
         /\ pc' = "Done"
         /\ UNCHANGED << seq, index, seen >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 
=============================================================================
\* Modification History
\* Last modified Thu Dec 21 19:37:14 CST 2023 by xiongxin
\* Created Thu Dec 21 19:31:58 CST 2023 by xiongxin
