----------------------------- MODULE calculator -----------------------------


EXTENDS Integers, TLC
CONSTANT NumInputs

Digits == 0..9

(* --algorithm calculator
variables
    i = 0;
    sum = 0;

begin
    Calculator:
        while i < NumInputs do
            with x \in Digits do
                \* Add 
                sum := sum + x;
            end with;
            i := i + 1;
        end while;

end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "9a0fd92b" /\ chksum(tla) = "e80dbe73")
VARIABLES i, sum, pc

vars == << i, sum, pc >>

Init == (* Global variables *)
        /\ i = 0
        /\ sum = 0
        /\ pc = "Calculator"

Calculator == /\ pc = "Calculator"
              /\ IF i < NumInputs
                    THEN /\ \E x \in Digits:
                              sum' = sum + x
                         /\ i' = i + 1
                         /\ pc' = "Calculator"
                    ELSE /\ pc' = "Done"
                         /\ UNCHANGED << i, sum >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Calculator
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 

=============================================================================
\* Modification History
\* Last modified Wed Dec 27 15:56:55 CST 2023 by xiongxin
\* Created Wed Dec 27 15:47:35 CST 2023 by xiongxin
