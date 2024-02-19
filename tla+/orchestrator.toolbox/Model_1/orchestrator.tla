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
    \* 如果系统一直都是s1 s2都存活，所以定义这个时序性属性时，会报错!
    Liveness == ~[](online = Servers)
end define;

fair process orchestrator = "orchestrator"
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
\* BEGIN TRANSLATION (chksum(pcal) = "b6c768b2" /\ chksum(tla) = "f862e000")
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

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(orchestrator)

\* END TRANSLATION 
====
\* Modification History
\* Last modified Thu Jan 04 21:05:37 CST 2024 by xiongxin
\* Created Thu Jan 04 20:03:37 CST 2024 by xiongxin
