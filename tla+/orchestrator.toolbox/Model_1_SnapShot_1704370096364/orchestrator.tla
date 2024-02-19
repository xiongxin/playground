---- MODULE orchestrator ----
EXTENDS Integers, TLC, FiniteSets

Servers == {"s1", "s2"}

(*--algorithm threads
variables 
  online = Servers;

process orchestrator = "orchestrator"
begin
  Change:
    while TRUE do
      with s \in Servers do
       await s \notin online;
       online := online \union {s};
      end with;
    end while;
end process;

end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "34c77576" /\ chksum(tla) = "56026e7d")
VARIABLE online

vars == << online >>

ProcSet == {"orchestrator"}

Init == (* Global variables *)
        /\ online = Servers

orchestrator == \E s \in Servers:
                  /\ s \notin online
                  /\ online' = (online \union {s})

Next == orchestrator

Spec == Init /\ [][Next]_vars

\* END TRANSLATION 
====
\* Modification History
\* Last modified Thu Jan 04 20:08:11 CST 2024 by xiongxin
\* Created Thu Jan 04 20:03:37 CST 2024 by xiongxin
