---- MODULE MC ----
EXTENDS find_duplicates, TLC

\* CONSTANT definitions @modelParameterConstants:0S
const_170323615533815000 == 
1..10
----

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_170323615533816000 ==
is_unique = TRUE
----
=============================================================================
\* Modification History
\* Created Fri Dec 22 17:09:15 CST 2023 by xiongxin
