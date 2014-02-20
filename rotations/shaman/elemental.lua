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
	{ "Flame Shock", { "mouseover.enemy", "mouseover.alive", "@bbLib.notAboutToDie(target)", "mouseover.debuff(Flame Shock).duration <= 3", "toggle.mouseovers" }, "mouseover" },

	-- Moving Rotation
	{ "Lightning Bolt", { "player.moving", "!player.buff(Spiritwalker's Grace)" } },

	-- PvP
	--{ "Thunderstorm", { "modifier.enemies >= 6", "modifier.multitarget" } },
	
	-- Totems
	{ "Call of the Elements", { "toggle.totems", "player.time < 3", "!modifier.last(Call of the Elements)" } },
	-- { "Healing Stream Totem", { "toggle.totems", "!totem(Healing Stream Totem)", "player.mana > 90" } },
	-- { "Mana Spring Totem", { "toggle.totems", "!totem(Mana Spring Totem)", "player.mana < 90" } },
	
	-- Cooldowns
	--{ "Fire Elemental Totem", { "toggle.totems", "modifier.cooldowns", "target.boss" } },
	--{ "Elemental Mastery", { "modifier.cooldowns", "target.boss" } }, -- Not going on cooldown.
	
	-- Multi Target
	{{
		{ "Earth Shock", { "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count > 7" } },
		{ "Chain Lightning" },
		-- Earthquake is optional but if you're specced into it, use it when there's 5 or more targets.
	}, {
		"modifier.multitarget",
	}},

	-- Single Target
	-- 1) Searing Totem. Fire Elemental totem if have all spellpower procs/cooldowns ready and you can drop it on the boss.
	--{ "Searing Totem", { "toggle.totems", "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
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
	--{ "Healing Stream Totem", { "toggle.totems", "player.health < 80" } },
	
	-- Pull Totems
	--{ "Totemic Recall", { "toggle.totems", "player.moving", "!modifier.last(Totemic Recall)" } }, -- player.totems
	
	-- Ghost Wolf
	{ "Ghost Wolf", { "!player.buff(Ghost Wolf)", "player.moving", "!modifier.last(Ghost Wolf)" } },
	
	-- Auto Follow
	{ "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "focus.spell(Water Walking).range", "!focus.spell(Primal Strike).range" } }, -- TODO: NYI: isFollowing()
},
function()
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('totems', 'Interface\\Icons\\ability_shaman_multitotemactivation', 'Auto Totem', 'Automaticaly use and recall totems.')
	ProbablyEngine.toggle.create('autofollow', 'Interface\\Icons\\achievement_guildperk_everybodysfriend', 'Auto Follow', 'Automaticaly follows your focus target. Must be another player.')
end)
