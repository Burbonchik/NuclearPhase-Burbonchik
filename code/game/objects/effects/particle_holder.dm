///objects can only have one particle on them at a time, so we use these abstract effects to hold and display the effects. You know, so multiple particle effects can exist at once.
///also because some objects do not display particles due to how their visuals are built
/obj/effect/abstract/particle_holder
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_UNCLICKABLE
	layer = FIRE_LAYER + 0.01
	vis_flags = VIS_INHERIT_PLANE
	appearance_flags = KEEP_APART|TILE_BOUND
	///typepath of the last location we're in, if it's different when moved then we need to update vis contents
	var/last_attached_location_type
	///the main item we're attached to at the moment, particle holders hold particles for something
	var/weakref/weak_attached
	///besides the item we're also sometimes attached to other stuff! (items held emitting particles on a mob)
	var/weakref/weak_additional

/obj/effect/abstract/particle_holder/Initialize(mapload, particle_path = null)
	. = ..()
	if(!loc)
		log_error("particle holder was created with no loc!")
		return INITIALIZE_HINT_QDEL
	weak_attached = weakref(loc)
	particles = SSparticles.get_particle(particle_path)
	update_visual_contents(loc)

/obj/effect/abstract/particle_holder/Destroy(force)
	var/atom/movable/attached = weak_attached.resolve()
	var/atom/movable/additional_attached
	if(weak_additional)
		additional_attached = weak_additional.resolve()
	if(attached)
		attached.vis_contents -= src
	if(additional_attached)
		additional_attached.vis_contents -= src
	return ..()

///signal called when parent is moved
/obj/effect/abstract/particle_holder/proc/on_move(atom/movable/attached, atom/oldloc, direction)
	if(attached.loc.type != last_attached_location_type)
		update_visual_contents(attached)

///logic proc for particle holders, aka where they move.
///subtypes of particle holders can override this for particles that should always be turf level or do special things when repositioning.
///this base subtype has some logic for items, as the loc of items becomes mobs very often hiding the particles
/obj/effect/abstract/particle_holder/proc/update_visual_contents(atom/movable/attached_to)
	//remove old
	if(weak_additional)
		var/atom/movable/resolved_location = weak_additional.resolve()
		if(resolved_location)
			resolved_location.vis_contents -= src
	//add to new
	if(isitem(attached_to) && ismob(attached_to.loc)) //special case we want to also be emitting from the mob
		var/mob/particle_mob = attached_to.loc
		last_attached_location_type = attached_to.loc
		weak_additional = weakref(particle_mob)
		particle_mob.vis_contents += src
	//readd to ourselves
	attached_to.vis_contents |= src