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

%% Refine init states
state(boot_hw).
state(senchk).
state(tchk).
state(psichk).
state(ready).

%% Refine monitoring states
state(monidle).
state(regulate_environment).
state(lockdown).

%% Refine lockdown states
state(prep_vpurge).
state(alt_temp).
state(alt_psi).
state(risk_assess).
state(safe_status).
state(lockdown_exit).

