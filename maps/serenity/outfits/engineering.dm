/decl/hierarchy/outfit/job/engineering
	abstract_type = /decl/hierarchy/outfit/job/engineering
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/workboots
	pda_slot = slot_l_store_str
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL
	l_pocket = /obj/item/communications/pocket_radio

/decl/hierarchy/outfit/job/engineering/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/engineering/chief_engineer
	name = "Job - Chief Engineer"
	head = /obj/item/clothing/head/hardhat/white
	uniform = /obj/item/clothing/under/chief_engineer
	gloves = /obj/item/clothing/gloves/thick
	pda_type = /obj/item/modular_computer/pda/heads/ce

/decl/hierarchy/outfit/job/engineering/engineer
	name = "Job - Engineer"
	head = /obj/item/clothing/head/hardhat
	uniform = /obj/item/clothing/under/engineer
	r_pocket = /obj/item/t_scanner
	pda_type = /obj/item/modular_computer/pda/engineering

/decl/hierarchy/outfit/job/engineering/engineer_trainee
	name = "Job - Engineer trainee"
	head = /obj/item/clothing/head/hardhat
	uniform = /obj/item/clothing/under/hazard
	r_pocket = /obj/item/t_scanner
	pda_type = /obj/item/modular_computer/pda/engineering

/decl/hierarchy/outfit/job/engineering/atmos
	name = "Job - Atmospheric technician"
	uniform = /obj/item/clothing/under/atmospheric_technician
	belt = /obj/item/storage/belt/utility/atmostech
	pda_type = /obj/item/modular_computer/pda/engineering