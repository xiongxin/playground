------------------------------ MODULE pluscal ------------------------------

EXTENDS Integers, TLC

(* --algorithm pluscal
variables
    x = 2;
    y = TRUE;
    z = 100;
    seq = <<1,2>>;
    i = 100;
 
macro inc(var) begin
  if var < 10 then
    var := var + 1;
  end if;
end macro

begin
    Sum:
      while i <= x do
        x := x + seq[i];
        Inc:
          i := i + 1;
      end while;
    A:
      if y then
        B:
          inc(x);
      else
        x := 44;
      end if;
end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "ac26633d" /\ chksum(tla) = "22418258")
VARIABLES x, y, z, seq, i, pc

vars == << x, y, z, seq, i, pc >>

Init == (* Global variables *)
        /\ x = 2
        /\ y = TRUE
        /\ z = 100
        /\ seq = <<1,2>>
        /\ i = 100
        /\ pc = "Sum"

Sum == /\ pc = "Sum"
       /\ IF i <= x
             THEN /\ x' = x + seq[i]
                  /\ pc' = "Inc"
             ELSE /\ pc' = "A"
                  /\ x' = x
       /\ UNCHANGED << y, z, seq, i >>

Inc == /\ pc = "Inc"
       /\ i' = i + 1
       /\ pc' = "Sum"
       /\ UNCHANGED << x, y, z, seq >>

A == /\ pc = "A"
     /\ IF y
           THEN /\ pc' = "B"
                /\ x' = x
           ELSE /\ x' = 44
                /\ pc' = "Done"
     /\ UNCHANGED << y, z, seq, i >>

B == /\ pc = "B"
     /\ IF x < 10
           THEN /\ x' = x + 1
           ELSE /\ TRUE
                /\ x' = x
     /\ pc' = "Done"
     /\ UNCHANGED << y, z, seq, i >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Sum \/ Inc \/ A \/ B
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 

=============================================================================
\* Modification History
\* Last modified Thu Dec 21 11:21:39 CST 2023 by xiongxin
\* Created Wed Dec 20 16:50:13 CST 2023 by xiongxin
