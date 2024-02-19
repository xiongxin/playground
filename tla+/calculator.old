----------------------------- MODULE calculator -----------------------------


EXTENDS Integers, TLC
CONSTANT NumInputs, Target

Digits == 0..9

(* --algorithm calculator
variables
    i = 0;
    sum = 0;

define
    Invariant == sum # Target
end define;

begin
    Calculator:
        while i < NumInputs do
            with x \in Digits do
                either
                    \* Add   
                    sum := sum + x;
                or
                    \* Subtract
                    sum := sum - x;
                or
                    \* Multipl
                    sum := sum * x;
                end either;
            end with;
            i := i + 1;
        end while;

end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "eb3d9c4f" /\ chksum(tla) = "2c495b46")
VARIABLES i, sum, pc

(* define statement *)
Invariant == sum # Target


vars == << i, sum, pc >>

Init == (* Global variables *)
        /\ i = 0
        /\ sum = 0
        /\ pc = "Calculator"

Calculator == /\ pc = "Calculator"
              /\ IF i < NumInputs
                    THEN /\ \E x \in Digits:
                              \/ /\ sum' = sum + x
                              \/ /\ sum' = sum - x
                              \/ /\ sum' = sum * x
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
\* Last modified Wed Dec 27 16:00:59 CST 2023 by xiongxin
\* Created Wed Dec 27 15:47:35 CST 2023 by xiongxin
