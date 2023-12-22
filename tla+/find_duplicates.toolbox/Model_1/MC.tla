---- MODULE MC ----
EXTENDS find_duplicates, TLC

\* CONSTANT definitions @modelParameterConstants:0S
const_17032156825958000 == 
1..10
----

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_17032156825959000 ==
is_unique = TRUE
----
=============================================================================
\* Modification History
\* Created Fri Dec 22 11:28:02 CST 2023 by xiongxin
