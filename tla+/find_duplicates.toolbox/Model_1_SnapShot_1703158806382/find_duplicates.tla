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
  Iterate:
    while index <= Len(seq) do
      if seq[index] \notin seen then
        seen := seen \union {seq[index]};
      else
        is_unique := FALSE;
      end if;
      index := index + 1;
    end while;
end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "93cc5b4b" /\ chksum(tla) = "47c7d831")
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
        /\ pc = "Iterate"

Iterate == /\ pc = "Iterate"
           /\ IF index <= Len(seq)
                 THEN /\ IF seq[index] \notin seen
                            THEN /\ seen' = (seen \union {seq[index]})
                                 /\ UNCHANGED is_unique
                            ELSE /\ is_unique' = FALSE
                                 /\ seen' = seen
                      /\ index' = index + 1
                      /\ pc' = "Iterate"
                 ELSE /\ pc' = "Done"
                      /\ UNCHANGED << index, seen, is_unique >>
           /\ seq' = seq

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Iterate
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 
=============================================================================
\* Modification History
\* Last modified Thu Dec 21 19:39:51 CST 2023 by xiongxin
\* Created Thu Dec 21 19:31:58 CST 2023 by xiongxin
