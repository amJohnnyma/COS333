% Base Case: An empty list results in an empty list.
absPositivesNegatives([], []).

% ignore the 0 and just process the Tail.
absPositivesNegatives([0|Tail], Result) :-
    absPositivesNegatives(Tail, Result).

% Keep the value as is and include it in the result list.
absPositivesNegatives([H|Tail], [H|ResultTail]) :-
    H > 0,
    absPositivesNegatives(Tail, ResultTail).

% Convert to absolute value (H * -1) and include it in the result list.
absPositivesNegatives([H|Tail], [AbsH|ResultTail]) :-
    H < 0,
    AbsH is H * -1,
    absPositivesNegatives(Tail, ResultTail).
