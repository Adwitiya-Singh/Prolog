% ---AST Definition---
%
% There are three kinds of expressions:
%
% 1.) Boolean literals, represented with a structure
%     named lit of arity two, holding the following:
%     1.1.) A logical variable (i.e., a normal Prolog variable)
%     1.2.) Either the atom positive or negative, representing
%           if it a positive or negative (i.e., negated) literal
%
% 2.) Logical and, which represents the idea of performing logical
%     AND on two subexpressions.  This is represented with a structure
%     named and of arity two, holding the following:
%     2.1.) An expression
%     2.2.) Another expression
%
% 3.) Logical or, which represents the idea of performing logical
%     OR on two subexpressions.  This is represented with a structure
%     named or of arity two, holding the following:
%     3.1.) An expression
%     3.2.) Another expression
%
% A more compact representation of all the above information is shown
% below in a variant of a BNF grammar:
%
% x ∈ PrologVariable
% k ∈ LiteralKind ::= positive | negative
% e ∈ Expression ::= lit(x, k) | and(e1, e2) | or(e1, e2)

% ---Code---
%

isTrue(lit(X, positive)):-
	X = true.
isTrue(lit(X, negative)):-
	X = false.
isTrue(and(A, B)):-
	isTrue(A),
	isTrue(B).
isTrue(or(A, B)):-
	isTrue(A);
	isTrue(B).


%
% Takes the following:
% 1.) A Boolean expression, according to the AST definition above.
%
% isTrue succeeds if and only if the input expression is true.
% This means the following:
% - If the expression is a positive literal, it is true as
%   long as the Prolog variable in the literal holds the value true
% - If the expression is a negative literal, it is true as
%   long as the Prolog variable in the literal holds the value false
% - If the expression is an AND node, it is true as long as BOTH
%   subexpressions in the AND are true
% - If the expression is an OR node, it is true as long as EITHER
%   subexpression in the OR is true
%
% You will need to recursively call isTrue.
%
% My reference solution is 7 lines long; if you start needing a lot more
% code than that, ask to make sure you're still on track.
%

% ---Begin Testing-Related Code---
%
% Once you have implemented isTrue, you can run the tests below with the
% following query from the REPL:
%
% ?- runTests.
%
% This should return true on success.  If it doesn't succeed, you'll need
% to figure out which test is failing.  This can be done by running the
% following two queries:
%
% ?- runSatTests.
% ?- runUnsatTests.
%
% If runSatTests fails, then there is a problem with a test that should be
% satisfiable.  If runUnsatTests fails, then there is a problem with a test
% that should be unsatisfiable.  You can isolate things down further with
% the help of trace, like so:
%
% ?- trace(runSatTests).
% ?- runSatTests.
% ?- trace(runUnsatTests).
% ?- runUnsatTests.
%
% trace will show all the calls that are made, along with their arguments.
% The first call that fails corresponds to the test that is failing, and
% the parameters to the call shows the specific test.
%

satTests([and(or(lit(_, positive),
                 lit(B, negative)),
              lit(B, positive)), % (A || !B) && B
          and(or(lit(_, positive),
                 lit(Y, negative)),
              or(lit(Y, negative),
                 lit(_, positive)))]). % (A || !Y) && (!Y || B)

runSatTests([]).
runSatTests([H|T]) :-
    once(isTrue(H)),
    runSatTests(T).

runSatTests :-
    satTests(Tests),
    runSatTests(Tests).

unsatTests([and(lit(X, positive),
                lit(X, negative))]). % X && !X

runUnsatTests([]).
runUnsatTests([H|T]) :-
    \+ isTrue(H),
    runUnsatTests(T).

runUnsatTests :-
    unsatTests(Tests),
    runUnsatTests(Tests).

runTests :-
    runSatTests,
    runUnsatTests.
