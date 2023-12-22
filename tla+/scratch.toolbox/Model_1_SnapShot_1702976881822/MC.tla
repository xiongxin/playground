---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_170297688080927000 == 
{1, 3} \union {1, 5}
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170297688080927000>>)
----

=============================================================================
\* Modification History
\* Created Tue Dec 19 17:08:00 CST 2023 by xiongxin
