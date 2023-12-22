---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_170322681544614000 == 
Cardinality(1..4)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170322681544614000>>)
----

=============================================================================
\* Modification History
\* Created Fri Dec 22 14:33:35 CST 2023 by xiongxin
