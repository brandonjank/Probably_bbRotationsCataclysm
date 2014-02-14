-- PossiblyEngine Cataclysm Rotation Packager
-- Custom Cataclysm Survival Hunter Rotation
-- Created on Feb 8th 2014 1:00 am

ProbablyEngine.rotation.register_custom(809, "bbHunterSurvival", {
-- PLAYER CONTROLLED: Rabid MUST be on Auto-Cast for Stampede pets to use them :)
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt, Scatter Shot - Right Control

-- COMBAT
	-- Rotation Utilities
	-- TODO: Explosive Trap timer cooldown OSD
	-- cant place traps without target?
    { "pause", "modifier.lcontrol" },
	--{ "pause", "@bbLib.bossMods" },
	{ "pause", "player.buff(5384)" }, -- Feign Death
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	--{ "pause", "player.time >= 300", "toggle.dpstest" } },

	-- Interrupts
    { "147362", { "modifier.interruptAt(80)", "player.range < 40" } }, -- Counter Shot
	
    -- Pet
    --{ "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
	--{ "136", { "pet.health <= 50", "pet.exists", "!pet.buff(136)", "pet.range < 40" } }, -- Mend Pet

	-- PvP Abilities
	{ "53271", { "player.state.disorient", "pet.exists", "pet.alive" } }, -- Master's Call
    { "53271", { "player.state.stun", "pet.exists", "pet.alive" } }, -- Master's Call
    { "53271", { "player.state.root", "pet.exists", "pet.alive" } }, -- Master's Call
    { "53271", { "player.state.snare", "pet.exists", "pet.alive" } }, -- Master's Call
	{ "19503", { "toggle.mouseovers", "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",  -- Scatter Shot
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.disorient" }, "mouseover" }, -- If casting too?
	{ "19503", { "modifier.rcontrol", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", -- Scatter Shot
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.disorient" }, "mouseover" },
	{ "19386", { "toggle.mouseovers", "toggle.pvpmode", "player.spell(19503).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", -- Wyvern Sting
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" }, -- If casting too?
	{ "19386", { "modifier.rcontrol", "player.spell(19503).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", -- Wyvern Sting
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" }, 
	{ "77769", { "modifier.rcontrol", "!player.buff(77769)", "player.spell(13809).cooldown = 0", "player.spell(19503).cooldown > 0", "mouseover.exists", "mouseover.enemy", 
		"mouseover.alive", "mouseover.status.disorient", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "ground" }, -- Trap launcher for Ice Trap
	{ "13809", { "modifier.rcontrol", "player.spell(19503).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", 
		"mouseover.status.disorient", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "ground" }, -- Ice Trap on Scatter Shot targets
	{ "1513", { "toggle.mouseovers", "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(1513)", "mouseover.creatureType(Beast)" }, "mouseover" }, -- Scare Beast
	{ "1513", { "toggle.pvpmode", "target.exists", "target.enemy", "target.alive", "!target.debuff(1513)", "target.creatureType(Beast)" } }, -- Scare Beast
	
	-- TODO: Reactive Deterrence
		
    -- Mouseovers
	{ "1978", { "!modifier.pvpmode", "toggle.mouseovers", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(1978)", -- Serpent Sting --TODO: 118253 may be wrong
		"!mouseover.state.charm", "mouseover.deathin > 10" }, "mouseover" },
	
	-- Traps
	{ "77769", { "modifier.lalt", "!player.buff" } }, -- Trap Launcher
    { "13813", "modifier.lalt", "ground" }, -- Explosive Trap
    { "13809" , "modifier.lalt", "ground" }, -- Ice Trap
	{ "34600" , "modifier.lalt", "ground" }, -- Snake Trap
	{ "77769", { "modifier.ralt", "!player.buff" } }, -- Trap Launcher for Freezing Trap
	{ "1499" , "modifier.ralt", "ground" }, -- Freezing Trap
	
    -- Tranq Shot
    { "19801", "target.dispellable(19801)", "target" }, -- Tranquilizing Shot

	-- TODO: Boss Functions + hold cooldowns
	-- TODO: Energy Pooling Toggle

    -- Misdirect ( focus -> tank -> pet )
	{{
		{ "34477", { "focus.exists", "focus.alive", "focus.range <= 40", "!player.buff(34477)", "target.threat > 60" }, "focus" }, -- Misdirection
		--{ "34477", { "tank.exists", "tank.alive", "tank.range <= 40", "!focus.exists", "target.threat > 60" }, "tank" }, -- Misdirection
		{ "34477", { "pet.exists", "pet.alive", "pet.range <= 40", "!focus.exists", "!tank.exists", "target.threat > 60" }, "pet" }, -- Misdirection
	}, {
		"toggle.misdirect", "!toggle.pvpmode", "!target.isPlayer", "!player.buff(35079)", "!player.buff(34477)", "@bbLib.canMisdirect" 
	}},

	-- Stances
    { "13165", { "toggle.aspect", "!player.buff(13165)", "!player.buff(109260)", "!player.moving" } }, -- Aspect of the Hawk
	
	-- Pre DPS Pause
	-- add stop attack?
	{ "pause", "target.debuff(19386).any" }, -- Wyvern Sting
	{ "pause", "target.debuff(19503).any" }, -- Scatter Shot
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- Survivability
	--{ "#5512", { "modifier.cooldowns", "player.health < 40" } }, -- Healthstone (5512)
	--{ "#76097", { "modifier.cooldowns", "player.health < 40", "@bbLib.useHealthPot" } }, -- Master Healing Potion (76097) 
	
	-- Cooldowns
	{ "3045", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero" } }, -- Rapid Fire
	--{ "53434", "modifier.cooldowns", "pet.exists", "target.exists" }, -- Call of the Wild (pet)
	--{ "#gloves", { "modifier.cooldowns", "pet.exists", "target.exists" } }, -- Synapse Springs TODO: Check if engineer.
	-- Trinkets
	{ "#58145", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.exists", "player.hashero", "@bbLib.useAgiPot" } }, -- Agility Potion (58145)
	--{ "20572", "modifier.cooldowns" }, -- Blood Fury (AP)
	{ "26297", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero", "!player.buff(3045)" } }, -- Berserking


	-- Multi Target
	{{
		{ "77769", { "!player.buff", "player.spell(13813)", "player.spell(13813).cooldown = 0" } }, -- Trap Launcher for Explosive Trap
		{ "13813", "player.buff(77769)", "ground" }, --  Explosive Trap, Trap Launcher
		{ "2643", "modifier.multitarget" }, -- Multi-Shot
		{ "53301", { "modifier.multitarget", "player.buff(56343)", "!target.debuff" } }, -- Explosive Shot, Lock and Load
		{ "53351", { "modifier.multitarget", "target.health <= 20" } }, -- Kill Shot
		{ "77767", { "modifier.multitarget", "player.focus < 40" } }, -- Cobra Shot
	}, {
		"modifier.multitarget",
	}},
	
	-- Single Target
	--TODO: LnL: Explosive Shot -> Arcane/Cobra/Kill -> Explosive Shot -> Arcane/Cobra/Kill -> Explosive Shot
	{ "1978", { "!target.debuff(1978)", "target.deathin >= 10", "!target.state.charm" } }, -- Serpent Sting
	{ "53301", "!target.debuff" }, -- Explosive Shot
	{ "53351", "target.health <= 20" }, -- Kill Shot
	{ "3674", { "!target.debuff(3674)", "target.deathin >= 8" } }, -- Black Arrow , "!target.state.charm" 
	{ "5116", { "toggle.pvpmode", "!target.debuff(5116).any", "target.moving", "!target.immune.snare" } }, -- PvP: Concussive Shot
	{ "82654", { "toggle.pvpmode", "!target.debuff(82654).any", "target.health > 20" } }, -- PvP: Widow Venom
	{ "77767", "target.debuff(1978).duration < 6" }, -- Cobra Shot, Serpent Sting
	{ "2643", { "toggle.cleavemode", "player.focus > 66", "modifier.enemies > 1" } }, -- Multi-Shot
	{ "77769", { "toggle.cleavemode", "modifier.enemies > 2", "!player.buff", "player.spell(13813).cooldown = 0" } }, -- Trap Launcher for Explosive Trap
	{ "13813", { "toggle.cleavemode", "modifier.enemies > 2" }, "ground" }, --  Explosive Trap
	{ "3044", { "player.focus > 66" } }, -- Arcane Shot
	{ "77767", "player.spell(53301).cooldown > 1" }, -- Cobra Shot, Explosive Shot
	{ "77767", "player.focus < 40" }, -- Cobra Shot
	
},
{
	-- Pauses
    { "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(5384)" }, -- Feign Death
	
	{ "5118", { "toggle.aspect", "player.moving", "!player.buff(5118)", "!player.buff(13159)" } }, -- Aspect of the Cheetah, Pack
	{ "51753", { "toggle.camomode", "!player.buff(51753)", "!player.debuff(Orb of Power)" } }, -- Camouflage
	
	-- Pet
	{ "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
	{ "982", { "pet.exists", "!pet.alive", "!player.moving" } }, -- Revive Pet
    { "136", { "pet.health <= 90", "pet.exists", "pet.alive", "!pet.buff(136)" } }, -- Mend Pet

	-- Traps
	{ "77769", { "modifier.lalt", "!player.buff(77769)" } }, -- Trap Launcher
    { "13813", "modifier.lalt", "ground" }, -- Explosive Trap
    { "13809" , "modifier.lalt", "ground" }, -- Ice Trap
	{ "34600" , "modifier.lalt", "ground" }, -- Snake Trap
	{ "1499" , "modifier.ralt", "ground" }, -- Freezing Trap
	
	-- Mark
	{ "1130", { "target.exists", "target.alive", "!target.debuff(1130).any" }, "target" }, -- Hunter's Mark
	
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
