---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_170297844454833000 == 
ToClock(86401)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170297844454833000>>)
----

=============================================================================
\* Modification History
\* Created Tue Dec 19 17:34:04 CST 2023 by xiongxin
