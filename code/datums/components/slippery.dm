/datum/component/slippery
	var/force_drop_items = FALSE
	var/knockdown_time = 0
	var/stun_time = 0
	var/lube_flags
	var/datum/callback/callback

/datum/component/slippery/Initialize(_knockdown, _lube_flags = NONE, datum/callback/_callback, _stun, _force_drop = FALSE)
	knockdown_time = max(_knockdown, 0)
	stun_time = max(_stun, 0)
	force_drop_items = _force_drop
	lube_flags = _lube_flags
	callback = _callback
	RegisterSignals(parent, list(COMSIG_MOVABLE_CROSSED, COMSIG_ATOM_ENTERED), PROC_REF(Slip))

/datum/component/slippery/proc/Slip(datum/source, atom/movable/AM)
	var/mob/victim = AM
	if(istype(victim) && !victim.is_flying() && victim.slip(knockdown_time, parent, lube_flags, stun_time, force_drop_items) && callback)
		callback.Invoke(victim)
