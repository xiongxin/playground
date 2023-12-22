---- MODULE MC ----
EXTENDS scratch, TLC

\* Constant expression definition @modelExpressionEval
const_expr_170305510529438000 == 
Range(<<1,2,3>>)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_170305510529438000>>)
----

=============================================================================
\* Modification History
\* Created Wed Dec 20 14:51:45 CST 2023 by xiongxin
