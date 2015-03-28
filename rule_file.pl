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

%% Here it was sepcified that we should return a list of transitions. Transtitions are defined as [Source, Destination, Event, Guard, Action]
inheritss_transitions(State, List) :- findall([Source, Destination, Event, Guard, Action], (ancestor(Source, State), transition(Source, Destination, Event, Guard, Action)), List).

all_states(L) :- findall(State, state(State), L).

all_init_states(L) :- findall(State, initial_state(State, _), L).

get_starting_state(State) :- initial_state(State, null).

state_is_reflexive(State) :- transition(State, State, _, _, _).

graph_is_reflexive :- findall(State, transition(State, State, _, _, _), L1),
						list_to_set(L1, Set),
						all_states(L2),
						same_length(L1, L2).
						
get_guards(Ret) :- findall(Guard, (transition(_, _, _, Guard, _), Guard \= null), L),
					list_to_set(L, Ret).

%% We are assuming that a null Event does not qualify as an Event
get_events(Ret) :- findall(Event, (transition(_, _, Event, _, _), Event \= null), L),
					list_to_set(L, Ret).

%% We are asuming that a null Action does not qualify as an Action
get_actions(Ret) :- findall(Action, (transition(_, _, _, _, Action), Action \= null), L),
					list_to_set(L, Ret).

