fun pos d = neg(d-2.0) + 1.0/d
and neg d = if d>0.0 then pos(d-2.0) - 1.0/d
            else 0.0;

4.0 * pos(201.0);
pos(3.0);


(* 递归学习 https://www.youtube.com/watch?v=IJDJ0kBx2LM *)
(* String reversal. *)
fun reverseString input = 
  let val len = String.size(input)
  (* base case *)
  in if len = 1 then input   
  (* each iteration *)
  else String.substring(input, len - 1, 1) 
       ^ reverseString(String.substring(input, 0, len - 1 ))
  end;

(* 来自视频的版本，操作更简洁 *)
fun reverseString input = 
  let val len = String.size(input)
  (* base case *)
  in if len = 0 then input   
  (* each iteration *)
  else reverseString(String.extract(input, 1, NONE)) 
       ^ String.substring(input, 0, 1)
  end;

reverseString("reverseString");

(* 判断是否是回文字串 *)
fun isPalindrome(input) = 
  let val len = String.size(input)
  in if len = 0 orelse len = 1 then true
  else if String.substring(input,0, 1) = 
          String.substring(input,len - 1, 1)
          then isPalindrome(String.substring(input, 1, len - 2))
  else false
  end;

isPalindrome("kayak");

(* Decimal To Binary *)
fun findBinary(decimal, result)= 
  if decimal = 0 then result
  else findBinary(decimal div 2, 
    Int.toString(decimal mod 2) ^ result);

findBinary(4, "");