---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_170297838245031000 == 
ToClock(100)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170297838245031000>>)
----

=============================================================================
\* Modification History
\* Created Tue Dec 19 17:33:02 CST 2023 by xiongxin
