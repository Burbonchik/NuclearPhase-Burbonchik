/particles/smoke_continuous
	icon = 'icons/effects/96x96.dmi'
	icon_state = "smoke3"
	width = 150
	height = 150
	count = 100
	spawning = 5
	lifespan = 10
	velocity = generator(GEN_CIRCLE, 2, 2)
	fade = 75
	gradient = list(COLOR_GRAY80, COLOR_WHITE)
	color = generator(GEN_NUM, 0, 0.25)
	color_change = generator(GEN_NUM, 0.08, 0.07)
	spin = generator(GEN_NUM, -5, 5)
	rotation = generator(GEN_NUM, -45, 45)
	scale = 0.7
	grow = 0.05
	friction = 0.1
	is_global = TRUE

/particles/smoke_continuous/fire
	gradient = list(COLOR_GRAY20, COLOR_GRAY15)
	velocity = generator(GEN_CIRCLE, 5, 10)
	scale = 0.95
	grow = 0.06