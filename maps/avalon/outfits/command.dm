/decl/hierarchy/outfit/job/captain
	name = "Job - Captain"
	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/work/heph
	shoes = /obj/item/clothing/shoes/workboots
	id_type = /obj/item/card/id/gold
	pda_type = /obj/item/modular_computer/pda/heads/captain
	backpack_contents = list(/obj/item/storage/box/ids = 1)

/decl/hierarchy/outfit/job/captain/Initialize()
	. = ..()
	backpack_overrides[/decl/backpack_outfit/backpack]      = /obj/item/storage/backpack/captain
	backpack_overrides[/decl/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/cap
	backpack_overrides[/decl/backpack_outfit/messenger_bag] = /obj/item/storage/backpack/messenger/com

/decl/hierarchy/outfit/job/captain/post_equip(var/mob/living/carbon/human/H)
	..()
	if(H.get_age() > 49)
		// Since we can have something other than the default uniform at this
		// point, check if we can actually attach the medal
		var/obj/item/clothing/uniform = H.get_equipped_item(slot_w_uniform_str)
		if(uniform)
			var/obj/item/clothing/accessory/medal/gold/medal = new()
			if(uniform.can_attach_accessory(medal))
				uniform.attach_accessory(null, medal)
			else
				qdel(medal)

/decl/hierarchy/outfit/job/hop
	name = "Job - Head of Personnel"
	uniform = /obj/item/clothing/under/lawyer/infil
	shoes = /obj/item/clothing/shoes/workboots
	id_type = /obj/item/card/id/silver
	pda_type = /obj/item/modular_computer/pda/heads/hop
	backpack_contents = list(/obj/item/storage/box/ids = 1)
