/decl/thermonuclear_reaction
	var/decl/material/first_reactant = null
	var/decl/material/second_reactant = null
	var/decl/material/product = null
	var/cross_section = 100 // modifier for how much moles fuse at present
	var/mean_energy = 0 //per mole
	var/free_neutron_moles = 0
	var/minimum_temperature = 300000 //that is considered cold fusion lol

/decl/thermonuclear_reaction/hydrogen_hydrogen
	first_reactant = /decl/material/gas/hydrogen
	second_reactant = /decl/material/gas/hydrogen
	product = /decl/material/gas/helium
	mean_energy = 620000000000
	minimum_temperature = 110 MEGAKELVIN
	free_neutron_moles = 1
	cross_section = 20

/decl/thermonuclear_reaction/deuterium_tritium
	first_reactant = /decl/material/gas/hydrogen/deuterium
	second_reactant = /decl/material/gas/hydrogen/tritium
	product = /decl/material/gas/helium
	mean_energy = 337695000000
	minimum_temperature = 90 MEGAKELVIN
	free_neutron_moles = 1.5
	cross_section = 150

/decl/thermonuclear_reaction/deuterium_deuterium
	first_reactant = /decl/material/gas/hydrogen/deuterium
	second_reactant = /decl/material/gas/hydrogen/deuterium
	product = /decl/material/gas/hydrogen/tritium
	mean_energy = 106132000000
	minimum_temperature = 130 MEGAKELVIN
	free_neutron_moles = 0
	cross_section = 110

/decl/thermonuclear_reaction/helium3_helium3
	first_reactant = /decl/material/gas/helium/isotopethree
	second_reactant = /decl/material/gas/helium/isotopethree
	product = /decl/material/gas/helium
	mean_energy = 620000000000
	minimum_temperature = 170 MEGAKELVIN
	free_neutron_moles = 3
	cross_section = 150

/decl/thermonuclear_reaction/deuterium_helium3
	first_reactant = /decl/material/gas/hydrogen/deuterium
	second_reactant = /decl/material/gas/helium/isotopethree
	product = /decl/material/gas/helium
	mean_energy = 347344000000
	minimum_temperature = 130 MEGAKELVIN
	free_neutron_moles = 0