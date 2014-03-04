-- ProbablyEngine Rotation Packager
-- Custom Restoration Shaman Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.library.register('coreHealing', {
	needsHealing = function(percent, count)
		return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
	end,
	needsDispelled = function(spell)
		for _, unit in pairs(ProbablyEngine.raid.roster) do
			if UnitDebuff(unit.unit, spell) then
				ProbablyEngine.dsl.parsedTarget = unit.unit
				return true
			end
		end
	end,
})

ProbablyEngine.rotation.register_custom(262, "bbRestorationShaman", { -- /dump GetTalentTabInfo(3)
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Healing Rain - Left Shift
-- NOTE: Set Focus target to tank, for: Earth Shield, Riptide, Lightning Bolt

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	--{ "pause", "@bbLib.bossMods" },
	--{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Racials 
	--{ "Stoneform", "player.health <= 65" },
	--{ "Gift of the Naaru", "player.health <= 70", "player" },
	--{ "Lifeblood", { "modifier.cooldowns", "player.spell(Lifeblood).cooldown < 1" }, "player" },
	
	-- Healing Rain Mouseover
	{ "Unleash Elements", "modifier.lshift" },
	{ "Healing Rain", "modifier.lshift", "ground" },
	
	-- Buffs
	{ "Earthliving Weapon", "!player.enchant.mainhand" },
	{ "Water Shield", "!player.buff" },
	
	-- Dispel
	--{ "Purify Spirit", "@coreHealing.needsDispelled('Aqua Bomb')" },
	
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

		-- Water
		{ "Healing Stream Totem", { "!player.totem(Mana Spring Totem)", "!player.totem(Healing Stream Totem)", "player.mana > 60" } },
		{ "Mana Spring Totem", { "!player.totem(Mana Spring Totem)", "!player.totem(Healing Stream Totem)", "!player.totem(Mana Tide Totem)", "player.mana < 60" } },
		-- Air
		{ "Wrath of Air Totem", { "!player.totem(Wrath of Air Totem)", "!player.totem(Windfury Totem)", "!player.buff(Mind Quickening).any", "!player.buff(Moonkin Aura).any", "!player.buff(Wrath of Air Totem).any" } },
		{ "Windfury Totem", { "!player.totem(Wrath of Air Totem)", "!player.totem(Windfury Totem)", "!player.buff(Hunting Party).any", "!player.buff(Windfury Totem).any" } },
	}, {
			"toggle.totems", 
			"!modifier.last(Call of the Elements)",
			"!player.moving",
	}},
	
	-- Cooldowns
	--{ "#gloves", { "modifier.cooldowns", "player.totem(Healing Tide Totem)" } },
	--{ "#gloves", { "modifier.cooldowns", "player.totem(Spirit Link Totem)" } },
	--{ "#gloves", { "modifier.cooldowns", "player.buff(Ascendance)" } },
	{ "Spirit Walker's Grace", { "modifier.cooldowns", "lowest.health < 40", "player.moving" } }, --2min
	--{ "Healing Stream Totem", { "!player.totem(Healing Tide Totem)", "!player.totem(Mana Tide Totem)" } },
	{ "Mana Tide Totem", { "modifier.cooldowns", "!player.buff(Mana Tide).any", "player.mana < 30" } }, --"!player.totem(Healing Stream Totem)", --3min
	{ "Spirit Link Totem", { "modifier.cooldowns", "!player.buff(Spirit Link Totem).any", "@coreHealing.needsHealing(45, 3)" } }, --3min
	
	-- Focus Healing
	{{
		{ "Earth Shield", "!focus.buff(Earth Shield).any", "focus" },
		{ "Riptide", { "!focus.buff(Riptide)" }, "focus" },
		{ "Ancestral Swiftness", "focus.health < 25" },
		{ "Greater Healing Wave", { "focus.health < 25", "player.buff(Nature's Swiftness)" }, "focus" },
		{ "Healing Surge", "focus.health < 25", "focus" },
		{ "Unleash Elements", { "focus.health < 65" } },
		{ "Greater Healing Wave", { "focus.health < 65", "player.buff(Unleash Life)" }, "focus" },
	}, {
		"focus.exists", "focus.alive",
	}},
	
	-- Raid Healing
	{ "Ancestral Swiftness", "lowest.health < 25" },
	{ "Greater Healing Wave", { "lowest.health < 25", "player.buff(Nature's Swiftness)" }, "lowest" },
	{ "Healing Surge", "lowest.health < 30", "lowest" }, -- only if you feel that the target will die before you have a chance to complete a Greater Healing Wave
	{ "Riptide", { "!lowest.buff(Riptide)", "lowest.health < 99" }, "lowest" },
	--{ "Greater Healing Wave", "@coreHealing.needsDispelled(Chomp)" },
	{ "Greater Healing Wave", "lowest.health < 50", "lowest" },
	{ "Greater Healing Wave", { "lowest.health < 65", "player.buff(Tidal Waves).count = 2" }, "lowest" },
	{ "Greater Healing Wave", { "focus.health < 65" }, "focus" },
	{ "Chain Heal", { "modifier.multitarget", "lowest.health < 98" }, "lowest" }, -- "@coreHealing.needsHealing(80, 3)"
	{ "Healing Wave", { "!modifier.multitarget", "lowest.health < 98" }, "lowest" }, -- Do not use on tank, use greater
	
	-- Interrupt
	--{ "Quaking Palm", "modifier.interrupts" }, -- Pandaren Racial
	{ "Wind Shear", "modifier.interruptAt(60)" },

	-- DPS Rotation
	{ "Lightning Bolt", { "toggle.dpsmode", "focus.exists", "focustarget.exists", "focustarget.enemy", "focustarget.range < 40", "!modifier.last(Lightning Bolt)" }, "focustarget" }, --"player.glyph(Glyph of Telluric Currents)",
	{{
		{ "Wind Shear", { "focustarget.exists", "focus.friend", "focustarget.casting", "focustarget.range <= 25" }, "focustarget" }, -- Interrupt focustarget TODO: Change to interruptAt
		{ "Fire Elemental Totem", { "modifier.cooldowns", "target.boss", "!player.totem(Fire Elemental Totem)" } }, -- Check for int buffs and cooldowns before casting
		{ "Searing Totem", { "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
		{ "Flame Shock", { "focustarget.exists", "!focustarget.debuff(Flame Shock)", "focustarget.deathin > 20" }, "focustarget" },
		{ "Lava Burst", { "focustarget.exists", "focustarget.debuff(Flame Shock)" }, "focustarget" },
	}, {
		"toggle.dpsmode",
		"player.mana > 70",
	}},
	
	-- Auto Follow
	{ "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "focus.spell(Water Walking).range", "!focus.spell(Primal Strike).range" } }, -- TODO: NYI: isFollowing()
	
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Buffs
	{ "Earthliving Weapon", "!player.enchant.mainhand" },
	{ "Water Shield", "!player.buff" },
	
	-- Focus
	{ "Earth Shield", { "focus.exists", "focus.friend", "focus.alive", "!focus.buff(Earth Shield).any" }, "focus" },
	{ "Riptide", { "focus.exists", "focus.friend", "focus.alive", "focus.combat", "!focus.buff(Riptide)" }, "focus" },
	
	-- Heal
	{ "Healing Stream Totem", { "toggle.totems", "!player.moving", "!player.totem(Mana Spring Totem)", "!player.totem(Healing Stream Totem)", "player.health < 90" } },
	{ "Mana Spring Totem", { "toggle.totems", "!player.moving", "!player.totem(Mana Spring Totem)", "!player.totem(Healing Stream Totem)", "player.mana < 80" } },
	{ "Healing Surge", { "!player.moving", "lowest.health < 30" }, "lowest" },
	{ "Greater Healing Wave", { "!player.moving", "lowest.health < 60" }, "lowest" },
	{ "Healing Wave", { "!player.moving", "lowest.health < 90" }, "lowest" },
	
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
	ProbablyEngine.toggle.create('dpsmode', 'Interface\\Icons\\ability_dualwield', 'DPS Mode', 'Toggle the usage of damage dealing abilities.')
end)
