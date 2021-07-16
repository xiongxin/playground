declare Pascal AddList ShiftLeft ShiftRight
fun {Pascal N}
    if N==1 then [1]
    else
        {AddList {ShiftLeft {Pascal N-1}} {ShiftRight {Pascal N-1}}}
    end
end

fun {ShiftLeft L}
    case L of H|T then
        H|{ShiftLeft T}
    else [0] end
end


fun {ShiftRight L} 0|L end

fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1+H2|{AddList T1 T2}
      end
   else nil end
end


fun {FastPascal N}
   if N==1 then [1]
   else L in
      L={FastPascal N-1}
      {AddList {ShiftLeft L} {ShiftRight L}}
   end
end

fun lazy {Ints N}
   N|{Ints N+1}
end

fun lazy {PascalList Row}
   Row|{PascalList
	{AddList {ShiftLeft Row} {ShiftRight Row}}}
end

fun lazy {PascalList2 N Row}
   if N==1 then [Row]
   else
      Row|{PascalList
	   {AddList {ShiftLeft Row} {ShiftRight Row}}}
   end
end



declare X in
thread {Delay 3000} X=99 end
{Browse start} {Browse X*X}