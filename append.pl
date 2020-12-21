myAppend([], Second, Second).
myAppend([Head|Tail], Second, [Head|RestResult]) :-
    myAppend(Tail, Second, RestResult).
    
'my Append'([], Second, Second).
'my Append'([Head|Tail], Second, [Head|RestResult]) :-
    'my Append'(Tail, Second, RestResult).