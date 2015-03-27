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

%% Top-level transitions
transition(active, exit, kill, '!inlockdown', null).

%% active transitions
transition(dormant, init, start, null, 'retry = 0').
transition(init, idle, init_ok, null, 'retry = 0').
transition(idle, monitoring, begin_monitoring, null, null).
transition(init, error_diagnosis, init_crash, null, init_err_msg).
transition(error_diagnosis, init, retry_init, 'retry < 3', 'retry++').
transition(error_diagnosis, safe_shutdown, shutdown, 'retry >= 3', null).
transition(safe_shutdown, dormant, sleep, null, null).
transition(idle, error_diagnosis, idle_crash, null, idle_err_msg).
transition(error_diagnosis, idle, idle_rescue, null, null).
transition(monitoring, error_diagnosis, monitor_crash, '!inlockdown', moni_err_msg).
transition(error_diagnosis, monitoring, moni_rescue, null, null).

%% init transitions
transition(boot_hw, senchk, hw_ok, null, null).
transition(senchk, tchk, senok, null, null).
transition(tchk, psichk, t_ok, null, null).
transition(psichk, ready, psi_ok, null, null).

%% monitoring transitions
transition(monidle, regulate_environment, no_contagion, null, null).
transition(monidle, lockdown, contagion_alert, null, '(FACILITY_CRIT_MESG; inlockdown = true)').
transition(lockdown, monidle, purge_succ, null, 'inlockdown = false').
transition(regulate_environment, monidle, after_100ms, null, null).

%% lockdown transitions
transition(prep_vpurge, alt_temp, initiate_purge, null, lock_doors).
transition(prep_vpurge, alt_psi, initiate_purge, null, lock_doors).
transition(alt_temp, risk_assess, tcyc_comp, null, null).
transition(alt_psi, risk_assess, psicyc_comp, null, null).
transition(risk_assess, prep_vpurge, null, 'risk >= 0.01', null).
transition(risk_assess, safe_status, null, 'risk < 0.01', unlock_doors).
transition(safe_status, lockdown_exit, null, null, null).


