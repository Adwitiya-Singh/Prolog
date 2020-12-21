sublist([],[]).
sublist([H|T], [H|St]) :-
	sublist(T, St).
sublist([_|T], Sublist) :-
	sublist(T, Sublist).
