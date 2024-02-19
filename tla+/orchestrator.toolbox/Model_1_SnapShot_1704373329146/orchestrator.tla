---- MODULE orchestrator ----
EXTENDS Integers, TLC, FiniteSets

Servers == {"s1", "s2"}

(*--algorithm threads
variables 
  online = Servers;


define
    Invarinat == \E s \in Servers: s \in online
    \* 任意时刻都有服务器存活
    Satey == \E s \in Servers: [](s \in online)
    \* 并不是所有时刻s1 s2都存活
    Liveness == ~[](online = Servers)
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
\* BEGIN TRANSLATION (chksum(pcal) = "7401bb85" /\ chksum(tla) = "d970a5f5")
VARIABLE online

(* define statement *)
Invarinat == \E s \in Servers: s \in online

Satey == \E s \in Servers: [](s \in online)

Liveness == ~[](online = Servers)


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
\* Last modified Thu Jan 04 20:55:09 CST 2024 by xiongxin
\* Created Thu Jan 04 20:03:37 CST 2024 by xiongxin
