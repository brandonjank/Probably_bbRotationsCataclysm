-- PossiblyEngine Cataclysm Rotation Packager
-- Custom Cataclysm Survival Hunter Rotation
-- Created on Feb 8th 2014 1:00 am

ProbablyEngine.rotation.register_custom(809, "bbHunterSurvival", {
-- PLAYER CONTROLLED: Rabid MUST be on Auto-Cast for Stampede pets to use them :)
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt, Scatter Shot - Right Control
-- GUIDE: http://forum.molten-wow.com/showthread.php?t=226553

-- Haste Soft Cap (T13-4P): 758 (1.66s cobra)
-- Haste HARD Cap: 2665 (1.5s cobra)

--- Proc Chronohunter with Arcane Shot when down
--- Use Call of the Wild (Pet) because auto cast is fucking retarded.
--- HIT CAP IS BROKEN @ 5%

-- COMBAT
	-- Rotation Utilities
	-- TODO: Explosive Trap timer cooldown OSD
	-- cant place traps without target?
    { "pause", "modifier.lcontrol" },
	--{ "pause", "@bbLib.bossMods" },
	{ "pause", "player.buff(Feign Death)" }, -- Feign Death
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	--{ "pause", "player.time >= 300", "toggle.dpstest" } },

	-- Interrupts
    { "Scatter Shot", { "modifier.interruptAt(60)", "target.range < 30", "!target.boss" } }, -- Counter Shot
	
    -- Pet
    --{ "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
	--{ "Mend Pet", { "pet.health <= 50", "pet.exists", "!pet.buff(136)", "pet.range < 40" } }, -- Mend Pet

	-- PvP Abilities
	{ "Master's Call", { "player.state.disorient", "pet.exists", "pet.alive" } },
    { "Master's Call", { "player.state.stun", "pet.exists", "pet.alive" } },
    { "Master's Call", { "player.state.root", "pet.exists", "pet.alive" } },
    { "Master's Call", { "player.state.snare", "pet.exists", "pet.alive" } },
	{ "Scatter Shot", { "toggle.mouseovers", "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.disorient" }, "mouseover" }, -- If casting too?
	{ "Scatter Shot", { "modifier.rcontrol", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.disorient" }, "mouseover" },
	{ "Wyvern Sting", { "toggle.mouseovers", "toggle.pvpmode", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" }, -- If casting too?
	{ "Wyvern Sting", { "modifier.rcontrol", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" }, 
	{ "Trap Launcher", { "modifier.rcontrol", "!player.buff(Trap Launcher)", "player.spell(Ice Trap).cooldown = 0", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", 
		"mouseover.alive", "mouseover.status.disorient", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "ground" }, -- Trap launcher for Ice Trap
	{ "Ice Trap", { "modifier.rcontrol", "player.spell(Scatter Shot).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", 
		"mouseover.status.disorient", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "ground" }, -- Ice Trap on Scatter Shot targets
	{ "Scare Beast", { "toggle.mouseovers", "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(Scare Beast)", "mouseover.creatureType(Beast)" }, "mouseover" },
	{ "Scare Beast", { "toggle.pvpmode", "target.exists", "target.enemy", "target.alive", "!target.debuff(Scare Beast)", "target.creatureType(Beast)" } },
	
	-- TODO: Reactive Deterrence
		
    -- Mouseovers
	--{ "Serpent Sting", { "!modifier.pvpmode", "toggle.mouseovers", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(Serpent Sting)",
		--"!mouseover.state.charm", "@bbLib.notAboutToDie(target)" }, "mouseover" }, -- "target.deathin >= 10",
	
	-- Traps
	{ "Trap Launcher", { "modifier.lalt", "!player.buff" } }, -- Trap Launcher
    { "Explosive Trap", "modifier.lalt", "ground" }, -- Explosive Trap
    { "Ice Trap" , "modifier.lalt", "ground" }, -- Ice Trap
	{ "Snake Trap" , "modifier.lalt", "ground" }, -- Snake Trap
	{ "Trap Launcher", { "modifier.ralt", "!player.buff" } }, -- Trap Launcher for Freezing Trap
	{ "Freezing Trap" , "modifier.ralt", "ground" }, -- Freezing Trap
	
    -- Tranq Shot
    { "Tranquilizing Shot", "target.dispellable(Tranquilizing Shot)", "target" }, -- Tranquilizing Shot

	-- TODO: Boss Functions + hold cooldowns
	-- TODO: Energy Pooling Toggle

    -- Misdirect ( focus -> tank -> pet )
	{{
		{ "Misdirection", { "focus.exists", "focus.alive", "focus.range <= 40", "target.threat > 60" }, "focus" },
		--{ "34477", { "tank.exists", "tank.alive", "tank.range <= 40", "!focus.exists", "target.threat > 60" }, "tank" },
		{ "Misdirection", { "pet.exists", "pet.alive", "pet.range <= 40", "!focus.exists", "!tank.exists", "target.threat > 60" }, "pet" },
	}, {
		"toggle.misdirect", "!toggle.pvpmode", "!target.isPlayer", "!player.buff(Misdirection)", "@bbLib.canMisdirect" 
	}},

	-- Stances
    { "Aspect of the Hawk", { "toggle.aspect", "!player.buff(Aspect of the Hawk)", "!player.moving", "!modifier.last" } },
	{ "Aspect of the Fox", { "toggle.aspect", "!player.buff(Aspect of the Fox)", "player.moving", "!modifier.last" } },
	
	-- Pre DPS Pause
	-- add stop attack?
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- Survivability
	--{ "#5512", { "modifier.cooldowns", "player.health < 40" } }, -- Healthstone (5512)
	--{ "#76097", { "modifier.cooldowns", "player.health < 40", "@bbLib.useHealthPot" } }, -- Master Healing Potion (76097) 
	
	-- Cooldowns
	-- beginning of the fight: Rapid Fire, Call of the Wild, Engineering Abilities, Trinkets, Potion of the Tol'vir
	{ "Rapid Fire", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero" } }, --, "target.boss"
	--{ "53434", "modifier.cooldowns", "pet.exists", "target.exists" }, -- Call of the Wild (pet)
	{ "#gloves", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.buff(Synapse Springs)" } }, -- Synapse Springs TODO: Check if engineer.
	-- Trinkets
	{ "#58145", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.exists", "player.hashero", "@bbLib.useAgiPot" } }, -- Agility Potion (58145)
	--{ "20572", "modifier.cooldowns" }, -- Blood Fury (AP)
	{ "Berserking", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero", "!player.buff(Rapid Fire)" } }, --, "target.boss" 
	
	
	-- Opener
	-- Serpent Sting -> Hunter cooldowns -> Explosive Shot -> Black Arrow -> Cobra Shot <Lock and Load Proc> Explosive Shot -> Arcane Shot -> Explosive Shot -> Cobra Shot -> Explosive Shot -> Cobra Shot <Lock and Load Proc> Repeat Prior.
	
	-- Melee
	--{ "Wing Clip", { "!target.debuff(Wing Clip)", "!target.spell(Explosive Shot).range" } },
	--{ "Raptor Strike", "!target.spell(Explosive Shot).range" },
	-- Kill Command if in melee
	
	-- Lock and Load
	-- Explosive Shot -> Arcane Shot/Cobra Shot -> Explosive Shot -> Arcane/Cobra Shot -> Explosive Shot -> Arcane/Cobra -> Repeat normal rotation.
	{{
		{ "Explosive Shot", "!target.debuff(Explosive Shot)" },
		{ "Kill Shot", "target.health <= 20" },
		{ "Multi-Shot", { "toggle.cleavemode", "player.focus > 65", "!modifier.last", "modifier.last(Explosive Shot)" } }, -- "modifier.enemies > 1"
		{ "Multi-Shot", { "modifier.multitarget", "player.focus > 65", "!modifier.last", "modifier.last(Explosive Shot)" } }, -- "modifier.enemies > 1"
		{ "Arcane Shot", { "!toggle.cleavemode", "!modifier.multitarget", "player.focus > 65", "!modifier.last", "modifier.last(Explosive Shot)" } },
		{ "Cobra Shot", "player.focus < 66", "!modifier.last", "modifier.last(Explosive Shot)" },
	}, {
		"player.buff(Lock and Load)",
	}},

	-- Multi Target 5+
	-- The AoE rotation is Misdirection -> Trap Launcher -> Explosive Trap -> Multi-Shot until out of focus -> Cobra Shot -> Explosive Shot -> Cobra Shot -> Multi-Shot -> Rinse and repeat.
	{{
		{ "Trap Launcher", { "!player.buff(Trap Launcher)", "player.spell(Explosive Trap).cooldown < 5" } }, -- Trap Launcher for Explosive Trap
		{ "Explosive Trap", { "player.buff(Trap Launcher)", "!player.moving" }, "ground" },
		{ "Multi-Shot" },
		--{ "Explosive Shot", { "!target.debuff(Explosive Shot)" } },
		{ "Kill Shot", { "target.health <= 20" } },
		{ "Cobra Shot", { "player.focus < 40" } },
	}, {
		"modifier.multitarget",
	}},
	
	-- Single Target
	{ "Explosive Shot", "!target.debuff(Explosive Shot)" },
	{ "Kill Shot", "target.health <= 20" },
	{ "Black Arrow", { "!target.debuff(Black Arrow)", "@bbLib.notAboutToDie(target)", "!target.name(Son of Flame)" } }, -- "target.deathin >= 8"
	{ "Serpent Sting", { "!target.debuff(Serpent Sting)", "!target.state.charm", "@bbLib.notAboutToDie(target)", "!target.name(Son of Flame)" } }, -- "target.deathin >= 10",
	{ "Multi-Shot", { "toggle.cleavemode", "player.focus > 79" } }, -- "modifier.enemies > 1"
	{ "Arcane Shot", { "!toggle.cleavemode", "player.focus > 79" } },
	
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff(Concussive Shot).any", "target.moving", "!target.immune.snare" } },
	--{ "Concussive Shot", { "target.name(Son of Flame)", "!target.debuff(Concussive Shot).any", "target.moving", "!target.immune.snare" } },
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff(Widow Venom).any", "target.health > 20" } },
	
	{ "Cobra Shot", "player.spell(Explosive Shot).cooldown > 1" },
	{ "Cobra Shot", "player.focus < 44" },
	
},
{
	-- Pauses
    { "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" }, -- Feign Death
	{ "pause", "player.buff(Food)" },
	{ "pause", "player.buff(Drink)" },
	
	{ "Aspect of the Pack", { "toggle.aspect", "player.moving", "!player.buff(Aspect of the Cheetah)", "!player.buff(Aspect of the Pack)", "!modifier.last", "player.party" } }, -- TODO: PLayer party does not work
	{ "Aspect of the Cheetah", { "toggle.aspect", "player.moving", "!player.buff(Aspect of the Cheetah)", "!player.buff(Aspect of the Pack)", "!modifier.last" } },
	
	{ "Camouflage", { "toggle.camomode", "!player.buff(Camouflage)", "!player.debuff(Orb of Power)" } },
	
	-- Pet
	{ "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
	{ "Revive Pet", { "pet.exists", "!pet.alive", "!player.moving" } },
    --{ "Mend Pet", { "pet.health <= 90", "pet.exists", "pet.alive", "!pet.buff(Mend Pet)", "!modifier.last(Call Pet 1)" } },

	-- Traps
	{ "Trap Launcher", { "modifier.lalt", "!player.buff(Trap Launcher)" } },
    { "Explosive Trap", "modifier.lalt", "ground" },
    { "Ice Trap" , "modifier.lalt", "ground" },
	{ "Snake Trap" , "modifier.lalt", "ground" },
	{ "Freezing Trap" , "modifier.ralt", "ground" },
	
	-- Mark
	{ "Hunter's Mark", { "target.exists", "target.alive", "!target.debuff(Hunter's Mark).any" }, "target" },
	
	-- Food / Flask
	-- TODO: flask of spring blossoms
	-- TODO: food mist rice noodles
	-- TODO: PRE POT: Virmen's Bite potion
	
}, 
function()
	ProbablyEngine.toggle.create('callpet', 'Interface\\Icons\\ability_hunter_beastcall', 'Call Pet 1', 'Toggle to keep the pet in your first pet slot out.')
	ProbablyEngine.toggle.create('misdirect', 'Interface\\Icons\\ability_hunter_misdirection', 'Misdirect', 'Toggle usage of Misdirect on Focus>Tank>Pet.')
	ProbablyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('aspect', 'Interface\\Icons\\ability_mount_jungletiger', 'Auto Aspect', 'Automatically switch aspect when moving and not in combat.')
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_hunter_quickshot', 'Use Mouseovers', 'Toggle automatic usage of stings/scatter/etc on eligible mouseover targets.')
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('camomode', 'Interface\\Icons\\ability_hunter_displacement', 'Use Camouflage', 'Toggle the usage Camouflage when out of combat.')
	ProbablyEngine.toggle.create('cleavemode', 'Interface\\Icons\\ability_upgrademoonglaive', 'Cleave Mode', 'Toggle the automatic usage of AoE abilities for 2 to 3 enemies.')

end)
