/decl/material/gas
	name = null
	melting_point = 70
	boiling_point = 180 // -90 C - cryogenic liquid threshold
	color = COLOR_GRAY80
	shard_type = SHARD_NONE
	conductive = 0
	value = 0.15
	burn_product = /decl/material/gas/carbon_monoxide
	molar_mass =    0.032 // kg/mol
	latent_heat = 3400 //assuming oxygen
	reflectiveness = 0
	hardness = 0
	weight = 1
	opacity = 0.3
	default_solid_form = /obj/item/stack/material/aerogel
	abstract_type = /decl/material/gas
	min_fluid_opacity = FLUID_MIN_ALPHA
	max_fluid_opacity = 100

/decl/material/gas/Initialize()
	if(!liquid_name)
		liquid_name = "liquid [name]"
	if(!solid_name)
		solid_name = "frozen [name]"
	. = ..()
