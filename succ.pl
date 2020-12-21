add(zero, X, X).
add(succ(zero), X, succ(X)).
add(succ(First), Second, succ(ResultTwo)):-
	add(First, Second, ResultTwo).

lt(zero, succ(_)).
lt(succ(X), succ(Y)):-
	lt(X,Y).

lte(zero, _).
lte(succ(X), succ(Y)):-
	lte(X,Y).

