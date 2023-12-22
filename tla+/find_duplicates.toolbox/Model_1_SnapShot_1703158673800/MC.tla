---- MODULE MC ----
EXTENDS find_duplicates, TLC

\* INIT definition @modelBehaviorNoSpec:0
init_17031586727764000 ==
FALSE/\index = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_17031586727765000 ==
FALSE/\index' = index
----
=============================================================================
\* Modification History
\* Created Thu Dec 21 19:37:52 CST 2023 by xiongxin
