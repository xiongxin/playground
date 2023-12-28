---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_17032526959863000 == 
[p, q \in BOOLEAN |-> p => q]
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_17032526959863000>>)
----

=============================================================================
\* Modification History
\* Created Fri Dec 22 21:44:55 CST 2023 by xiongxin
