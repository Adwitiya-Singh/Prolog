% ---Begin Code---
%
% TODO: write a procedure named interpret that takes:
% 1.) A bound on the maximum stack depth, with respect
%     to a list of (presumably) recursive calls.
%
% 2.) A list of procedures which we want to bound.
%     Each element in the list is a structure named
%     / of arity 2, where the first parameter is the
%     name of the procedure we want to bound, and the
%     second parameter is the arity of the procedure we
%     want to bound.  For example, if we have the list:
%     [exp/1], this says that we want to bound the exp
%     procedure with arity 1.
%
% 3.) A structure representing a query to execute.
%
% Your interpret procedure needs to handle at least the
% following kinds of Prolog clauses:
% - true
% - conjunction
% - calls
%
% Example queries are shown below, which involve the exp
% and otherExp procedures at the end of this file:
%
% ?- interpret(1, [exp/1], exp(E)).
% E = integer(0) ;
% E = integer(1) ;
% false.
%
% ?- interpret(2, [exp/1], exp(E)).
% E = integer(0) ;
% E = integer(1) ;
% E = plus(integer(0), integer(0)) ;
% E = plus(integer(0), integer(1)) ;
% E = plus(integer(1), integer(0)) ;
% E = plus(integer(1), integer(1)) ;
% false.
%
% ?- interpret(1, [otherExp/1], otherExp(E)).
% E = integer(0) ;
% E = integer(1) ;
% E = integer(2) ;
% E = integer(3) ;
% E = integer(4) ;
% E = integer(5) ;
% E = integer(6) ;
% false.
%

checkExist(Call, X):-
	functor(Call, Name, Arity),
	member(/(Name, Arity), X).

decBound(Now, Next):-
	Now > 0,
	Next is Now -1.

interpret(_, _, true):- !.

interpret(Bound, X, (A, B)):-
	!,
	interpret(Bound, X, A),
	interpret(Bound, X, B).

interpret(Bound, X, Call):-
	(checkExist(Call, X)->
		decBound(Bound, NewBound);
		NewBound is Bound),
	clause(Call, Body),
	interpret(NewBound, X, Body).


% ---Begin Testing-Related Code---
% The test suite can be run like so:
%
% ?- runTests.
%
% It should succeed.  If it doesn't, you can figure
% out which test is failing by tracing expTests,
% allExpsBound, otherExpTests, allOtherExpsBound
%

exp(integer(0)).
exp(integer(1)).
exp(plus(E1, E2)) :-
    exp(E1),
    exp(E2).

allExpsBound(Bound, Exps) :-
    findall(E, interpret(Bound, [exp/1], exp(E)), Exps).

expTests :-
    allExpsBound(0, []),
    allExpsBound(1, [integer(0),
                     integer(1)]),
    allExpsBound(2, [integer(0),
                     integer(1),
                     plus(integer(0), integer(0)),
                     plus(integer(0), integer(1)),
                     plus(integer(1), integer(0)),
                     plus(integer(1), integer(1))]),
    allExpsBound(3, [integer(0),
                     integer(1),
                     plus(integer(0),integer(0)),
                     plus(integer(0),integer(1)),
                     plus(integer(0),plus(integer(0),integer(0))),
                     plus(integer(0),plus(integer(0),integer(1))),
                     plus(integer(0),plus(integer(1),integer(0))),
                     plus(integer(0),plus(integer(1),integer(1))),
                     plus(integer(1),integer(0)),
                     plus(integer(1),integer(1)),
                     plus(integer(1),plus(integer(0),integer(0))),
                     plus(integer(1),plus(integer(0),integer(1))),
                     plus(integer(1),plus(integer(1),integer(0))),
                     plus(integer(1),plus(integer(1),integer(1))),
                     plus(plus(integer(0),integer(0)),integer(0)),
                     plus(plus(integer(0),integer(0)),integer(1)),
                     plus(plus(integer(0),integer(0)),plus(integer(0),integer(0))),
                     plus(plus(integer(0),integer(0)),plus(integer(0),integer(1))),
                     plus(plus(integer(0),integer(0)),plus(integer(1),integer(0))),
                     plus(plus(integer(0),integer(0)),plus(integer(1),integer(1))),
                     plus(plus(integer(0),integer(1)),integer(0)),
                     plus(plus(integer(0),integer(1)),integer(1)),
                     plus(plus(integer(0),integer(1)),plus(integer(0),integer(0))),
                     plus(plus(integer(0),integer(1)),plus(integer(0),integer(1))),
                     plus(plus(integer(0),integer(1)),plus(integer(1),integer(0))),
                     plus(plus(integer(0),integer(1)),plus(integer(1),integer(1))),
                     plus(plus(integer(1),integer(0)),integer(0)),
                     plus(plus(integer(1),integer(0)),integer(1)),
                     plus(plus(integer(1),integer(0)),plus(integer(0),integer(0))),
                     plus(plus(integer(1),integer(0)),plus(integer(0),integer(1))),
                     plus(plus(integer(1),integer(0)),plus(integer(1),integer(0))),
                     plus(plus(integer(1),integer(0)),plus(integer(1),integer(1))),
                     plus(plus(integer(1),integer(1)),integer(0)),
                     plus(plus(integer(1),integer(1)),integer(1)),
                     plus(plus(integer(1),integer(1)),plus(integer(0),integer(0))),
                     plus(plus(integer(1),integer(1)),plus(integer(0),integer(1))),
                     plus(plus(integer(1),integer(1)),plus(integer(1),integer(0))),
                     plus(plus(integer(1),integer(1)),plus(integer(1),integer(1)))]).

% another version, specifically for making sure
% the recursion bound is only applied at the right places.
myMember(H, [H|_]).
myMember(Element, [_|T]) :-
    myMember(Element, T).

otherExp(integer(N)) :-
    myMember(N, [0, 1, 2, 3, 4, 5, 6]).
otherExp(plus(E1, E2)) :-
    otherExp(E1),
    otherExp(E2).

allOtherExpsBound(Bound, Exps) :-
    findall(E, interpret(Bound, [otherExp/1], otherExp(E)), Exps).

otherExpTests :-
    allOtherExpsBound(0, []),
    allOtherExpsBound(1, [integer(0),
                          integer(1),
                          integer(2),
                          integer(3),
                          integer(4),
                          integer(5),
                          integer(6)]),
    allOtherExpsBound(2, [integer(0),
                          integer(1),
                          integer(2),
                          integer(3),
                          integer(4),
                          integer(5),
                          integer(6),
                          plus(integer(0),integer(0)),
                          plus(integer(0),integer(1)),
                          plus(integer(0),integer(2)),
                          plus(integer(0),integer(3)),
                          plus(integer(0),integer(4)),
                          plus(integer(0),integer(5)),
                          plus(integer(0),integer(6)),
                          plus(integer(1),integer(0)),
                          plus(integer(1),integer(1)),
                          plus(integer(1),integer(2)),
                          plus(integer(1),integer(3)),
                          plus(integer(1),integer(4)),
                          plus(integer(1),integer(5)),
                          plus(integer(1),integer(6)),
                          plus(integer(2),integer(0)),
                          plus(integer(2),integer(1)),
                          plus(integer(2),integer(2)),
                          plus(integer(2),integer(3)),
                          plus(integer(2),integer(4)),
                          plus(integer(2),integer(5)),
                          plus(integer(2),integer(6)),
                          plus(integer(3),integer(0)),
                          plus(integer(3),integer(1)),
                          plus(integer(3),integer(2)),
                          plus(integer(3),integer(3)),
                          plus(integer(3),integer(4)),
                          plus(integer(3),integer(5)),
                          plus(integer(3),integer(6)),
                          plus(integer(4),integer(0)),
                          plus(integer(4),integer(1)),
                          plus(integer(4),integer(2)),
                          plus(integer(4),integer(3)),
                          plus(integer(4),integer(4)),
                          plus(integer(4),integer(5)),
                          plus(integer(4),integer(6)),
                          plus(integer(5),integer(0)),
                          plus(integer(5),integer(1)),
                          plus(integer(5),integer(2)),
                          plus(integer(5),integer(3)),
                          plus(integer(5),integer(4)),
                          plus(integer(5),integer(5)),
                          plus(integer(5),integer(6)),
                          plus(integer(6),integer(0)),
                          plus(integer(6),integer(1)),
                          plus(integer(6),integer(2)),
                          plus(integer(6),integer(3)),
                          plus(integer(6),integer(4)),
                          plus(integer(6),integer(5)),
                          plus(integer(6),integer(6))]).

runTests :-
    expTests,
    otherExpTests.
