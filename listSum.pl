sumAll([], 0).
sumAll([H|T], H + RestSum):-
	sumAll(T, RestSum).
