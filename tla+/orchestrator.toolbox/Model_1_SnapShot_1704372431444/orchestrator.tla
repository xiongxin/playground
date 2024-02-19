---- MODULE orchestrator ----
EXTENDS Integers, TLC, FiniteSets

Servers == {"s1", "s2"}

(*--algorithm threads
variables 
  online = Servers;


define
    Invarinat == \E s \in Servers: s \in online
    Satey == \E s \in Servers: [](s \in online)
end define;

process orchestrator = "orchestrator"
begin
  Change:
    while TRUE do
      with s \in Servers do
       either
          await s \notin online;
          online := online \union {s};
        or
          await s \in online;
          await Cardinality(online) > 1;
          online := online \ {s};
        end either;
      end with;
    end while;
end process;

end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "64220aeb" /\ chksum(tla) = "be60770f")
VARIABLE online

(* define statement *)
Invarinat == \E s \in Servers: s \in online
Satey == \E s \in Servers: [](s \in online)


vars == << online >>

ProcSet == {"orchestrator"}

Init == (* Global variables *)
        /\ online = Servers

orchestrator == \E s \in Servers:
                  \/ /\ s \notin online
                     /\ online' = (online \union {s})
                  \/ /\ s \in online
                     /\ Cardinality(online) > 1
                     /\ online' = online \ {s}

Next == orchestrator

Spec == Init /\ [][Next]_vars

\* END TRANSLATION 
====
\* Modification History
\* Last modified Thu Jan 04 20:47:06 CST 2024 by xiongxin
\* Created Thu Jan 04 20:03:37 CST 2024 by xiongxin
