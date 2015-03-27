%% We were obliged to create an active composite state in order to deal with the global Kill transition

%% Top-level states
state(active).
state(exit).

%% Overall EFSM states
state(dormant).
state(init).
state(idle).
state(monitoring).
state(error_diagnosis).
state(safe_shutdown).