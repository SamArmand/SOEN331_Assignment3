is_loop(Event, Guard) :- transition(X, X, Event, Guard, _).

all_loops(Set) :- findall([Event, Guard], transition(X, X, Event, Guard, _), L),
					list_to_set(L, Set).

is_edge(Event, Guard) :- transition(_, _, Event, Guard, _).
