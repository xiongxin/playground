---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_170435877839039000 == 
[DOMAIN Seq1 -> Range(Seq1)]
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170435877839039000>>)
----

=============================================================================
\* Modification History
\* Created Thu Jan 04 16:59:38 CST 2024 by xiongxin
