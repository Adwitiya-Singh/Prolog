% Write a procedure that calculates the sum of the numbers in
% a given range.  The parameters to this procedure should be
% as follows:
%
% 1. The low end of the range
% 2. The high end of the range
% 3. The sum of the values in the range
%
% If the low end equals the high end, then the sum should be
% whatever value is equal to the low/high end (the range is
% inclusive).  If the low end is greater than the high end,
% then failure should occur.

sumAll(X, X, X).
sumAll(Low, High, Sum):-
	Low<High,
	NextLow is Low + 1,
	sumAll(NextLow, High, RestSum),
	Sum is Low + RestSum.


% With your summation procedure in hand, the following queries
% should all succeed (do NOT simply hardcode these values!):

% QUERY 1: sumAll(5, 5, 5).
% QUERY 2: sumAll(5, 6, 11).
% QUERY 3: sumAll(0, 3, 6).

% The directPrereq procedure below documents some of the
% prerequisite courses in the course catalog.  Specifically,
% it documents which courses are direct prerequisites to others.
% It should be read as "the first course has the second course as
% a direct prerequisite"

directPrereq(comp410, comp333).
directPrereq(comp410, comp282).
directPrereq(comp410, comp310).
directPrereq(comp333, comp282).
directPrereq(comp282, comp182).
directPrereq(comp282, math150A).
directPrereq(comp182, comp110).
directPrereq(comp110, math150A).
directPrereq(comp310, comp256).
directPrereq(comp256, comp182).
directPrereq(comp256, math150A).
directPrereq(comp256, phil230).

% Write a procedure named prereq which will determine
% if a course transitively has another course as a prerequisite.
% For example, COMP 110 is a prerequisite to COMP 410, even though
% COMP 110 is not a direct prerequisite to COMP 410.  As a hint,
% course A can be a prerequisite to course B in two distinct ways:
%
% 1.) Course A is a direct prerequisite to course B (determined
%     with the help of directPrereq).  This serves as a base case.
% 2.) Course A is a direct prerequisite to course C, and course C
%     is a prerequisite (but not necessarily a direct prerequisite)
%     to course B.  This serves as a recursive case.

prereq(A, B):-
	directPrereq(A, B);
	directPrereq(A, C),
	prereq(C, B).