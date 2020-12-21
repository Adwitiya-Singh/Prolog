% ---AST Definition---
%
% There are four kinds of expressions:
%
% 1.) True, represented with the atom true
%
% 2.) False, represented with the atom false
%
% 3.) Logical and, which represents the idea of performing logical
%     AND on two subexpressions.  This is represented with a structure
%     named and of arity two, holding the following:
%     3.1.) An expression
%     3.2.) Another expression
%
% 4.) Logical or, which represents the idea of performing logical
%     OR on two subexpressions.  This is represented with a structure
%     named or of arity two, holding the following:
%     4.1.) An expression
%     4.2.) Another expression
%
% A more compact representation of all the above information is shown
% below in a variant of a BNF grammar:
%
% e ∈ Expression ::= 'true | 'false | and(e1, e2) | or(e1, e2)

% ---Code---
%

% and
%
% Takes the following:
% 1.) A Boolean value, represented with either the atom true or false
% 2.) A second Boolean value, using the same representation
% 3.) A third Boolean value, holding the result of performing logical
%     AND on the first two arguments (e.g., true && false is false, etc.)
%
and(_, false, false).
and(false, _, false).
and(true, true, true).

% or

% Takes the following:
% 1.) A Boolean value, represented with either the atom true or false
% 2.) A second Boolean value, using the same representation
% 3.) A third Boolean value, holding the result of performing logical
%     OR on the first two arguments (e.g., true || false is true, etc.)
%
or(_, true, true).
or(true, _, true).
or(false, false, false).

eval(true, true).
eval(false, false).
eval(or(A, B), Result):-
	eval(A, ResultA),
	eval(B, ResultB),
	or(ResultA, ResultB, Result).
eval(and(A, B), Result):-
	eval(A, ResultA),
	eval(B, ResultB),
	and(ResultA, ResultB, Result).

%
% Takes the following:
% 1.) A Boolean expression, using the representation previously described
% 2.) A Boolean value, representing what the Boolean expression evaluates
%     down to.
%
% You need to implement eval.  This should work in a similar manner as the
% Boolean evaluator you previously implemented in Racket.
%
% My reference solution is 10 lines long; if you start needing a lot more
% code than that, ask to make sure you're still on track.
%

% ---Begin Testing-Related Code---
%
% Once you have implemented eval, you can run the tests below with the
% following query from the REPL:
%
% ?- runTests.
%
% This should return true on success.  If it doesn't succeed, you'll need
% to figure out which test is failing.  This can be done by running the
% following two queries:
%
% ?- runTrueTests.
% ?- runFalseTests.
%
% If runTrueTests fails, then there is a problem with a test that should be
% true.  If runFalseTests fails, then there is a problem with a test that
% should be false.  You can isolate things down further with the help of
% trace, like so:
%
% ?- trace(runTrueTests).
% ?- runTrueTests.
% ?- trace(runFalseTests).
% ?- runFalseTests.
%
% trace will show all the calls that are made, along with their arguments.
% The first call that fails corresponds to the test that is failing, and
% the parameters to the call shows the specific test.
%

trueTests([true,
           and(true, true),
           or(true, true),
           or(true, false),
           or(false, true),
           or(and(false, true),
              and(true, true))]).

runTrueTests([]).
runTrueTests([H|T]) :-
    once(eval(H, true)),
    runTrueTests(T).

runTrueTests :-
    trueTests(Tests),
    runTrueTests(Tests).

falseTests([false,
            and(true, false),
            and(false, true),
            and(false, false),
            or(false, false),
            and(or(true, false),
                or(false, false))]).

runFalseTests([]).
runFalseTests([H|T]) :-
    once(eval(H, false)),
    runFalseTests(T).

runFalseTests :-
    falseTests(Tests),
    runFalseTests(Tests).

runTests :-
    runTrueTests,
    runFalseTests.

