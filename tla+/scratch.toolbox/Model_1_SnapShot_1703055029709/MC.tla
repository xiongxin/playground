---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_170305502867936000 == 
{x*x: x \in 1..4}
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170305502867936000>>)
----

=============================================================================
\* Modification History
\* Created Wed Dec 20 14:50:28 CST 2023 by xiongxin
