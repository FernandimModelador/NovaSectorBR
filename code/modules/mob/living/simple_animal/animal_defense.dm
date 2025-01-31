/mob/living/simple_animal/attack_hand(mob/living/carbon/human/user, list/modifiers)
	// so that martial arts don't double dip
	if (..())
		return TRUE

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		user.disarm(src)
		return TRUE

	if(!user.combat_mode)
		if (stat == DEAD)
			return
		visible_message(span_notice("[user] [response_help_continuous] [src]."), \
						span_notice((client.language == LANGUAGE_ENGLISH ? ("[user] [response_help_continuous] you.") : client.language == LANGUAGE_PORTUGUESE ? "[user] [response_help_continuous] você." : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 14 ")), null, null, user)
		to_chat(user, span_notice((client.language == LANGUAGE_ENGLISH ? ("You [response_help_simple] [src].") : client.language == LANGUAGE_PORTUGUESE ? "Você [response_help_simple] [src]." : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 15 ")))
		playsound(loc, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)
	else
		if(HAS_TRAIT(user, TRAIT_PACIFISM))
			to_chat(user, span_warning((client.language == LANGUAGE_ENGLISH ? ("You don't want to hurt [src]!") : client.language == LANGUAGE_PORTUGUESE ? "Você não quer machucar [src]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 19 ")))
			return
		if(check_block(user, harm_intent_damage, "[user]'s punch", UNARMED_ATTACK, 0, BRUTE))
			return
		user.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
		visible_message(span_danger("[user] [response_harm_continuous] [src]!"),\
						span_userdanger((client.language == LANGUAGE_ENGLISH ? ("[user] [response_harm_continuous] you!") : client.language == LANGUAGE_PORTUGUESE ? "[user] [response_harm_continuous] você!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 25 ")), null, COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_danger((client.language == LANGUAGE_ENGLISH ? ("You [response_harm_simple] [src]!") : client.language == LANGUAGE_PORTUGUESE ? "Você [response_harm_simple] [src]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 26 ")))
		playsound(loc, attacked_sound, 25, TRUE, -1)
		apply_damage(harm_intent_damage)
		log_combat(user, src, "attacked")
		return TRUE

/mob/living/simple_animal/get_shoving_message(mob/living/shover, obj/item/weapon, shove_flags)
	if(weapon) // no "gently pushing aside" if you're pressing a shield at them.
		return ..()
	var/moved = !(shove_flags & SHOVE_BLOCKED)
	shover.visible_message(
		span_danger((client.language == LANGUAGE_ENGLISH ? ("[shover.name] [response_disarm_continuous] [src][moved ? ", pushing [p_them()]" : ""]!") : client.language == LANGUAGE_PORTUGUESE ? "[shover.name] [response_disarm_continuous] [src][moved ? ", empurrando [p_them()]" : ""]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 37 ")),
		span_danger((client.language == LANGUAGE_ENGLISH ? ("You [response_disarm_simple] [src][moved ? ", pushing [p_them()]" : ""]!") : client.language == LANGUAGE_PORTUGUESE ? "Você [response_disarm_simple] [src][moved ? ", empurrando [p_them()]" : ""]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 38 ")),
		span_hear((client.language == LANGUAGE_ENGLISH ? ("You hear aggressive shuffling!") : client.language == LANGUAGE_PORTUGUESE ? "Você ouve uma movimentação agressiva!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 39 ")),
		COMBAT_MESSAGE_RANGE,
		list(src),
	)
	to_chat(src, span_userdanger((client.language == LANGUAGE_ENGLISH ? ("You're [moved ? "pushed" : "shoved"] by [shover.name]!") : client.language == LANGUAGE_PORTUGUESE ? "Você é [moved ? "empurrado" : "jogado"] por [shover.name]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 43 ")))

/mob/living/simple_animal/attack_hulk(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	playsound(loc, SFX_PUNCH, 25, TRUE, -1)
	visible_message(span_danger((client.language == LANGUAGE_ENGLISH ? ("[user] punches [src]!") : client.language == LANGUAGE_PORTUGUESE ? "[user] soca [src]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 50 ")), \
					span_userdanger((client.language == LANGUAGE_ENGLISH ? ("You're punched by [user]!") : client.language == LANGUAGE_PORTUGUESE ? "Você leva um soco de [user]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 51 ")), null, COMBAT_MESSAGE_RANGE, user)
	to_chat(user, span_danger((client.language == LANGUAGE_ENGLISH ? ("You punch [src]!") : client.language == LANGUAGE_PORTUGUESE ? "Você soca [src]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 52 ")))
	adjustBruteLoss(15)

/mob/living/simple_animal/attack_paw(mob/living/carbon/human/user, list/modifiers)
	if(..()) //successful monkey bite.
		if(stat != DEAD)
			return apply_damage(rand(1, 3))
	if (!user.combat_mode)
		if (health > 0)
			visible_message(span_notice("[user.name] [response_help_continuous] [src]."), \
							span_notice((client.language == LANGUAGE_ENGLISH ? ("[user.name] [response_help_continuous] you.") : client.language == LANGUAGE_PORTUGUESE ? "[user.name] [response_help_continuous] você." : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 62 ")), null, COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_notice((client.language == LANGUAGE_ENGLISH ? ("You [response_help_simple] [src].") : client.language == LANGUAGE_PORTUGUESE ? "Você [response_help_simple] [src]." : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 63 ")))
			playsound(loc, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)


/mob/living/simple_animal/attack_alien(mob/living/carbon/alien/adult/user, list/modifiers)
	if(..()) //if harm or disarm intent.
		if(LAZYACCESS(modifiers, RIGHT_CLICK))
			playsound(loc, 'sound/items/weapons/pierce.ogg', 25, TRUE, -1)
			visible_message(span_danger("[user] [response_disarm_continuous] [name]!"), \
							span_userdanger((client.language == LANGUAGE_ENGLISH ? ("[user] [response_disarm_continuous] you!") : client.language == LANGUAGE_PORTUGUESE ? "[user] [response_disarm_continuous] você!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 72 ")), null, COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_danger((client.language == LANGUAGE_ENGLISH ? ("You [response_disarm_simple] [name]!") : client.language == LANGUAGE_PORTUGUESE ? "Você [response_disarm_simple] [name]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 73 ")))
			log_combat(user, src, "disarmed")
		else
			var/damage = rand(user.melee_damage_lower, user.melee_damage_upper)
			visible_message(span_danger((client.language == LANGUAGE_ENGLISH ? ("[user] slashes at [src]!") : client.language == LANGUAGE_PORTUGUESE ? "[user] corta [src]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 77 ")), \
							span_userdanger((client.language == LANGUAGE_ENGLISH ? ("You're slashed at by [user]!") : client.language == LANGUAGE_PORTUGUESE ? "Você é cortado por [user]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 78 ")), null, COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_danger((client.language == LANGUAGE_ENGLISH ? ("You slash at [src]!") : client.language == LANGUAGE_PORTUGUESE ? "Você corta [src]!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 79 ")))
			playsound(loc, 'sound/items/weapons/slice.ogg', 25, TRUE, -1)
			apply_damage(damage)
			log_combat(user, src, "attacked")
		return 1

/mob/living/simple_animal/attack_larva(mob/living/carbon/alien/larva/L, list/modifiers)
	. = ..()
	if(. && stat != DEAD) //successful larva bite
		var/damage_done = apply_damage(rand(L.melee_damage_lower, L.melee_damage_upper), BRUTE)
		if(damage_done > 0)
			L.amount_grown = min(L.amount_grown + damage_done, L.max_grown)

/mob/living/simple_animal/attack_drone(mob/living/basic/drone/user)
	if(user.combat_mode) //No kicking dogs even as a rogue drone. Use a weapon.
		return
	return ..()

/mob/living/simple_animal/attack_drone_secondary(mob/living/basic/drone/user)
	if(user.combat_mode)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	return ..()

/mob/living/simple_animal/ex_act(severity, target, origin)
	. = ..()
	if(!. || QDELETED(src))
		return FALSE

	switch (severity)
		if (EXPLODE_DEVASTATE)
			ex_act_devastate()
		if (EXPLODE_HEAVY)
			ex_act_heavy()
		if (EXPLODE_LIGHT)
			ex_act_light()

	return TRUE

/// Called when a devastating explosive acts on this mob
/mob/living/simple_animal/proc/ex_act_devastate()
	var/bomb_armor = getarmor(null, BOMB)
	if(prob(bomb_armor))
		adjustBruteLoss(500)
	else
		investigate_log("has been gibbed by an explosion.", INVESTIGATE_DEATHS)
		gib()

/// Called when a heavy explosive acts on this mob
/mob/living/simple_animal/proc/ex_act_heavy()
	var/bomb_armor = getarmor(null, BOMB)
	var/bloss = 60
	if(prob(bomb_armor))
		bloss = bloss / 1.5
	adjustBruteLoss(bloss)

/// Called when a light explosive acts on this mob
/mob/living/simple_animal/proc/ex_act_light()
	var/bomb_armor = getarmor(null, BOMB)
	var/bloss = 30
	if(prob(bomb_armor))
		bloss = bloss / 1.5
	adjustBruteLoss(bloss)

/mob/living/simple_animal/blob_act(obj/structure/blob/B)
	adjustBruteLoss(20)
	return

/mob/living/simple_animal/do_attack_animation(atom/A, visual_effect_icon, used_item, no_effect)
	if(!no_effect && !visual_effect_icon && melee_damage_upper)
		if(attack_vis_effect && !iswallturf(A)) // override the standard visual effect.
			visual_effect_icon = attack_vis_effect
		else if(melee_damage_upper < 10)
			visual_effect_icon = ATTACK_EFFECT_PUNCH
		else
			visual_effect_icon = ATTACK_EFFECT_SMASH
	..()

/mob/living/simple_animal/emp_act(severity)
	. = ..()
	if(mob_biotypes & MOB_ROBOTIC)
		switch (severity)
			if (EMP_LIGHT)
				visible_message(span_danger((client.language == LANGUAGE_ENGLISH ? ("[src] shakes violently, its parts coming loose!") : client.language == LANGUAGE_PORTUGUESE ? "[src] treme violentamente, suas partes se soltando!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 161 ")))
				apply_damage(maxHealth * 0.6)
				Shake(duration = 1 SECONDS)
			if (EMP_HEAVY)
				visible_message(span_danger((client.language == LANGUAGE_ENGLISH ? ("[src] suddenly bursts apart!") : client.language == LANGUAGE_PORTUGUESE ? "[src] explode de repente!" : "Error: code/modules/mob/living/simple_animal/animal_defense.dm line: 165 ")))
				apply_damage(maxHealth)
