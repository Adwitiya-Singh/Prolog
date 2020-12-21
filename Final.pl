decBound(Now, Next):-
	Now > 0,
	Next is Now -1.

gen(_, 0).
gen(_, 1).
gen(Bound, if(E1, E2, E3)):-
	decBound(Bound, NextBound),
	gen(NextBound, E1),
	gen(NextBound, E2),
	gen(NextBound, E3).



swapPairs([], []).
swapPairs([A, B| C], [B, A| Rest]):-
	swapPairs(C, Rest).



interpret(true) :- !.
interpret(=(A, B)):-
	!, 
	A = B.
interpret(is(A, B)):-
	!,
	A is B.

interpret(;(A, B)):-
	interpret(B);
	interpret(A).

interpret((A, B)):-
	interpret(A),
	interpret(B).


interpret(Call):-
	clause(Call, Body),
	interpret(Body). 

foo(X):-
	X = 1; X = 2.