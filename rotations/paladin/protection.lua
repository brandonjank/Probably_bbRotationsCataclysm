-- PossiblyEngine Cataclysm Rotation Packager
-- Custom Cataclysm Protection Paladin Rotation
-- Created on Dec 25th 2013 1:00 am

ProbablyEngine.rotation.register_custom(839, "bbProtectionPaladin", {
-- PLAYER CONTROLLED: Guardian of Ancient Kings, Divine Shield, Devotion Aura
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Light's Hammer - Left Alt

-- "target.spell(Crusader Strike).range" DOES NTO WORK

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	--{ "pause", "@bbLib.bossMods" },
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- OFF GCD
	{ "Word of Glory", { "player.health < 60", "player.holypower > 2" } },
	{ "Word of Glory", { "player.health < 30", "player.holypower > 1" } },
	{ "Shield of the Righteous", { "player.holypower > 2", "player.buff(Sacred Duty)" } }, -- range check melee
	{ "Shield of the Righteous", { "player.holypower > 2", "player.buff(Inquisition)" } }, -- range check melee
	{ "Inquisition", { "player.holypower > 2", "!player.buff(Inquisition)" } },
  
	-- Buffs
	{ "Seal of Insight", "!player.buff(Seal of Insight)" },
	{ "Devotion Aura", "!player.buff(Devotion Aura)" },
	{ "Blessing of Kings", { "!player.buff(Blessing of Kings).any" } },
	{ "Blessing of Might", { "!player.buff(Blessing of Might).any", "!player.buff(Blessing of Kings)" } },

	-- Interrupts
	{ "Avenger's Shield", "modifier.interrupts" }, 
	{ "Rebuke", "modifier.interrupt" }, --TODO: Interrupt at 50% cast
	{ "Holy Wrath", { "modifier.interrupts", "target.creatureType(Undead)" } }, -- range check 10yd
	{ "Holy Wrath", { "modifier.interrupts", "target.creatureType(Elemental)" } }, -- range check 10yd
	{ "Holy Wrath", { "modifier.interrupts", "target.creatureType(Dragonkin)" } }, -- range check 10yd
	
	
	
	-- Survivability
	{{
		{ "Ardent Defender", "player.health < 25" },
		{ "Lay on Hands", { "player.health < 25", "!player.buff(Ardent Defender)" } },
		{ "Avenging Wrath", "target.boss" },
		{ "Divine Protection", { "player.health < 70", "target.casting.time > 0", "!player.buff(Ardent Defender)", "!player.buff(Guardian of Ancient Kings)" } },
		{ "Holy Shield", "player.health < 95" },
		-- TODO: Use Survival Trinkets
	}, {
		"modifier.cooldowns",
	}},
	{ "Hand of Freedom", { "!modifier.last(Cleanse)", "!player.buff", "player.state.root" }, "player" },
	{ "Hand of Freedom", { "!modifier.last(Cleanse)", "!player.buff", "player.state.snare" }, "player" },
	{ "#5512", { "modifier.cooldowns", "player.health < 30" } }, -- Healthstone (5512)
	{ "Cleanse", { "!modifier.last(Cleanse)", "player.dispellable(Cleanse)" }, "player" }, -- Cleanse Poison or Disease
	
	-- BossMods
	{ "Reckoning", { "toggle.autotaunt", "@bbLib.bossTaunt" } },
	--{ "Righteous Defense", { "toggle.autotaunt", "!target.boss", "!@bbLib.unitIsPlayer(targettarget)" }, "targettarget" },
	--{ "Hand of Sacrifice", { "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.debuff(Assassin's Mark)" }, "mouseover" },
	
	-- Raid Survivability
	{ "Hand of Protection", { "lowest.exists", "lowest.alive", "lowest.friend", "lowest.isPlayer", "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health < 15" }, "lowest" },
	--{ "Hand of Sacrifice", { "tank.exists", "tank.alive", "tank.friend", "tank.range <= 40", "tank.health < 75" }, "tank" }, --TODO: !tank.player
	--{ "Flash of Light", { "lowest.health < 50", "player.buff(Selfless Healer).count > 2" }, "lowest" }, -- T3
	--{ "Flash of Light", { "player.health < 70", "player.buff(Selfless Healer).count > 2", "player.buff(Bastion of Glory)" }, "player" }, -- T3
	
	-- Mouseovers
	{ "Light's Hammer", { "modifier.lalt" }, "ground" },
	{{
		{ "Hand of Freedom", { "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.root", "!mouseover.buff" }, "mouseover" },
		{ "Hand of Freedom", { "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.snare", "!mouseover.buff" }, "mouseover" },
		{ "Hand of Salvation", { "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "!mouseover.role(tank)", "@bbLib.highThreatOnPlayerTarget(mouseover)" }, "mouseover" },
		{ "Cleanse", { "!modifier.last(Cleanse)", "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.dispellable(Cleanse)" }, "mouseover" },
	}, {
		"toggle.mouseovers",
		"player.health > 50",
	}},
	
	-- DPS Rotation
	-- Single: (Shield of the Righteous if Sacred Duty or Inquisition active) > Inquisition > Crusader Strike > Avenger's Shield w/ Grand Crusader (HoPo) > Judgment > Avenger's Shield > Hammer of Wrath > Consecration > Holy Wrath
	-- Multi: Inquisition > Shield of the Righteous > Hammer of the Righteous > Consecration > Avenger's Shield > Holy Wrath > Hammer of Wrath > Judgment
	{ "Divine Plea", "player.holypower < 3" },
	{ "Avenging Wrath", "modifier.cooldowns" },
	{ "Crusader Strike", "!modifier.multitarget" },
	{{
		{ "Hammer of the Righteous" },
		{ "Consecration", { "!toggle.limitaoe", "!player.moving" } },
		{ "Avenger's Shield" },
		{ "Holy Wrath", { "!toggle.limitaoe", "!player.moving" } },
		{ "Hammer of Wrath", "!toggle.limitaoe" },
		{ "Judgement" },
	}, {
		"modifier.multitarget",
	}},
	{ "Avenger's Shield", { "player.buff(Grand Crusader)", "player.holypower < 3" } },
	{ "Judgement" },
	{ "Avenger's Shield" },
	{ "Hammer of Wrath", { "!toggle.limitaoe", "target.health <= 20" } },
	{ "Consecration", { "!toggle.limitaoe", "!player.moving" } },
	{ "Holy Wrath", { "!toggle.limitaoe", "!player.moving" } },
	
},{
-- OUT OF COMBAT ROTATION

	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Buffs
	-- Crusader Aura when mounted
	{ "Seal of Insight", "!player.buff(Seal of Insight)" },
	{ "Devotion Aura", "!player.buff(Devotion Aura)" },
	{ "Blessing of Kings", { "!player.buff(Blessing of Kings).any" } },
	{ "Blessing of Might", { "!player.buff(Blessing of Might).any", "!player.buff(Blessing of Kings)" } },

	-- Stance
	{ "Righteous Fury", "!player.buff(Righteous Fury)" },
  
},
function()
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Use Mouseovers', 'Automatically cast spells on mouseover targets')
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
end)
