---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_170435866387126000 == 
DOMAIN <<8, 2, 7, 4, 3, 1, 3>>
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170435866387126000>>)
----

=============================================================================
\* Modification History
\* Created Thu Jan 04 16:57:43 CST 2024 by xiongxin
