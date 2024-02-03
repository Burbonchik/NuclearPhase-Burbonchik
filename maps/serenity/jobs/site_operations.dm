/datum/job/site_operations
	abstract_type = /datum/job/site_operations
	department_types = list(/decl/department/site_operations)
	total_positions = 1
	spawn_positions = 1
	supervisors = "administration"
	selection_color = "#86263e"
	guestbanned = 1
	allowed_branches = list(
		/datum/mil_branch/civ
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ
		)
	min_skill = list(
		SKILL_LITERACY    = SKILL_ADEPT
	)
	skill_points = 20

/datum/job/site_operations/faid
	title = "Facility AI Director"
	head_position = 1
	supervisors = "the Chief Operations Officer and Chief Security Officer"
	outfit_type = /decl/hierarchy/outfit/job/faid

/datum/job/site_operations/ca
	title = "Chief Architect"
	head_position = 1
	supervisors = "the Chief Operations Officer and Reactor Operations Director"
	outfit_type = /decl/hierarchy/outfit/job/engineering/chief_engineer

/datum/job/site_operations/ss
	title = "Safety Supervisor"
	head_position = 1
	supervisors = "the Chief Operations Officer"
	outfit_type = /decl/hierarchy/outfit/job/sdd

/datum/job/site_operations/sme
	title = "Site Maintenance Engineer"
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Chief Architect, Laboratory Operations Director and Reactor Maintenance Director"
	outfit_type = /decl/hierarchy/outfit/job/engineering/engineer
	access = list(
		access_eva,
		access_tech_storage,
		access_maint_tunnels,
		access_external_airlocks,
		access_construction,
		access_emergency_storage
	)
	minimal_access = list(
		access_eva,
		access_tech_storage,
		access_maint_tunnels,
		access_external_airlocks,
		access_construction,
		access_emergency_storage
	)

/datum/job/site_operations/janitor
	title = "Sanitation Specialist"
	total_positions = 2
	spawn_positions = 2
	access = list(
		access_janitor,
		access_maint_tunnels,
		access_engine,
		access_research,
		access_sec_doors,
		access_medical
	)
	minimal_access = list(
		access_janitor,
		access_maint_tunnels,
		access_engine,
		access_research,
		access_sec_doors,
		access_medical
	)
	alt_titles = list(
		"Custodian",
		"Janitor",
		"Sanitation Technician"
	)
	outfit_type = /decl/hierarchy/outfit/job/service/janitor
	allowed_branches = list(
		/datum/mil_branch/civ
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ
		)
	min_skill = list(
		SKILL_LITERACY = SKILL_ADEPT,
		SKILL_FITNESS  = SKILL_BASIC
	)
	event_categories = list(ASSIGNMENT_JANITOR)
	skill_points = 20
	only_for_whitelisted = FALSE

/datum/job/site_operations/chef
	title = "Provision Specialist"
	total_positions = 2
	spawn_positions = 2
	access = list(
		access_hydroponics,
		access_bar,
		access_kitchen
	)
	minimal_access = list(access_kitchen)
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/service/chef
	allowed_branches = list(
		/datum/mil_branch/civ
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ
		)
	min_skill = list(
		SKILL_LITERACY  = SKILL_ADEPT,
		SKILL_COOKING   = SKILL_ADEPT,
	    SKILL_BOTANY    = SKILL_BASIC,
	    SKILL_CHEMISTRY = SKILL_BASIC
	)
	skill_points = 24