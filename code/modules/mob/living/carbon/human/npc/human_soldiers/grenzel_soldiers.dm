GLOBAL_LIST_INIT(grenzel_aggro, file2list("strings/rt/grenzelsoldieraggrolines.txt"))
GLOBAL_LIST_INIT(grenzelpriest_aggro, file2list("strings/rt/grenzelpriestaggrolines.txt"))

/datum/outfit/job/human/northern/grenzel_soldiers/proc/add_random_grenzel_weapon(mob/living/carbon/human/H)
	var/random_deserter_weapon = rand(1,2)
	switch(random_deserter_weapon)
		if(1)
			r_hand = /obj/item/weapon/sword/sabre
			l_hand = /obj/item/weapon/shield/heater
		if(2)
			r_hand = /obj/item/weapon/polearm/halberd

/datum/outfit/job/human/northern/grenzel_soldiers/proc/add_random_grenzel_beltl_stuff(mob/living/carbon/human/H)
	var/add_random_grenzel_beltl_stuff = rand(1,7)
	switch(add_random_grenzel_beltl_stuff)
		if(1)
			beltl = /obj/item/storage/belt/pouch/food
		if(2)
			beltl = /obj/item/storage/belt/pouch/medicine
		if(3)
			beltl = /obj/item/storage/belt/pouch/coins/poor
		if(4)
			beltl = /obj/item/storage/belt/pouch/coins/mid
		if(5)
			beltl = /obj/item/reagent_containers/glass/bottle/waterskin
		if(6)
			beltl = /obj/item/reagent_containers/glass/bottle/healthpot
		if(7)
			beltl = /obj/item/weapon/scabbard/sword

/datum/outfit/job/human/northern/grenzel_soldiers/proc/add_random_grenzel_beltr_stuff(mob/living/carbon/human/H)
	var/add_random_grenzel_beltr_stuff = rand(1,7)
	switch(add_random_grenzel_beltr_stuff)
		if(1)
			beltr = /obj/item/storage/belt/pouch/food
		if(2)
			beltr = /obj/item/storage/belt/pouch/medicine
		if(3)
			beltr = /obj/item/storage/belt/pouch/coins/poor
		if(4)
			beltr = /obj/item/storage/belt/pouch/coins/mid
		if(5)
			beltr = /obj/item/reagent_containers/glass/bottle/waterskin
		if(6)
			beltr = /obj/item/reagent_containers/glass/bottle/healthpot
		if(7)
			beltr = /obj/item/weapon/scabbard/sword

/mob/living/carbon/human/species/human/northern/grenzel_soldiers
	ai_controller = /datum/ai_controller/human_npc
	faction = list(FACTION_VIKINGS) //used for all hostile NPCs
	ambushable = FALSE
	cmode = 1
	setparrytime = 30
	flee_in_pain = TRUE
	a_intent = INTENT_HELP
	d_intent = INTENT_PARRY
	possible_mmb_intents = list(INTENT_BITE, INTENT_JUMP, INTENT_KICK)

	headprice = 16
	var/is_silent = FALSE /// Determines whether or not we will scream our funny lines at people.

/mob/living/carbon/human/species/human/northern/grenzel_soldiers/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE

/mob/living/carbon/human/species/human/northern/grenzel_soldiers/after_creation()
	..()
	job = "Grenzelhoft Soldier"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/human/northern/grenzel_soldiers)
	update_body()
	SEND_SIGNAL(src, COMSIG_MOB_MODIFY_AGGRO_LINES, GLOB.grenzel_aggro, TRUE)

/datum/attribute_holder/sheet/job/npc/grenzel_soldiers
	attribute_variance = list(
		STAT_STRENGTH = list(2, 4),
		STAT_CONSTITUTION = list(1, 3)
	)
	raw_attribute_list = list(
		STAT_SPEED = 1,
		STAT_ENDURANCE = 3,
		STAT_PERCEPTION = 1,
		/datum/attribute/skill/combat/axesmaces = 40, //NPCs do not get these skills unless a mind takes them over, hopefully in the future someone can fix
		/datum/attribute/skill/combat/whipsflails = 40,
		/datum/attribute/skill/combat/polearms = 40,
		/datum/attribute/skill/combat/swords = 40,
		/datum/attribute/skill/combat/shields = 30,
		/datum/attribute/skill/combat/wrestling = 40,
		/datum/attribute/skill/combat/unarmed = 40,
		/datum/attribute/skill/misc/athletics = 30,
	)

/datum/outfit/job/human/northern/grenzel_soldiers/pre_equip(mob/living/carbon/human/H)
	//Body Stuff
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/npc/grenzel_soldiers)
	armor = /obj/item/clothing/armor/cuirass/grenzelhoft
	shirt = /obj/item/clothing/shirt/grenzelhoft
	neck = /obj/item/clothing/neck/chaincoif
	head = /obj/item/clothing/head/helmet/sallet
	gloves = /obj/item/clothing/gloves/angle/grenzel
	wrists = /obj/item/clothing/wrists/bracers/leather
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/grenzelpants
	shoes = /obj/item/clothing/shoes/rare/grenzelhoft
	add_random_grenzel_weapon(H)
	add_random_grenzel_beltl_stuff(H)
	add_random_grenzel_beltr_stuff(H)

/mob/living/carbon/human/species/human/northern/grenzel_soldiers/grenzel_priest
	headprice = 20

/mob/living/carbon/human/species/human/northern/grenzel_soldiers/grenzel_priest/after_creation()
	..()
	job = "Grenzelhoft Priest"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/human/northern/grenzel_soldiers)
	update_body()
	SEND_SIGNAL(src, COMSIG_MOB_MODIFY_AGGRO_LINES, GLOB.grenzelpriest_aggro, TRUE)

/datum/outfit/job/human/northern/grenzel_soldiers/grenzel_priest/pre_equip(mob/living/carbon/human/H)
	//Body Stuff
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/npc/grenzel_soldiers)
	shirt = /obj/item/clothing/shirt/undershirt/priest
	neck = /obj/item/clothing/neck/psycross/silver
	face = /obj/item/clothing/face/facemask/psydonmask
	head = /obj/item/clothing/head/roguehood/psydon/confessor
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/psydonboots
	r_hand = /obj/item/weapon/polearm/woodstaff/quarterstaff/silver

/mob/living/carbon/human/species/human/northern/grenzel_soldiers/grenzel_knight
	headprice = 32

/mob/living/carbon/human/species/human/northern/grenzel_soldiers/grenzel_knight/after_creation()
	..()
	job = "Grenzelhoft Knight"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/human/northern/grenzel_knight)
	update_body()
	SEND_SIGNAL(src, COMSIG_MOB_MODIFY_AGGRO_LINES, GLOB.grenzel_aggro, TRUE)

/datum/outfit/job/human/northern/grenzel_soldiers/grenzel_knight/pre_equip(mob/living/carbon/human/H)
	//Body Stuff
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.attributes?.add_sheet(/datum/attribute_holder/sheet/job/npc/quest_miniboss)
	armor = /obj/item/clothing/armor/plate/full
	shirt = /obj/item/clothing/armor/chainmail/hauberk
	neck = /obj/item/clothing/neck/bevor
	head = /obj/item/clothing/head/rare/grenzelplate
	gloves = /obj/item/clothing/gloves/plate/blk
	wrists = /obj/item/clothing/wrists/bracers
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/platelegs/blk
	shoes = /obj/item/clothing/shoes/boots/rare/grenzelplate
	ring = /obj/item/clothing/ring/signet/psy
	r_hand = /obj/item/weapon/sword/long/greatsword/zwei/steel
