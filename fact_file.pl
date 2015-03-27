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

%% Refine error_diagnosis states
state(error_rcv).
state(applicable_rescues).
state(reset_module_data).
state(error_diagnosis_exit).

%% Initial states
initial_state(active, null).
initial_state(dormant, active).
initial_state(boot_hw, init).
initial_state(monidle, monitoring).
initial_state(prep_vpurge, lockdown).
initial_state(error_rcv, error_diagnosis).

%% Superstates
superstate(active, dormant).
superstate(active, init).
superstate(active, idle).
superstate(active, monitoring).
superstate(active, error_diagnosis).
superstate(active, safe_shutdown).

superstate(init, boot_hw).
superstate(init, senchk).
superstate(init, tchk).
superstate(init, psichk).
superstate(init, ready).

superstate(monitoring, monidle).
superstate(monitoring, regulate_environment).
superstate(monitoring, lockdown).

superstate(lockdown, prep_vpurge).
superstate(lockdown, alt_temp).
superstate(lockdown, alt_psi).
superstate(lockdown, risk_assess).
superstate(lockdown, safe_status).
superstate(lockdown, lockdown_exit).

superstate(error_diagnosis, error_rcv).
superstate(error_diagnosis, applicable_rescues).
superstate(error_diagnosis, reset_module_data).
superstate(error_diagnosis, error_diagnosis_exit).













