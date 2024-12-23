/obj/machinery/portable_atmospherics
	name = "atmoalter"
	use_power = POWER_USE_OFF
	construct_state = /decl/machine_construction/default/panel_closed
	atom_flags = ATOM_FLAG_CLIMBABLE

	var/datum/gas_mixture/air_contents = new
	var/obj/machinery/atmospherics/portables_connector/connected_port
	var/obj/item/tank/holding
	var/volume = 0
	var/destroyed = 0
	var/start_pressure = ONE_ATMOSPHERE
	var/start_temperature = T20C
	var/contains_fluid = FALSE // whether it should use an alternative calculation
	var/list/initial_gas //a list of binary ratios
	var/maximum_pressure = 90 * ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/get_single_monetary_worth()
	. = ..()
	for(var/gas in air_contents?.gas)
		var/decl/material/gas_data = GET_DECL(gas)
		. += gas_data.get_value() * air_contents.gas[gas] * GAS_WORTH_MULTIPLIER
	. = max(1, round(.))

/obj/machinery/portable_atmospherics/Initialize()
	..()
	var/list/initial_gas_list = list()
	for(var/mat_id in initial_gas)
		var/decl/material/mat = GET_DECL(mat_id)
		if(mat.phase_at_temperature(start_temperature, start_pressure) == MAT_PHASE_GAS)
			initial_gas_list[mat_id] = MolesForPressure(start_pressure) * initial_gas[mat_id]
		else
			initial_gas_list[mat_id] = MolesForVolume(mat_id) * initial_gas[mat_id]
	air_contents = new(volume, start_temperature, initial_gas = initial_gas_list)
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/portable_atmospherics/Destroy()
	QDEL_NULL(air_contents)
	QDEL_NULL(holding)
	. = ..()

/obj/machinery/portable_atmospherics/LateInitialize()
	var/obj/machinery/atmospherics/portables_connector/port = locate() in loc
	if(port)
		connect(port)
		update_icon()

/obj/machinery/portable_atmospherics/Process()
	if(!connected_port) //only react when pipe_network will ont it do it for you
		//Allow for reactions
		air_contents.fire_react()
	else
		update_icon()

/obj/machinery/portable_atmospherics/proc/StandardAirMix()
	return list(
		/decl/material/gas/oxygen = O2STANDARD * MolesForPressure(),
		/decl/material/gas/nitrogen = N2STANDARD *  MolesForPressure())

/obj/machinery/portable_atmospherics/proc/MolesForPressure(var/target_pressure = start_pressure)
	return (target_pressure * volume) / (R_IDEAL_GAS_EQUATION * start_temperature)

/obj/machinery/portable_atmospherics/proc/MolesForVolume(var/decl/material/mat)
	mat = GET_DECL(mat)
	return volume * 0.001 * mat.liquid_density / mat.gas_molar_mass

/obj/machinery/portable_atmospherics/on_update_icon()
	return null

/obj/machinery/portable_atmospherics/proc/connect(obj/machinery/atmospherics/portables_connector/new_port)
	//Make sure not already connected to something else
	if(connected_port || !new_port || new_port.connected_device)
		return 0

	//Make sure are close enough for a valid connection
	if(new_port.loc != loc)
		return 0

	//Perform the connection
	connected_port = new_port
	connected_port.connected_device = src
	connected_port.on = 1 //Activate port updates

	anchored = 1 //Prevent movement

	//Actually enforce the air sharing
	var/datum/pipe_network/network = connected_port.return_network(src)
	if(network && !network.gases.Find(air_contents))
		network.gases += air_contents
		network.update = 1

	return 1

/obj/machinery/portable_atmospherics/proc/disconnect()
	if(!connected_port)
		return 0

	var/datum/pipe_network/network = connected_port.return_network(src)
	if(network)
		network.gases -= air_contents

	anchored = 0

	connected_port.connected_device = null
	connected_port = null

	return 1

/obj/machinery/portable_atmospherics/proc/update_connected_network()
	if(!connected_port)
		return

	var/datum/pipe_network/network = connected_port.return_network(src)
	if (network)
		network.update = 1

/obj/machinery/portable_atmospherics/attackby(var/obj/item/W, var/mob/user)
	if ((istype(W, /obj/item/tank) && !( src.destroyed )))
		if (src.holding)
			return
		if(!user.unEquip(W, src))
			return
		src.holding = W
		update_icon()
		return

	else if(IS_WRENCH(W) && !panel_open)
		if(connected_port)
			disconnect()
			to_chat(user, "<span class='notice'>You disconnect \the [src] from the port.</span>")
			update_icon()
			return
		else
			var/obj/machinery/atmospherics/portables_connector/possible_port = locate(/obj/machinery/atmospherics/portables_connector/) in loc
			if(possible_port)
				if(connect(possible_port))
					to_chat(user, "<span class='notice'>You connect \the [src] to the port.</span>")
					update_icon()
					return
				else
					to_chat(user, "<span class='notice'>\The [src] failed to connect to the port.</span>")
					return
			else
				to_chat(user, "<span class='notice'>Nothing happens.</span>")
				return ..()

	else if (istype(W, /obj/item/scanner/gas))
		return

	return ..()

/obj/machinery/portable_atmospherics/return_air()
	return air_contents

/obj/machinery/portable_atmospherics/powered
	uncreated_component_parts = null
	stat_immune = 0
	use_power = POWER_USE_IDLE
	var/power_rating
	var/power_losses
	var/last_power_draw = 0

/obj/machinery/portable_atmospherics/powered/power_change()
	. = ..()
	if(. && (stat & NOPOWER))
		update_use_power(POWER_USE_IDLE)

/obj/machinery/portable_atmospherics/powered/components_are_accessible(path)
	return panel_open

/obj/machinery/portable_atmospherics/proc/log_open()
	if(length(air_contents?.gas))
		var/list/gases
		for(var/gas in air_contents.gas)
			var/decl/material/gasdata = GET_DECL(gas)
			LAZYADD(gases, gasdata.gas_name)
		if(length(gases))
			log_and_message_admins("opened \the [src], containing [english_list(gases)].")

/obj/machinery/portable_atmospherics/powered/dismantle()
	if(isturf(loc))
		playsound(loc, 'sound/effects/tank_rupture.wav', 10, 1, -3)
		loc.assume_air(air_contents)
	. = ..()