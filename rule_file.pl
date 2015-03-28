is_loop(Event, Guard) :- transition(X, X, Event, Guard, _).

all_loops(Set) :- findall([Event, Guard], transition(X, X, Event, Guard, _), L),
					list_to_set(L, Set).

is_edge(Event, Guard) :- transition(_, _, Event, Guard, _).

size(Length) :- findall([Event, Guard], transition(_, _, Event, Guard, _), L),
					length(L, Length).

is_link(Event, Guard) :- transition(X, Y, Event, Guard, _), X \= Y.

all_superstates(Set) :- findall(State, superstate(State, _), L),
						list_to_set(L, Set).

ancestor(Ancestor, Descendent) :- superstate(Ancestor, Descendent); 
									(superstate(Ancestor, X), ancestor(X, Descendent)). 

%% inherits 

all_states(L) :- findall(State, state(State), L).

all_init_states(L) :- findall(State, initial_state(State, _), L).

get_starting_state(State) :- initial_state(State, null).