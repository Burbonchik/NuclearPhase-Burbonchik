/obj/item/energy_blade/axe
	name = "energy axe"
	desc = "An energised battle axe."
	icon = 'icons/obj/items/weapon/e_axe.dmi'
	lighting_color = COLOR_SABER_AXE
	active_force = 60
	active_throwforce = 35
	force = 20
	throwforce = 10
	throw_speed = 1
	throw_range = 5
	w_class = ITEM_SIZE_NORMAL
	atom_flags = ATOM_FLAG_NO_BLOOD
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	origin_tech = @'{"magnets":3,"combat":4}'
	active_attack_verb =   list("attacked", "chopped", "cleaved", "torn", "cut")
	inactive_attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	sharp = 1
	edge =  1
	base_parry_chance =    30
	active_parry_chance =  30
	melee_accuracy_bonus = 15
