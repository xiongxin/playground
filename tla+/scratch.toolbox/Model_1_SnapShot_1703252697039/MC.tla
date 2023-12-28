---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_17032526959863000 == 
[p, q \in BOOLEAN |-> p => q]
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_17032526959863000>>)
const_expr_170323745917222000 == 
DOMAIN <<"A","B">>
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170323745917222000>>)
----

\* Modification History
\* Created Fri Dec 22 21:44:55 CST 2023 by xiongxin
\* Created Fri Dec 22 17:30:59 CST 2023 by xiongxin