---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_170322680850812000 == 
Cardinality(1..2)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170322680850812000>>)
----

=============================================================================
\* Modification History
\* Created Fri Dec 22 14:33:28 CST 2023 by xiongxin
