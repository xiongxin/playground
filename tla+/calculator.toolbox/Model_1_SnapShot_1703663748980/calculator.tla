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
        end while;

end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "3a71e08d" /\ chksum(tla) = "9d0cbc5d")
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
                         /\ pc' = "Calculator"
                    ELSE /\ pc' = "Done"
                         /\ sum' = sum
              /\ i' = i

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Calculator
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 

=============================================================================
\* Modification History
\* Last modified Wed Dec 27 15:51:21 CST 2023 by xiongxin
\* Created Wed Dec 27 15:47:35 CST 2023 by xiongxin
