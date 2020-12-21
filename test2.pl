sameLength([], []).
sameLength([_|FT], [_|ST]):-
	sameLength(FT, ST).

prefixSame([], X).
prefixSame([FH|FT], [SH|ST]):-
	FH = SH,
	prefixSame(FT, ST).

treeSum(leaf(X), X).
treeSum(node(X, Y), Result):-
	treeSum(X, LeftSum),
	treeSum(Y, RightSum),
	Result is LeftSum + RightSum.

gen(bool(true)).
gen(bool(false)).
gen(and(E1, E2)):-
	gen(E1),
	gen(E2).
