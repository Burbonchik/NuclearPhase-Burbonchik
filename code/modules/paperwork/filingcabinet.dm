/////////////////////////////////////////////////////////////////
// Filling Cabinet
/////////////////////////////////////////////////////////////////
/obj/structure/filing_cabinet
	name                   = "filing cabinet"
	desc                   = "A large cabinet with drawers."
	icon                   = 'icons/obj/structures/filling_cabinets.dmi'
	icon_state             = "filingcabinet"
	material               = /decl/material/solid/metal/steel
	density                = TRUE
	anchored               = TRUE
	atom_flags             = ATOM_FLAG_CLIMBABLE
	obj_flags              = OBJ_FLAG_ANCHORABLE
	tool_interaction_flags = TOOL_INTERACTION_ANCHOR | TOOL_INTERACTION_DECONSTRUCT
	var/tmp/list/can_hold  = list(
		/obj/item/paper,
		/obj/item/folder,
		/obj/item/photo,
		/obj/item/paper_bundle,
		/obj/item/forensics/sample)

/obj/structure/filingcabinet/chestdrawer
	name = "chest drawer"
	icon_state = "chestdrawer"

/obj/structure/filingcabinet/wallcabinet
	name = "wall-mounted filing cabinet"
	desc = "A filing cabinet installed into a cavity in the wall to save space. Wow!"
	icon_state = "wallcabinet"
	density = 0
	obj_flags = 0


/obj/structure/filingcabinet/filingcabinet	//not changing the path to avoid unecessary map issues, but please don't name stuff like this in the future -Pete
	icon_state = "tallcabinet"


/obj/structure/filingcabinet/Initialize()
	for(var/obj/item/I in loc)
		if(is_type_in_list(I, can_hold))
			I.forceMove(src)
	. = ..()

/obj/structure/filingcabinet/attackby(obj/item/P, mob/user)
	if(is_type_in_list(P, can_hold))
		if(!user.unEquip(P, src))
			return
		add_fingerprint(user)
		to_chat(user, "<span class='notice'>You put [P] in [src].</span>")
		flick("[initial(icon_state)]-open",src)
		updateUsrDialog()
	else
		..()

/obj/structure/filingcabinet/attack_hand(mob/user)
	if(contents.len <= 0)
		to_chat(user, "<span class='notice'>\The [src] is empty.</span>")
		return

	user.set_machine(src)
	var/dat = list("<center><table>")
	for(var/obj/item/P in src)
		dat += "<tr><td><a href='?src=\ref[src];retrieve=\ref[P]'>[P.name]</a></td></tr>"
	dat += "</table></center>"
	show_browser(user, "<html><head><title>[name]</title></head><body>[jointext(dat,null)]</body></html>", "window=filingcabinet;size=350x300")

/obj/structure/filingcabinet/Topic(href, href_list)
	if(href_list["retrieve"])
		show_browser(usr, "", "window=filingcabinet") // Close the menu

		//var/retrieveindex = text2num(href_list["retrieve"])
		var/obj/item/P = locate(href_list["retrieve"])//contents[retrieveindex]
		if(istype(P) && (P.loc == src) && src.Adjacent(usr))
			usr.put_in_hands(P)
			updateUsrDialog()
			flick("[initial(icon_state)]-open",src)
