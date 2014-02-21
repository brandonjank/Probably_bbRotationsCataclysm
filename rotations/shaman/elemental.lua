-- ProbablyEngine Rotation Packager
-- Custom Elemental Shaman Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.rotation.register_custom(261, "bbElementalShaman", { -- /dump GetTalentTabInfo(2)
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	--{ "pause", "@bbLib.bossMods" },
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Buffs
	{ "Flametongue Weapon", "!player.enchant.mainhand" },
	{ "Lightning Shield", "!player.buff(Lightning Shield)" },

	-- Interrupt
	{ "Wind Shear", "modifier.interruptAt(60)" },

	-- Mouseovers
	{ "Flame Shock", { "mouseover.enemy", "mouseover.combat", "mouseover.alive", "@bbLib.notAboutToDie(target)", "mouseover.debuff(Flame Shock).duration <= 3", "toggle.mouseovers" }, "mouseover" },

	-- Moving Rotation
	{ "Lightning Bolt", { "player.moving", "!player.buff(Spiritwalker's Grace)", "player.spell(Unleashed Lightning).exists" } }, -- Need Unleashed Lightning Glyph for moving lighting bolts.

	-- PvP
	--{ "Thunderstorm", { "modifier.enemies >= 6", "modifier.multitarget" } },

	-- Cooldowns
	{ "Elemental Mastery", { "modifier.cooldowns", "target.boss", "!player.buff(Elemental Mastery)", "player.time < 3"  } }, -- Broken. Not showing on cooldown when cast. OFF GCD
	-- Spiritwalker's Grace when moving for more than 2-3seconds. OFF GCD
		
	-- Totems
	{{
		{ "Call of the Elements", "player.time < 3" },
		-- Earth
		{ "Tremor Totem", { "!player.totem(Tremor Totem)", "player.state.fear" } },
		{ "Tremor Totem", { "!player.totem(Tremor Totem)", "player.state.charm" } },
		{ "Tremor Totem", { "!player.totem(Tremor Totem)", "player.state.sleep" } },
		{ "Stoneskin Totem", {  "!player.totem(Stoneskin Totem)", "!player.totem(Strength of Earth Totem)", "!player.totem(Tremor Totem)", "!player.totem(Stoneclaw Totem)", "!player.buff(Stoneskin).any" } },
		{ "Strength of Earth Totem", { "!player.totem(Stoneskin Totem)", "!player.totem(Strength of Earth Totem)", "!player.totem(Tremor Totem)", "!player.totem(Stoneclaw Totem)", "!player.buff(Horn of Winter).any", "!player.buff(Battle Shout).any", "!player.buff(Roar of Courage).any", "!player.buff(Strength of Earth).any" } },
		{ "Stoneclaw Totem", { "!player.totem(Stoneskin Totem)", "!player.totem(Strength of Earth Totem)", "!player.totem(Tremor Totem)", "!player.totem(Stoneclaw Totem)" } },
		-- Fire
		{ "Fire Elemental Totem", { "modifier.cooldowns", "target.boss", "!player.totem(Fire Elemental Totem)" } }, -- Check for int buffs and cooldowns before casting
		{ "Searing Totem", { "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
		-- Water
		{ "Healing Stream Totem", { "!player.totem(Mana Spring Totem)", "!player.totem(Healing Stream Totem)", "player.mana > 60" } },
		{ "Mana Spring Totem", { "!player.totem(Mana Spring Totem)", "!player.totem(Healing Stream Totem)", "player.mana < 60" } },
		-- Air
		{ "Wrath of Air Totem", { "!player.totem(Wrath of Air Totem)", "!player.totem(Windfury Totem)", "!player.buff(Mind Quickening).any", "!player.buff(Moonkin Aura).any", "!player.buff(Wrath of Air Totem).any" } },
		{ "Windfury Totem", { "!player.totem(Wrath of Air Totem)", "!player.totem(Windfury Totem)", "!player.buff(Hunting Party).any", "!player.buff(Windfury Totem).any" } },
	}, {
			"toggle.totems", 
			"!modifier.last(Call of the Elements)",
			"!player.moving",
	}},
	
	-- Multi Target
	{{
		{ "Earth Shock", { "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count > 7" } },
		{ "Chain Lightning" },
		-- Earthquake is optional but if you're specced into it, use it when there's 5 or more targets.
	}, {
		"modifier.multitarget",
	}},

	-- Single Target
	{ "Flame Shock", "target.debuff(Flame Shock).duration <= 3" },
	{ "Lava Burst", "target.debuff(Flame Shock)" },
	{ "Earth Shock", { "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count > 7", "target.debuff(Flame Shock).duration >= 6" } },
	{ "Lightning Bolt" },
	
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },
	
	-- Buffs
	{ "Flametongue Weapon", "!player.enchant.mainhand" },
	{ "Lightning Shield", "!player.buff(Lightning Shield)" },

	-- Heal
	{ "Healing Stream Totem", { "toggle.totems", "!player.moving", "!player.totem(Mana Spring Totem)", "!player.totem(Healing Stream Totem)", "player.health < 90" } },
	{ "Mana Spring Totem", { "toggle.totems", "!player.moving", "!player.totem(Mana Spring Totem)", "!player.totem(Healing Stream Totem)", "player.mana < 80" } },
	{ "Healing Surge", { "!player.moving", "player.health < 30" }, "player" },
	{ "Greater Healing Wave", { "!player.moving", "player.health < 60" }, "player" },
	{ "Healing Wave", { "!player.moving", "player.health < 90" }, "player" },
	
	-- Pull Totems
	--{ "Totemic Recall", { "toggle.totems", "player.moving", "!modifier.last(Totemic Recall)" } }, -- player.totems
	
	--{ "Water Walking", { "swimming", "!player.buff(Water Walking)" }, "player" },
	--{ "Water Breathing", { "swimming", "!player.buff(Water Breathing)" }, "player" },
	
	-- Ghost Wolf
	{ "Ghost Wolf", { "!player.buff(Ghost Wolf)", "player.moving", "!modifier.last(Ghost Wolf)" } },
	
	-- Auto Follow
	{ "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "focus.spell(Water Walking).range", "!focus.spell(Primal Strike).range" } }, -- TODO: NYI: isFollowing()
	
},
function()
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	ProbablyEngine.toggle.create('totems', 'Interface\\Icons\\ability_shaman_multitotemactivation', 'Auto Totem', 'Automaticaly use and recall totems.') -- change icon
	ProbablyEngine.toggle.create('autofollow', 'Interface\\Icons\\achievement_guildperk_everybodysfriend', 'Auto Follow', 'Automaticaly follows your focus target. Must be another player.')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
end)
